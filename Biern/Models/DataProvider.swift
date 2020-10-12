import Foundation

class DataProvider: ObservableObject {
    @Published var parties: [Party] = []
    @Published var games = [Game]()

    func fetchParties() {
        // fetch all parties from API
        self.parties.append(Party())
        self.parties.append(Party())
    }

    func fetchGames() {
        // fetch all games from API
        self.games.append(Game(gameId: 1, name: "Game 1", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 2, name: "Game 2", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 3, name: "Game 3", rules: "The rules of the game 1"))
    }
}
