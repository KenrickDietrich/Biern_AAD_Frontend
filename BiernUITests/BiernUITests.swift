import XCTest

class BiernUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppStartUp() throws {
        // test whether the application is able to launch, if not the other test will error as well
        let app = XCUIApplication()
        app.launch()
    }
}
