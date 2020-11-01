import SwiftUI

struct GameListItem: View {
    @ObservedObject var game: Game
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
        if game.selected {
            VStack {
                Image("game")
                    .resizable()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.2)
                    .padding([.top, .leading, .trailing], 20)
                Text(self.game.name)
                    .fontWeight(.medium)
                    .padding(10)
                    .font(.title3)
            }
            .foregroundColor(Color("Black"))
            .background(Color("Grey"))
            .cornerRadius(25.0)
            .overlay(
                ZStack {
                    Rectangle()
                        .fill(Color("Green").opacity(0.5))
                        .frame(width: screenWidth * 0.5, height: screenWidth * 0.4)
                        .cornerRadius(25)
                    Image("check")
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            )
        } else {
            VStack {
                Image("game")
                    .resizable()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.2)
                    .padding([.top, .leading, .trailing], 20)
                Text(self.game.name)
                    .fontWeight(.medium)
                    .padding(10)
                    .font(.title3)
            }
            .foregroundColor(Color("Black"))
            .background(Color("Grey"))
            .cornerRadius(25.0)
        }
    }
}

struct GameListItem_Previews: PreviewProvider {
    static var previews: some View {
        GameListItem(game: Game(gameId: "1", name: "Cool game", rules: "multiple rules"))
    }
}
