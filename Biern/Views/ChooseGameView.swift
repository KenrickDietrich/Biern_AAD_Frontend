import SwiftUI

struct ChooseGameView: View {
    @ObservedObject var data: DataProvider

    var body: some View {
        VStack {
            List(self.data.games, id: \.gameId) {game in
                GameListItem(game: game)
            }
        }.onAppear(perform: {
            self.data.fetchGames()
        })
    }
}

struct ChooseGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChooseGameView(data: DataProvider())
    }
}
