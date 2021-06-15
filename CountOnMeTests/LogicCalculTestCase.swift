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
    
    func testGivenDivisionParZeroIsImpossibleWhenForAllCaractersThenItWillBeSendAnError() {
        // Given
        let logicCalcul = LogicCalcul()
        
        // When
        logicCalcul.compute(string: ["5", "/", "0"])
        
        // Then
        XCTAssert(logicCalcul.compute(string: ["5", "/", "0"]) == Result.failure(.division0))
            
           
    }
    
    func testGivenMultiOpreandThenForAllCaractersThenItWillBeSendAnError() {
        // Given
        let logicCalcul = LogicCalcul()
        
        // When
        //logicCalcul.compute(string: ["5", "/", "0"])
        
        // Then
        XCTAssert(logicCalcul.compute(string: ["5", "+", "-", "8"]) == Result.failure(.multiOperator))
    }
    
}
