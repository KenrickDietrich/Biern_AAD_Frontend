import Foundation

class DataProvider: ObservableObject {
    @Published var parties: [Party] = []
    @Published var games = [Game]()

    init () {

    }

    func fetchParties() {
        self.parties.append(Party(partyCode: "party code", users: ["Jan", "Willem", "Bram", "Piet"],
                                  settings: Setting(difficulty: 2)))
        self.parties.append(Party(partyCode: "party code", users: ["Jan", "Willem", "Bram", "Piet"],
                                  settings: Setting(difficulty: 3)))
        // fetch all parties
    }

    func fetchGames() {
        self.games.append(Game(gameId: 1, name: "Game 1", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 2, name: "Game 2", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 3, name: "Game 3", rules: "The rules of the game 1"))

        // fetch all games from API
    }
}
