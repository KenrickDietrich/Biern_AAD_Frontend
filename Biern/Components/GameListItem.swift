import SwiftUI

struct GameListItem: View {
    @ObservedObject var game: Game
    var body: some View {
        HStack {
            Text(self.game.name)
        }
    }
}

struct GameListItem_Previews: PreviewProvider {
    static var previews: some View {
        GameListItem(game: Game(gameId: 5, name: "game name", rules: "de regels van het spel"))
    }
}
