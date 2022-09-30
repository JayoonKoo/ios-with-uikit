//
//  BankeyUnitTests.swift
//  BankeyUnitTests
//
//  Created by 구자윤 on 2022/09/30.
//

import UIKit
import Foundation
import XCTest

@testable import Bankey

class BankeyUnitTests: XCTestCase {
    
    var formatter: CurrencyFormatter!

    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakDollarsIntoCents(balnce: 12345.23)
        XCTAssertEqual(result.0, "12,345")
        XCTAssertEqual(result.1, "23")
    }
    
    func testConvertDollar() throws {
        let result = formatter.convertDollar(12345.00)
        XCTAssertEqual(result, "12,345")
    }
    
    func testConvertCents() throws {
        let result = formatter.convertCents(0.123)
        XCTAssertEqual(result, "12")
    }
    
    func testZeroConvertCents() throws {
        let result = formatter.convertCents(0.00)
        XCTAssertEqual(result, "00")
    }
}
