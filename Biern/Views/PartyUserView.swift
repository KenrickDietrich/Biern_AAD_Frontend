import SwiftUI

struct PartyUserView: View {
    @ObservedObject var data: DataProvider
    var body: some View {
        ZStack {
        BackgroundCardComponent()
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct PartyUserView_Previews: PreviewProvider {
    static var previews: some View {
        PartyUserView(data: DataProvider())
    }
}
