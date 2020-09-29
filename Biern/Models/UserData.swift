import Foundation

class UserData: ObservableObject {
    @Published var username: String = "" {
        didSet {
            if username.count > 16 {
                username = String(username.prefix(16))
            }
        }
    }
}
