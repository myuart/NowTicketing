//
//  FareTableVCTests.swift
//  QuickTickets
//
//  Created by Maria Yu on 12/15/17.
//  Copyright © 2017 Maria Yu. All rights reserved.
//

import XCTest
@testable import NowTicketing

class FareTableVCTests: XCTestCase {
    var viewController: FareTableViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FareTableViewController") as? FareTableViewController
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testTable_DataSource_Fare() {
        //use Child type to test
        var fares = [Fare]()
        fares.append(Fare(desc: "2.5 Hour Ticket", pr:1.5))
        fares.append(Fare(desc: "1 Day Pass", pr: 2.0))
        fares.append(Fare(desc: "30 Day Pass", pr: 40.0))
        let rider = Ticket(tpe: "Child", text:"Ages 8-17", fareAry: fares)
        
        viewController.selectedRider = rider
        
        let data = viewController?.tableView.dataSource
        XCTAssertNotNil(viewController?.tableView.dataSource)
        XCTAssertEqual(data?.numberOfSections!(in: (viewController?.tableView)!), 1, "section is not equal to 1")
        XCTAssertEqual(data?.tableView((viewController?.tableView)!, numberOfRowsInSection: 0), 3, "")
        
        let firstCell = viewController.tableView.dataSource?.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        let price = "$" + String(format: "%.2f", fares[0].price!)
        let firstCellPrice = firstCell?.detailTextLabel?.text!
        XCTAssertEqual(rider.fares?[0].description, firstCell?.textLabel?.text!, "cell description is incorrect")
        XCTAssertEqual(price, firstCellPrice, "cell price text is incorrect")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
