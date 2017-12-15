//
//  PurchaseVCTests.swift
//  NowTicketing
//
//  Created by Maria Yu on 12/15/17.
//  Copyright © 2017 Maria Yu. All rights reserved.
//

import XCTest
@testable import NowTicketing

class PurchaseVCTests: XCTestCase {
    var viewController: PurchaseViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PurchaseViewController") as? PurchaseViewController
        
        
        viewController.selectedType = "Child"
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testCalculation1() {
        viewController.selectedFare = Fare(desc: "2.5 Hour Ticket", pr:1.5)
        
        viewController.currentTicketNum = 1
        let total = viewController.calculate()
        
        XCTAssertNotEqual(total, 2.5, "AssertNotEqual addition failed for total price")
    }
    
    func testCalculation2() {
        viewController.selectedFare = Fare(desc: "1 Day Pass", pr: 2.0)
        
        viewController.currentTicketNum = 6
        let total = viewController.calculate()
        
        XCTAssertEqual(total, 12.0, "AssertEqual addition failed for total price")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
