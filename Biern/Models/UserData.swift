import Foundation

class UserData: ObservableObject {
    @Published var username: String = "" {
        didSet {
            if username.count > 12 {
                username = String(username.prefix(12))
            }
        }
    }
}
