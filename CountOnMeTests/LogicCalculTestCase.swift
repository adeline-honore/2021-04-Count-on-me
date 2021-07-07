//
//  LogicCalculTestCase.swift
//  CountOnMeTests
//
//  Created by HONORE Adeline on 02/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class LogicCalculTestCase: XCTestCase {
    // Given
    var logicCalcul: LogicCalcul!
    
    override func setUp() {
        super.setUp()
        logicCalcul = LogicCalcul()
    }
    
    func testGivenCaracteresWhenCaractersOperatorIsAdditionThenResultShouldBeTwentyFive() {
        
        let expected: Result<Double,ErrorType> = Result.success(25.0)
        
        // When
        let result = logicCalcul.compute(string: ["5", "+", "20"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenCaracteresWhenCaractersOperatorIsPrioritaireThenResultShouldBeThirtyEight() {
        
        let expected: Result<Double,ErrorType> = Result.success(38.0)
        
        // When
        let result = logicCalcul.compute(string: ["8", "+", "6", "x", "5"])
        // Then
        XCTAssertEqual(result, expected)
        
    }
    
    
    func testGivenDivisionParZeroIsImpossibleWhenForAllCaractersThenItWillBeSendFailureDivision() {
        
        let expected: Result<Double,ErrorType> = Result.failure(.division0)
        
        // When
        let result = logicCalcul.compute(string: ["5", "/", "0"])
        
        // Then
        XCTAssertEqual(result, expected)
           
    }
    
    func testGivenMultiOpreandThenForAllCaractersThenItWillBeSendFailureMultiOperator() {
        
        let expected: Result<Double,ErrorType> = Result.failure(.multiOperator)
        
        // When
        let result = logicCalcul.compute(string: ["5", "/", "+", "2"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenExpressionThenLastCaracterIsOperandThenItWillBeSendFailureNoCorrect() {
        
        let expected: Result<Double,ErrorType> = Result.failure(.noCorrect)
        
        // When
        let result = logicCalcul.compute(string: ["5", "+", "8", "+"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
}
