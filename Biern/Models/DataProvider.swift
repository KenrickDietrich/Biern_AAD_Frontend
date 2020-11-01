import Foundation

// data provider class with all api calls
// list of all games, party of user
// user, api url, token
// alert and reason for saving error response
class DataProvider: ObservableObject {
    @Published var games: [Game] = []
    @Published var party = Party()
    @Published var user = User()
    @Published var URL: String = "https://drinkapi.herokuapp.com/"
    @Published var token = ""
    @Published var alert = false
    @Published var reason = ""

    // creates routes to api
    func createRoute(endPoint: String, httpMethod: String) throws -> URLRequest {
        // build route with string and endpoint
        guard let url = Foundation.URL(string: self.URL + endPoint) else {
            throw HTTPError.cantCreateRoute
        }
        // create request
        var request = URLRequest(url: url)
        // define headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        return request
    }

    // login method to send request for bearer token
    func login() {
        // reset error values
        self.reason = ""
        self.alert = false
        // create request POST to /login
        let loginRequest = try? self.createRoute(endPoint: "login", httpMethod: "POST")
        // create session and send request
        let session = URLSession.shared
        let task = session.dataTask(with: loginRequest!) { (data, _, _) in
            // check if data was recieved
            guard let responseData = data else {
                return
            }
            // parse the result as JSON
            do {
                guard let receivedToken = try JSONSerialization.jsonObject(with: responseData) as? NSDictionary else {
                    return
                }
                // check if response has error reason
                // else set token
                DispatchQueue.main.async {
                    if receivedToken.value(forKey: "reason") != nil {
                        self.reason = (receivedToken.value(forKey: "reason") as? String)!
                        self.alert = true
                    } else {
                        self.token = (receivedToken.value(forKey: "token") as? String)!
                    }
                }
            } catch {
                return
            }
        }
        // resume thread
        task.resume()
    }

    // fetch all games
    func fetchGames() {
        // create GET request to /game
        let gamesRequest = try? self.createRoute(endPoint: "game", httpMethod: "GET")
        // create session and send request
        let session = URLSession.shared
        let task = session.dataTask(with: gamesRequest!) { (data, _, _) in
            // check if data was recieved
            guard let responseData = data else {
                return
            }
            // parse the result as JSON
            do {
                guard let receivedGames = try JSONSerialization.jsonObject(with: responseData) as? NSArray else {
                    return
                }
                // loop trough response and add all the games to the games list
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
                return
            }
        }
        // resume thread
        task.resume()
    }

    // create user
    func createUser() {
        // create a POST request to /user
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
        let task = session.dataTask(with: createUserRequest!) { (data, _, _) in
            // check if data was recieved
            guard let responseData = data else {
                return
            }
            // parse the result as JSON
            do {
                guard let receivedUser = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
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
                return
            }
        }
        // resume thread
        task.resume()
    }

    // create party
    func createParty() {
        // create POST request to /party
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
        let task = session.dataTask(with: createPartyRequest!) { (data, _, _) in
            guard let responseData = data else {
                return
            }
            // parse the result as JSON
            do {
                guard let receivedParty = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
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
                // loop through response users and add to users from party
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
                            self.party.users = [self.user]
                        }
                    }
                }
            } catch {
                return
            }
        }
        // resume thread
        task.resume()
    }

    // set selected games
    func setSelectedGames() {
        // create POST request /party/{party_id}/games
        guard let url = Foundation.URL(string: self.URL + "party/" + self.party.partyId + "/games") else { return }
        var request = URLRequest(url: url)
        // set header information
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        // create the party object
        var selectedGames: [String: Any] = [:]
        // check if selected games from party is empty
        if !self.party.selectedGames.isEmpty {
            selectedGames = ["selected_games": ["id": self.party.selectedGames[0].gameId,
                                                "name": self.party.selectedGames[0].name,
                                                "rules": self.party.selectedGames[0].name]]
        } else {
            selectedGames = ["selected_games": []]
        }
        // serialize the party object and add it to body
        do {
            let jsonSelectedGames: Data = try JSONSerialization.data(withJSONObject: selectedGames)
            request.httpBody = jsonSelectedGames
        } catch {
            return
        }
        // create session and send request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, _) in
            guard data != nil else {
                return
            }
        }
        // resume thread
        task.resume()
    }

    // set settings
    func setSettings() {
        // create POST request to /party/{party_id}/setting
        guard let url = Foundation.URL(string: self.URL + "party/" + self.party.partyId + "/setting") else { return }
        var request = URLRequest(url: url)
        // set header information
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        // create the setting object
        let settings: [String: Any] = ["difficulty": self.party.settings.difficulty,
                                       "show_names": self.party.settings.showNames]
        // serialize the setting object and add it to body
        do {
            let jsonSettings: Data = try JSONSerialization.data(withJSONObject: settings)
            request.httpBody = jsonSettings
        } catch {
            return
        }
        // create session and send request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, _) in
            guard data != nil else {
                return
            }
        }
        // resume thread
        task.resume()
    }
}
