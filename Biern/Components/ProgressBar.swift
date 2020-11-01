import SwiftUI

// progress bar component
struct ProgressBar: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    // binded value received from parent
    @Binding var value: Int
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: screenWidth * 0.7, height: 20)
                .foregroundColor(Color("Grey"))
            Capsule()
                .frame(width: ((screenWidth * 0.7) * CGFloat(value)/10), height: 20)
                .foregroundColor(Color("Orange"))
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: .constant(2))
    }
}
