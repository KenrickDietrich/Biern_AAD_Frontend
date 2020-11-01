import UIKit

class Game: ObservableObject {
    @Published var gameId: String = ""
    @Published var name: String = ""
    @Published var rules: String = ""
    @Published var selected: Bool = false

    init(gameId: String, name: String, rules: String) {
        self.gameId = gameId
        self.name = name
        self.rules = rules
    }
}

extension Game: Equatable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.gameId == rhs.gameId
    }
}
