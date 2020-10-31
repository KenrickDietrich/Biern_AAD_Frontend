import Foundation

class DataProvider: ObservableObject {
    @Published var games: [Game] = []
    @Published var party = Party()
    @Published var user = User()
    @Published var URL: String = "https://drinkapi.herokuapp.com/"

    // creates a route to api
    func createRoute(endPoint: String, httpMethod: String) throws -> URLRequest {
        guard let url = Foundation.URL(string: self.URL + endPoint) else {
            throw HTTPError.cantCreateRoute
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        return request
    }

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
                            let gameId = dict.value(forKey: "id")
                            let name = dict.value(forKey: "name")
                            let rules = dict.value(forKey: "rules")
                            let game = Game(gameId: gameId, name: name, rules: rules)
                            self.games.append(game)
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

    func createUser() {
        var createUserRequest = try? self.createRoute(endPoint: "user", httpMethod: "POST")
        let newUser: [String: Any] = ["username": self.user.username, "is_ready": false]
        let jsonUser: Data
        do {
            jsonUser = try JSONSerialization.data(withJSONObject: newUser, options: [])
            createUserRequest?.httpBody = jsonUser
        } catch {
            print("Error: cannot create JSON from user")
            return
        }
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
                DispatchQueue.main.async {
                    // set new user id of user
                    self.user.userId = userId
                }
            } catch {
                print("Error: parsing response from POST on /user")
                return
            }
        }
        task.resume()
    }

    func createParty() {
        var createPartyRequest = try? self.createRoute(endPoint: "party", httpMethod: "POST")
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
        let jsonParty: Data
        do {
            jsonParty = try JSONSerialization.data(withJSONObject: newParty)
            createPartyRequest?.httpBody = jsonParty
        } catch {
            print("Error: cannot create JSON from party")
            return
        }
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
                guard let partyCode = receivedParty["party_code"] as? String else {
                    return
                }
                guard let partyUsers = receivedParty["users"] as? NSArray else {
                    print("whoops")
                    return
                }
                guard let partyGames = receivedParty["selected_games"] as? NSArray else {
                    print("whoops")
                    return
                }
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
                    print("yeeee")
                    for game in partyGames {
                        if let dict = game as? NSDictionary {
                            let gameId = dict.value(forKey: "id")
                            print(gameId)
                        }
                    }
                    print("yeeee")
                }
            } catch {
                print("Error: parsing response from POST on /user")
                return
            }
        }
        task.resume()
    }
}
