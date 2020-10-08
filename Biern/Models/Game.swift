import UIKit

struct Game: Hashable, Codable {
    var gameId: UUID
    var name: String
    let rules: String
    fileprivate var image: String

    init(gameId: UUID, name: String, rules: String, image: String) {
        self.gameId = gameId
        self.name = name
        self.rules = rules
        self.image = image
    }
}

//extension Game {
//    var image: Image {
//        ImageStore.shared.image(name : imageName)
//    }
//}
