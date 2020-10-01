import SwiftUI

struct JoinPartyView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundCardComponent()
                VStack(spacing: 30) {
                    VStack {
                        Text("Party code:")
                        TextField("", text: .constant(""))
                            .padding(5.0)
                            .background(Color("Grey"))
                            .cornerRadius(12)
                            .frame(width: screenWidth * 0.6)
                    }
                    //Change BackgroundCardComponent to next view
                    NavigationLink(destination: BackgroundCardComponent()) {
                        Text("Join game")
                    }
                    .padding(8.0)
                    .background(Color("Orange"))
                    .foregroundColor(Color("White"))
                    .cornerRadius(10)
                    Text("""
                        Enter the party code that you want to join.
                        Note: The party codes are case sensitive.
                        """)
                        .font(.footnote)
                        .padding(.horizontal, 50.0)

                }.foregroundColor(Color("Black"))
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct JoinPartyView_Previews: PreviewProvider {
    static var previews: some View {
        JoinPartyView()
    }
}