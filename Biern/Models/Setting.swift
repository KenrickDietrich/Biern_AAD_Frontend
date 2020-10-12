import Foundation

class Setting: ObservableObject {
    @Published var settingsId = UUID()
    @Published var difficulty: Int = 1

    init(difficulty: Int) {
        self.difficulty = difficulty
    }

}
