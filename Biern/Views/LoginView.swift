import SwiftUI

struct LoginView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var data: DataProvider
    @State var input = ""
    @State var isActive = false
    @State var showAlert = false
    var body: some View {
        ZStack {
            BackgroundCardComponent()
            VStack(spacing: 30) {
                Text("Bier'n het drankspel")
                    .font(.title)
                VStack {
                    Text("Username:")
                    TextField("", text: self.$input)
                        .accessibilityIdentifier("usernameTextField")
                        .padding(5.0)
                        .background(Color("Grey"))
                        .cornerRadius(12)
                        .frame(width: screenWidth * 0.6)
                }
                NavigationLink(destination: UserView(data: self.data),
                               isActive: $isActive) {
                    NavigationButton {
                        Button(action: {
                            if self.input.count != 0 {
                                self.userData.username = self.input
                                self.userData.createUser()
                                self.isActive = true
                            } else {
                                self.showAlert = true
                            }
                        }, label: {
                            Text("Next")
                                .fontWeight(.medium)
                        })
                    }
                }
                Text("Please enter an username, you can change this name later.")
                    .font(.footnote)
                    .padding(.horizontal, 50.0)
            }.foregroundColor(Color("Black"))
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Try again"), message: Text("Please enter a username and try again!"))
            })
        }.edgesIgnoringSafeArea(.all)
        .onAppear { self.data.fetchGames() }
    }

    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView(data: DataProvider())
        }
    }
}
