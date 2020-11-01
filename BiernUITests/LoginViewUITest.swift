import XCTest

class LoginViewUITest: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    func testInitialViewState () {
        let app = XCUIApplication()
        app.launch()

        let textLabel = app.staticTexts["Bier'n het drankspel"]
        let textField = app.textFields["usernameTextField"]
        let usernameDescriptionText = app.staticTexts["Please enter an username, you can change this name later."]

        XCTAssertTrue(textLabel.exists)
        XCTAssertEqual(textLabel.label, "Bier'n het drankspel")

        XCTAssertTrue(usernameDescriptionText.exists)
        XCTAssertEqual(usernameDescriptionText.label, "Please enter an username, you can change this name later.")

        XCTAssertTrue(textField.exists)
        XCTAssertEqual(textField.label.isEmpty, true)

        textField.tap()
        textField.typeText("U")
    }
}
