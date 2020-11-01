import UIKit

// game class with id, name, rules and if it is selected.
class Game: ObservableObject {
    @Published var gameId: String = ""
    @Published var name: String = ""
    @Published var rules: String = ""
    @Published var selected: Bool = false

    // game constructor
    init(gameId: String, name: String, rules: String) {
        self.gameId = gameId
        self.name = name
        self.rules = rules
    }
}

// makes Game object comparable with another game
extension Game: Equatable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.gameId == rhs.gameId
    }
}
