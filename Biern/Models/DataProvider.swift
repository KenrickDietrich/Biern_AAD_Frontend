import Foundation

class DataProvider: ObservableObject {
    @Published var parties = [PartyData]()
    @Published var games = [Game]()

    init () {

    }

    func fetchParties() {
        self.parties.append(PartyData(partyCode: "party code"))
        // fetch all parties
    }

    func fetchGames() {
        self.games.append(Game(gameId: 1, name: "Game 1", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 2, name: "Game 2", rules: "The rules of the game 1"))
        self.games.append(Game(gameId: 3, name: "Game 3", rules: "The rules of the game 1"))

        // fetch all games from API
    }
}
