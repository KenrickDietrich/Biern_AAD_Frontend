import SwiftUI

struct LoginView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var userData: User
    @ObservedObject var data: DataProvider
    @State var input = ""
    @State var isActive = false
    var body: some View {
        ZStack {
            BackgroundCardComponent()
            VStack(spacing: 30) {
                Text("Bier'n het drankspel")
                    .font(.title)
                VStack {
                    Text("Username:")
                    TextField("", text: self.$input)
                        .padding(5.0)
                        .background(Color("Grey"))
                        .cornerRadius(12)
                        .frame(width: screenWidth * 0.6)
                }
                NavigationLink(destination: UserView(userData: self.userData, data: self.data),
                               isActive: $isActive) {
                    NavigationButton {
                        Button(action: {
                            self.userData.username = self.input
                            self.userData.createUser()
                            self.isActive = true
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
        }.edgesIgnoringSafeArea(.all)

    }

    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView(userData: User(), data: DataProvider())
        }
    }
}
