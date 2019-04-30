//
//  WelcomeToIntercomTests.swift
//  WelcomeToIntercomTests
//
//  Created by Kızılay on 29.04.2019.
//  Copyright © 2019 Rozeri Dilar. All rights reserved.
//

import XCTest
@testable import WelcomeToIntercom

class WelcomeToIntercomTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleCustomerDecoding() {
        // This test will work if customers.txt file has only one customer json object
        // I tested it with one line in customers.txt
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "customers", withExtension: "txt"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let customer = try? decoder.decode(Customer.self, from: data) else {
            return
        }
        
        XCTAssertEqual(customer.userId, 1993)
        XCTAssertEqual(customer.name, "Rozeri Dilar")
        XCTAssertEqual(customer.latitude, "53")
        XCTAssertEqual(customer.longitude, "-6")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
