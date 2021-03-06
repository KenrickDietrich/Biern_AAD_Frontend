import SwiftUI

struct ChooseGameView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // global data provider recieved from parent
    @ObservedObject var data: DataProvider
    // presentation mode to dismiss wrapped value and navigate back
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationItemContainer {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    Text("Choose games")
                        .font(.title2)
                        .fontWeight(.medium)
                    ScrollView(.vertical) {
                        ForEach(self.data.games, id: \.gameId) {game in
                            Button(action: {
                                addGame(game: game)
                            }, label: {
                                GameListItem(game: game).padding([.top, .leading, .trailing])
                            })
                        }
                    }.frame(width: screenWidth, height: screenHeight * 0.5)
                    NavigationButton {
                        Button(action: {
                            self.data.setSelectedGames()
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Save")
                                .fontWeight(.medium)
                        })
                    }.padding()
                }.padding(.top, 100.0)

            }.edgesIgnoringSafeArea(.all)
        }
    }
    func addGame(game: Game) {
        if self.data.party.selectedGames.isEmpty {
            self.data.party.selectedGames.append(game)
            game.selected = true
        } else if self.data.party.selectedGames.contains(game) {
            let index = self.data.party.selectedGames.firstIndex(of: game)!
            self.data.party.selectedGames.remove(at: index)
            game.selected = false
        } else {
            self.data.party.selectedGames.append(game)
            game.selected = true
        }
    }
}

struct ChooseGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChooseGameView(data: DataProvider())
    }
}
