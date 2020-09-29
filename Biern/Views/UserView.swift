import SwiftUI

struct UserView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("arrow-right")
                    .aspectRatio(contentMode: .fit)
                }
            }
    }
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    HStack {
                        Text("Hallo, " + "\(self.userData.username)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .padding(5.0)
                    .frame(width: screenWidth * 0.6)
                    .padding(.bottom, 30.0)
                    HStack {
                    //Change BackgroundCardComponent to next view
                    NavigationLink(destination: BackgroundCardComponent()) {
                        Text("Create game")
                    }
                    .padding(8.0)
                    .background(Color("Orange"))
                    .foregroundColor(Color("White"))
                    .cornerRadius(10)
                    //Change BackgroundCardComponent to next view
                    NavigationLink(destination: BackgroundCardComponent()) {
                        Text("Join game")

                    }
                    .padding(8.0)
                    .background(Color("Orange"))
                    .foregroundColor(Color("White"))
                    .cornerRadius(10)
                    }

                    Text("Choose if you want to join a game or create one.")
                        .font(.footnote)
                        .padding(.horizontal, 80.0)
                        .padding(.top, 20.0)
                }
                .foregroundColor(Color("Black"))
            }.edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userData: UserData())
    }
}
