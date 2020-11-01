import Foundation

class DataProvider: ObservableObject {
    @Published var games: [Game] = []
    @Published var party = Party()
    @Published var user = User()
    @Published var URL: String = "https://drinkapi.herokuapp.com/"

    // creates routes to api
    func createRoute(endPoint: String, httpMethod: String) throws -> URLRequest {
        guard let url = Foundation.URL(string: self.URL + endPoint) else {
            throw HTTPError.cantCreateRoute
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        return request
    }

    // fetch all games
    func fetchGames() {
        let gamesRequest = try? self.createRoute(endPoint: "game", httpMethod: "GET")
        let session = URLSession.shared
        let task = session.dataTask(with: gamesRequest!) { (data, _, error) in
            // check if there were no errors
            guard error == nil else {
                print("Error: calling POST on /user")
                return
            }
            // check if data was recieved
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON
            do {
                guard let receivedGames = try JSONSerialization.jsonObject(with: responseData) as? NSArray else {
                    print("Error: Could not get JSON from responseData as array")
                    return
                }
                DispatchQueue.main.async {
                    for game in receivedGames {
                        if let dict = game as? NSDictionary {
                            // get values from dictionary
                            let gameId = (dict.value(forKey: "id") as? String)!
                            let name = (dict.value(forKey: "name") as? String)!
                            let rules = (dict.value(forKey: "rules") as? String)!
                            self.games.append(Game(gameId: gameId, name: name, rules: rules))
                        }
                    }
                }
            } catch {
                print("Error: parsing response from POST on /user")
                return
            }
        }
        task.resume()
    }

    // create user
    func createUser() {
        // create a post request with endpoint user
        var createUserRequest = try? self.createRoute(endPoint: "user", httpMethod: "POST")
        // create the user object
        let newUser: [String: Any] = ["username": self.user.username, "is_ready": false]
        
        // serialize the user object and add it to body
        do {
            let jsonUser: Data = try JSONSerialization.data(withJSONObject: newUser, options: [])
            createUserRequest?.httpBody = jsonUser
        } catch {
            return
        }
        // create session and send request
        let session = URLSession.shared
        let task = session.dataTask(with: createUserRequest!) { (data, _, error) in
            // check if there were no errors
            guard error == nil else {
                print("Error: calling POST on /user")
                return
            }
            // check if data was recieved
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON
            do {
                guard let receivedUser = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                    print("Error: Could not get JSON from responseData as dictionary")
                    return
                }
                // check if recieved object has id
                guard let userId = receivedUser["id"] as? String else {
                    return
                }
                // set new user id of user
                DispatchQueue.main.async {
                    self.user.userId = userId
                }
            } catch {
                print("Error: parsing response from POST on /user")
                return
            }
        }
        task.resume()
    }

    // create party
    func createParty() {
        // create a post request with endpoint party
        var createPartyRequest = try? self.createRoute(endPoint: "party", httpMethod: "POST")
        // create the party object
        let newParty: [String: Any] = ["host_id": self.user.userId,
                                       "party_code": self.party.partyCode,
                                       "is_active": self.party.isActive,
                                       "settings": ["difficulty": self.party.settings.difficulty,
                                                    "show_names": self.party.settings.showNames],
                                       "users": [["id": self.user.userId,
                                                  "username": self.user.username,
                                                  "is_ready": self.user.isReady]],
                                       "selected_games": []
        ]
        // serialize the party object and add it to body
        do {
            let jsonParty: Data = try JSONSerialization.data(withJSONObject: newParty)
            createPartyRequest?.httpBody = jsonParty
        } catch {
            return
        }
        // create session and send request
        let session = URLSession.shared
        let task = session.dataTask(with: createPartyRequest!) { (data, _, error) in
            guard error == nil else {
                print("Error: calling POST on /party")
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON
            do {
                guard let receivedParty = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                    print("Error: Could not get JSON from responseData as dictionary")
                    return
                }
                // check if recieved object has id
                guard let partyId = receivedParty["id"] as? String else {
                    return
                }
                // check if recieved object has party code
                guard let partyCode = receivedParty["party_code"] as? String else {
                    return
                }
                // check if recieved object has users
                guard let partyUsers = receivedParty["users"] as? NSArray else {
                    return
                }
                // set data from the response in party
                DispatchQueue.main.async {
                    self.party.partyId = partyId
                    self.party.partyCode = partyCode
                    for user in partyUsers {
                        if let dict = user as? NSDictionary {
                            // get values from dictionary
                            let userId = dict.value(forKey: "id")
                            let username = dict.value(forKey: "username")
                            let isReady = dict.value(forKey: "is_ready")
                            // set the values on the user object
                            self.user.userId = (userId as? String)!
                            self.user.username = (username as? String)!
                            self.user.isReady = (isReady != nil)
                            // add user to the party
                            self.party.users.append(self.user)
                        }
                    }
                }
            } catch {
                return
            }
        }
        task.resume()
    }
}
