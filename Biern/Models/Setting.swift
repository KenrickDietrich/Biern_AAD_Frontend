import Foundation

class Setting: ObservableObject {
    @Published var settingId = UUID()
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var isActive: Bool = false

    init(title: String, description: String, isActive: Bool) {
        self.title = title
        self.description = description
        self.isActive = isActive
    }
}
