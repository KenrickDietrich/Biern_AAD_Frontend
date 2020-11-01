import Foundation

class User: ObservableObject {
    @Published var userId = ""
    @Published var isReady = false
    @Published var username: String = "" {
        didSet {
            if username.count > 12 {
                username = String(username.prefix(12))
            }
        }
    }
}
