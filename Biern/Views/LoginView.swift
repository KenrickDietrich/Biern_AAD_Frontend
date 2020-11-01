import SwiftUI

struct LoginView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // global data provider recieved from parent
    @ObservedObject var data: DataProvider
    // local variables
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
                // navigate to user view
                NavigationLink(destination: UserView(data: self.data),
                               isActive: $isActive) {
                    NavigationButton {
                        Button(action: {
                            // check if input is not empty
                            // set user username, send create user to API
                            // set is active to navigate to next view
                            if self.input.count != 0 {
                                self.data.user.username = self.input
                                self.data.createUser()
                                self.isActive = true
                            }
                            // show alert
                            else {
                                self.showAlert = true
                            }
                        }, label: {
                            Text("Next")
                                .fontWeight(.medium)
                        })
                        // show alert if error occured
                        .alert(isPresented: self.$data.alert) {
                            Alert(title: Text("Something went wrong"),
                                  message: Text("Try again later, ERROR: \(self.data.reason)"),
                                  dismissButton: .default(Text("OK")))
                        }
                    }
                }
                Text("Please enter an username, you can change this name later.")
                    .font(.footnote)
                    .padding(.horizontal, 50.0)
            }.foregroundColor(Color("Black"))
            // show alert if input is empty
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Try again"), message: Text("Please enter a username and try again!"))
            })
        }.edgesIgnoringSafeArea(.all)
    }

    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView(data: DataProvider())
        }
    }
}
