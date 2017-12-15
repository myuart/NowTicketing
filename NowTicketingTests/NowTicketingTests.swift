//
//  NowTicketingTests.swift
//  NowTicketingTests
//
//  Created by Maria Yu on 12/14/17.
//  Copyright © 2017 Maria Yu. All rights reserved.
//

import XCTest
@testable import NowTicketing

class NowTicketingTests: XCTestCase {
    var viewController: RiderTableViewController!
    
    override func setUp() {
        super.setUp()
        
        let nc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController
        viewController = nc?.topViewController as? RiderTableViewController
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func test_loadFile() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: "test", withExtension: "json")
        let result = viewController.loadFromFile(file: path!)
        
        //use Child type to test
        var fares = [Fare]()
        fares.append(Fare(desc: "2.5 Hour Ticket", pr:1.5))
        let rider = Ticket(tpe: "Child", text:"Ages 8-17", fareAry: fares)
        
        XCTAssertTrue(result.count == 1, "loadFile rider count is incorrect")
        
        let testrider = result[0]
        XCTAssertEqual(testrider.type, rider.type, "loadFile parsing is incorrect")
        XCTAssertEqual(testrider.subtext, rider.subtext, "loadFile parsing is incorrect")
        XCTAssertEqual(testrider.fares?[0].price, rider.fares?[0].price, "loadFile parsing is incorrect")
        XCTAssertEqual(testrider.fares?[0].description, rider.fares?[0].description, "loadFile parsing is incorrect")
    }
    
    func test_Table_DataSource_Rider() {
        let data = viewController?.tableView.dataSource
        XCTAssertNotNil(viewController?.tableView.dataSource)
        XCTAssertEqual(data?.numberOfSections!(in: (viewController?.tableView)!), 1, "section is not equal to 1")
        XCTAssertEqual(data?.tableView((viewController?.tableView)!, numberOfRowsInSection: 0), 3, "")
        
        let fares = [Fare]()
        //fares.append(Fare(desc: "2.5 Hour Ticket", pr:2.5))
        //fares.append(Fare(desc: "1 Day Pass", pr:5.0))
        //fares.append(Fare(desc: "30 Day Pass", pr:100))
        
        //use Adult type to test
        let rider = Ticket(tpe: "Adult", text:"", fareAry: fares)
        
        let firstCell = viewController.tableView.dataSource?.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(rider.type, firstCell?.textLabel?.text!, "cell text is incorrect")
        XCTAssertEqual(rider.subtext, firstCell?.detailTextLabel?.text!, "cell detail text is incorrect")
    }
    
}
