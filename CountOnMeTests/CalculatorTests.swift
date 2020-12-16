//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTests: XCTestCase {
    
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    //   MARK: - Test Number with operator
    
    func testNumberOne_WhenApplyOperand_ThenGiveResult(){
        // check with operator
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedAddition()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedSubstration()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedDivision()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedMultiplication()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "1 + 1 - 1 / 1 x 1 = 1.0")
    }
    
    func testSeveralNumbers_WhenTappedNumbers_ThenGiveResult() {
        calculator.addStringNumber(stringNumber: "4")
        calculator.addStringNumber(stringNumber: "2")
        calculator.tappedAddition()
        calculator.addStringNumber(stringNumber: "1")
        calculator.addStringNumber(stringNumber: "0")
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "42 + 10 = 52.0")
    }
    
    func testBigNumbers_WhenTappedNumbers_ThenGiveResult() {
        calculator.addStringNumber(stringNumber: "200")
        calculator.tappedEqual()
        calculator.tappedAddition()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedEqual()
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "200 + 1 = 201.0")
    }
    
    //    MARK: - Test expression is not correct
    
    func testexpressionIsNotCorrect_WhenExpressionIsNotCorrect_ThenReturnAlertMessage() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedAddition()
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "1 + ")
    }
    
    //    MARK: - Test First Operator
    func testFirstOperatorAddition_WhenDontHaveOpatorFirst_ThenReturnMessageError() {
        calculator.tappedAddition()
        XCTAssert(calculator.textView == "")
    }
    
    func testFirstOperatorDivision_WhenDontHaveOpatorFirst_ThenReturnMessageError() {
        calculator.tappedDivision()
        XCTAssert(calculator.textView == "")
    }
    
    func testFirstOperatorMultiplication_WhenDontHaveOpatorFirst_ThenReturnMessageError() {
        calculator.tappedMultiplication()
        XCTAssert(calculator.textView == "")
    }
    
    func testFirstOperatorSubstraction_WhenDontHaveOpatorFirst_ThenReturnMessageError() {
        calculator.tappedSubstration()
        XCTAssert(calculator.textView == "")
    }
    
    func testEqual_WhenTappedEqual_ThenReturnMessageError() {
        calculator.tappedEqual()
        XCTAssert(calculator.textView == "")
    }
    
    //   MARK: - Test division by zero is not possible
    func testDivisionByZero_WhenTappedDivisionByZero_ThenReturnMessageError() {
        calculator.addStringNumber(stringNumber: "2")
        calculator.tappedDivision()
        calculator.addStringNumber(stringNumber: "0")
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "2 / 0 = inf")
    }
//    MARK: - Test priority management
    func testPriority_WhenTappedDivisionAfterAddition_ThenDivisionIsFirstAddition() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedAddition()
        calculator.addStringNumber(stringNumber: "3")
        calculator.tappedDivision()
        calculator.addStringNumber(stringNumber: "2")
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "1 + 3 / 2 = 2.5")
    }
    
//    MARK: - Test result is a double
    func testResultDouble_WhenTappedDivision_ThenGiveResult() {
        calculator.addStringNumber(stringNumber: "10")
        calculator.tappedDivision()
        calculator.addStringNumber(stringNumber: "3")
        calculator.equal()
        
        XCTAssert(calculator.textView == "10 / 3 = 3.3333333333333335")
    }
    
    //    MARK: - Double Operator
    func testDoubleOperator_WhenTappedDoubleOperator_ThenReturnAlertMessage() {
        calculator.addStringNumber(stringNumber: "2")
        calculator.tappedMultiplication()
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "2 x ")
    }
    
    func testAddition_WhenWeDoubleAddition_ThenReturnAlertMessage() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedAddition()
        calculator.tappedAddition()
        
        XCTAssert(calculator.textView == "1 + ")
    }
    
    func testSubstration_WhenWeDoubleSubstraction_ThenReturnAlertMessage() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedSubstration()
        calculator.tappedSubstration()
        
        XCTAssert(calculator.textView == "1 - ")
    }
    
    func testDivision_WhenWeDoubleDivision_ThenReturnAlertMessage() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedDivision()
        calculator.tappedDivision()
        
        XCTAssert(calculator.textView == "1 / ")
    }
    
    func testMultiplication_WhenWeDoubleMultiplication_ThenReturnAlertMessage() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedMultiplication()
        calculator.tappedMultiplication()
        
        XCTAssert(calculator.textView == "1 x ")
    }
    
    //    MARK: - Tapped equal after one number
    func testEqual_WhenWeTappedEqualAfterNumberOne_ThenReturnAlertMessage() {
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedEqual()
        
        XCTAssert(calculator.textView == "1")
    }
    
    //    MARK: - Tests tapped two equal at the result
    func testAddtwoEqual_WhenTappedtwoEqual_ThenReturnMessageError() {
        calculator.addStringNumber(stringNumber: "3")
        calculator.tappedMultiplication()
        calculator.addStringNumber(stringNumber: "1")
        calculator.tappedEqual()
        calculator.tappedEqual()

        XCTAssert(calculator.textView == "3 x 1 = 3.0")
    }
    
    func testSendToController_WhenInErrorMessageShouldAppear_ThenUseTheDelegate() {
        calculator.delegate?.alertMessage("")
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        calculator = nil
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
