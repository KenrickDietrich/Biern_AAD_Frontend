import Foundation

class User: ObservableObject {
    @Published var userId = UUID()
    @Published var isReady = false
    @Published var URL: String = "https://drinkapi.herokuapp.com/"
    @Published var username: String = "" {
        didSet {
            if username.count > 12 {
                username = String(username.prefix(12))
            }
        }
    }

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
        let newUser: [String: Any] = ["username": self.username, "is_ready": false, "party": ["id": NSNull()]]
        let jsonUser: Data
        do {
            jsonUser = try JSONSerialization.data(withJSONObject: newUser, options: [])
            createUserRequest?.httpBody = jsonUser
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: createUserRequest!) { (data, _, error) in
            guard error == nil else {
                print("Error: calling POST on /user")
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
