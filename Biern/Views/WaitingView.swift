import SwiftUI

struct WaitingView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @State var progressValue: Int = 0
    @State var timer: Timer?
    @State var isActive = false

    var body: some View {
        NavigationItemContainer {
            VStack(alignment: .center) {
                Image("crown")
                    .resizable()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                VStack {
                    Text("Click as fast as you can!")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Be the first to click when the screen turns green!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                }.padding(.vertical, 70)
                Spacer()
                Text("Waiting for the next round to start...")
                ProgressBar(value: self.$progressValue)
                NavigationLink(destination: GameView(color: Color("Green")), isActive: $isActive) {}

            }.onAppear(perform: {
                startProgress()
            })
            .padding(50)
        }
    }

    func startProgress() {
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true, block: { timer in
                self.progressValue += Int.random(in: 1..<5)

                if self.progressValue >= 10 {
                    self.progressValue = 10
                    timer.invalidate()
                    self.isActive = true
                }
            })
    }
}

struct WaitingScreen_Previews: PreviewProvider {
    static var previews: some View {
        WaitingView()
    }
}
