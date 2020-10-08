import Foundation

class DataProvider: ObservableObject {
    @Published var parties = [PartyData]()
    @Published var games = [Game]()

    func fetchParties() {
        // fetch all parties
    }

    func fetchGames() {
        // fetch all games from API
//        self.games.append(Game(gameId: 1, name: "Game 1", rules: "The rules of the game 1"))
//        self.games.append(Game(gameId: 2, name: "Game 2", rules: "The rules of the game 1"))
//        self.games.append(Game(gameId: 3, name: "Game 3", rules: "The rules of the game 1"))
//        self.games.append(Game(gameId: 4, name: "Game 3", rules: "The rules of the game 1"))
//        self.games.append(Game(gameId: 5, name: "Game 3", rules: "The rules of the game 1"))
        self.games.append(Game(name: "Game 1", rules: "The rules of the game 1"))
        self.games.append(Game(name: "Game 1", rules: "The rules of the game 1"))
        self.games.append(Game(name: "Game 1", rules: "The rules of the game 1"))
        self.games.append(Game(name: "Game 1", rules: "The rules of the game 1"))

    }
}
