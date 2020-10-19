import SwiftUI

struct ChooseGameView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var data: DataProvider
    @ObservedObject var party: Party
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
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Save")
                                .fontWeight(.medium)
                        })
                    }.padding()
                }.padding(.top, 100.0)

            }.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                self.data.fetchGames()
            })
        }
    }
    func addGame(game: Game) {
        if self.party.selectedGames.isEmpty {
            self.party.selectedGames.append(game)
            game.selected = true
        } else if self.party.selectedGames.contains(game) {
            let index = self.party.selectedGames.firstIndex(of: game)!
            self.party.selectedGames.remove(at: index)
            game.selected = false
        } else {
            self.party.selectedGames.append(game)
            game.selected = true
        }
    }
}

struct ChooseGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChooseGameView(data: DataProvider(), party: Party())
    }
}
