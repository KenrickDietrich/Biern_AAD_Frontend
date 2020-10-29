import Foundation

class DataProvider: ObservableObject {
    @Published var games = [Game]()
    @Published var party = Party()
    @Published var user = User()
    @Published var URL: String = "https://drinkapi.herokuapp.com/"

    func createRoute(endPoint: String) throws -> URLRequest {
        guard let url = Foundation.URL(string: self.URL + endPoint) else {
            throw HTTPError.cantCreateRoute
        }
        return URLRequest(url: url)
    }

    func createUser() {
        var createUserRequest = try? self.createRoute(endPoint: "user")
        createUserRequest?.httpMethod = "POST"
        createUserRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
              guard let receivedUser = try JSONSerialization.jsonObject(with: responseData,
                options: []) as? [String: Any] else {
                  print("Error: Could not get JSON from responseData as dictionary")
                  return
              }
              // check if recieved object has id
              guard let userId = receivedUser["id"] as? String else {
                return
              }
              // set new user id of user
              self.user.userId = userId
            } catch {
              print("Error: parsing response from POST on /user")
              return
            }
        }
        task.resume()
    }

    func createParty() {
        var createPartyRequest = try? self.createRoute(endPoint: "party")
        createPartyRequest?.httpMethod = "POST"
        createPartyRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newParty: [String: Any] = ["host_id": self.user,
                                       "party_code": self.party.partyCode,
                                       "is_active": self.party.isActive,
                                       "settings": Settings(),
                                       "users": [self.user],
                                       "selected_games": []
        ]
        let jsonUser: Data
        do {
            jsonUser = try JSONSerialization.data(withJSONObject: newParty)
            createPartyRequest?.httpBody = jsonUser
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
            guard data != nil else {
                print("Error: did not receive data")
                return
            }
        }
        task.resume()
    }

}
