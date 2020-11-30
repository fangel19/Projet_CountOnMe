//
//  CalculatorTests.swift
//  CountOnMeTests
//
//  Created by angelique fourny on 29/11/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest

@testable import CountOnMe

class CalculatorTests: XCTestCase {
    
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    func testNumberOne_ThenApplyOperand_ThenGiveResult(){    // check Int conversion with operator
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedAddition()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedSubstration()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedDivision()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedMultiplication()
        calculator.addStringNumber(stringNumber: "1")
        
        calculator.equal()
        
        calculator.equal()
        
        XCTAssert(calculator.textView == "1 + 1 * 1 / 1 - 1 = 1")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
