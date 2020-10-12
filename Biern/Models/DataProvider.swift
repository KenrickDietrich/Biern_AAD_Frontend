import Foundation

class DataProvider: ObservableObject {
    @Published var parties: [PartyData] = []
    @Published var games = [Game]()

    func fetchParties() {
        // fetch all parties from API
        self.parties.append(PartyData(partyCode: "party code", users: ["Jan", "Willem", "Bram", "Piet"]))
        self.parties.append(PartyData(partyCode: "party code", users: ["Jan", "Willem", "Bram", "Piet"]))
    }

    func fetchGames() {
        // fetch all games from API
        self.games.append(Game(gameId: 1, name: "Game 1", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 2, name: "Game 2", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 3, name: "Game 3", rules: "The rules of the game 1"))
    }
}
