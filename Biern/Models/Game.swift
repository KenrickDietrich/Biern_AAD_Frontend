import UIKit

class Game: ObservableObject {
    @Published var gameId: Int
    @Published var name: String = ""
    @Published var rules: String = ""
//    @Published fileprivate var image: String

    init(gameId: Int, name: String, rules: String) {
        self.gameId = gameId
        self.name = name
        self.rules = rules
    }
}
