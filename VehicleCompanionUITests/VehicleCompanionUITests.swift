//
//  VehicleCompanionUITests.swift
//  VehicleCompanionUITests
//

import XCTest

final class VehicleCompanionUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {}
    
    override func setUp() {
        super.setUp()
        app.launch()
    }
    
    func testGarageDisplaysVehicles() {
        let vehicleRow = app.buttons["Vehicle: Work Truck"].firstMatch
        
        XCTAssertTrue(vehicleRow.waitForExistence(timeout: 5))
        XCTAssertTrue(vehicleRow.isHittable)
        XCTAssertEqual(vehicleRow.label, "Vehicle: Work Truck")
    }
    
    func testGarageShowsNoSearchResults() {
        app.searchFields["Type to search for a vehicle"].firstMatch.tap()
        app.searchFields["Type to search for a vehicle"].firstMatch.typeText("test")
        
        let placeholder = app.images["no_search_results_placeholder"].firstMatch
        XCTAssertTrue(placeholder.waitForExistence(timeout: 5))
        XCTAssertTrue(placeholder.isHittable)
        XCTAssertEqual(placeholder.label, "No vehicles found. Try a different search.")
    }
    
    func testAddVehicleButtonAccessible() {
        let addButton = app.buttons["add_vehicle_button"]
        XCTAssertTrue(addButton.exists)
        XCTAssertTrue(addButton.isHittable)
        XCTAssertEqual(addButton.label, "Add new vehicle")
    }
}
