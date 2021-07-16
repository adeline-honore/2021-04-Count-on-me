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
    
    override func tearDown() {
        super.setUp()
        logicCalcul = nil
    }
    
    func testGivenCaracteresWhenEquationIsAnAdditionThenResultShouldBeTwentyFive() {
        
        let expected: Result<Double,ErrorType> = .success(25.0)
        
        // When
        let result = logicCalcul.compute(string: ["5", "+", "20"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenCaracteresWhenEquationIsASubstractionThenResultShouldBeFive() {
        
        let expected: Result<Double,ErrorType> = .success(5.0)
        
        // When
        let result = logicCalcul.compute(string: ["20", "-", "15"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenCaracteresWhenEquationIsAMultiplicationThenResultShouldBeOneHundred() {
        
        let expected: Result<Double,ErrorType> = .success(100.0)
        
        // When
        let result = logicCalcul.compute(string: ["5", "x", "20"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenCaracteresWhenEquationIsADivisionThenResultShouldBeSeven() {
        
        let expected: Result<Double,ErrorType> = .success(7.0)
        
        // When
        let result = logicCalcul.compute(string: ["56", "/", "8"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenCaracteresWhenCaractersOperatorIsPrioritaireThenResultShouldBeThirtyEight() {
        
        let expected: Result<Double,ErrorType> = .success(38.0)
        
        // When
        let result = logicCalcul.compute(string: ["8", "+", "6", "x", "5"])
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenCaracteresWhenCaractersOperatorIsPrioritaireThenResultShouldBeTwelve() {
        
        let expected: Result<Double,ErrorType> = .success(12.0)
        
        // When
        let result = logicCalcul.compute(string: ["8", "+", "16", "/", "4"])
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenCaracteresWhenEquationIsABigEquationWithALotCalculationThenResultShouldBeTwentySeven() {
        
        let expected: Result<Double,ErrorType> = .success(27.0)
        
        // When
        let result = logicCalcul.compute(string: ["1", "+", "7", "x", "3", "-", "2", "+", "56", "/", "8"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenMultiOpreandThenForAllCaractersThenItWillBeSendFailureMultiOperator() {
        
        let expected: Result<Double,ErrorType> = .failure(.multiOperator)
        
        // When
        let result = logicCalcul.compute(string: ["5", "/", "+", "2"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenExpressionThenLastCaracterIsOperandThenItWillBeSendFailureNoCorrect() {
        
        let expected: Result<Double,ErrorType> = .failure(.noCorrect)
        
        // When
        let result = logicCalcul.compute(string: ["5", "+", "8", "+"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenExpressionThenThereAreMultiDecimalPointThenItWillBeSendFailureMultiDecimalPoint() {
        
        let expected: Result<Double,ErrorType> = .failure(.multiDecimalPoint)
        
        // When
        let result = logicCalcul.compute(string: ["5.3.8", "+", "8"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testGivenDivisionParZeroIsImpossibleWhenForAllCaractersThenItWillBeSendFailureDivision() {
        
        let expected: Result<Double,ErrorType> = .failure(.division0)
        
        // When
        let result = logicCalcul.compute(string: ["5", "/", "0"])
        
        // Then
        XCTAssertEqual(result, expected)
    }
}
