import UIKit

class Game: ObservableObject {
    @Published var gameId = UUID()
    @Published var name: String = ""
    @Published var rules: String = ""
//    @Published fileprivate var image: String

    init(name: String, rules: String) {
        self.name = name
        self.rules = rules
    }
}
