import SwiftUI

struct GameListItem: View {
    @ObservedObject var game: Game
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height

    var body: some View {
        VStack {
            Image("crown")
                .resizable()
                .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
            Text(self.game.name)
            Text(self.game.gameId.uuidString)
        }
        .padding(50)
        .background(Color.gray)
        .cornerRadius(25.0)
        .overlay(
            RoundedRectangle(cornerRadius: 25.0)
                .stroke()
        )
    }
}

struct GameListItem_Previews: PreviewProvider {
    static var previews: some View {
        GameListItem(game: Game(name: "game name", rules: "de regels van het spel"))
    }
}
