import SwiftUI

struct LoginView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @ObservedObject var userData: UserData
    @State var input = ""
    @State var isActive = false

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundCardComponent()
                VStack {
                    Text("Bier'n het drankspel")
                        .font(.title)
                    Text("Username:")
                        .padding(.top, screenWidth * 0.05)
                    TextField("", text: self.$input)
                        .padding(5.0)
                        .background(Color("Grey"))
                        .cornerRadius(12)
                        .frame(width: screenWidth * 0.6)
                        .padding(.bottom, 20.0)
<<<<<<< HEAD
                    NavigationLink(destination: UserView(userData: self.userData), isActive: $isActive) {
                        Button(action: {
                            self.userData.username = self.input
                            self.isActive = true
                        }, label: {
                            Text("Next")
                        })
=======
                    //Change BackgroundCardComponent to next view
                    NavigationLink(destination: JoinPartyView()) {
                        Text("Next")
>>>>>>> 0f4229286e08af4b64baf06efa123f8bba58ac64
                    }
                    .padding(8.0)
                    .background(Color("Orange"))
                    .foregroundColor(Color("White"))
                    .cornerRadius(10)
                    Text("Please enter an username, you can change this name later.")
                        .font(.footnote)
                        .padding(.horizontal, 60.0)
                        .padding(.top, 20)
                }
                .foregroundColor(Color("Black"))
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userData: UserData())
    }
}
