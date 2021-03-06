import SwiftUI

struct WaitingView: View {
    // get screen size
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    // local variables
    @State var progressValue: Int = 0
    @State var timer: Timer?
    @State var isActive = false
    // global data provider recieved from parent
    @ObservedObject var data: DataProvider

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
                // display progress bar with progress value
                ProgressBar(value: self.$progressValue)
                // when progressbar is full navigate to game view
                NavigationLink(destination: GameView(data: self.data, color: Color("Green")), isActive: $isActive) {}
            }.onAppear(perform: {
                startProgress()
            })
            .padding(50)
        }
    }

    // time for progress bar
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
        WaitingView(data: DataProvider())
    }
}
