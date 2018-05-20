//
//  SimpleStoreTests.swift
//  SimpleStoreTests
//
//  Created by NishiokaKohei on 2018/05/16.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import XCTest
@testable import SimpleStore

class SimpleStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testWriteStringArray() {
        // Gigen 改行コードは除外
        let firstRepo = Repository<String>(via: UserDefaults.standard)
        let inputs = ["ABC", "🌟🎃🍓", "%$&*<>|@(!;:.,"]
        firstRepo.save(inputs, key: StoreKey.Array.test2)

        // When
        let secondRepo = Repository<String>(via: UserDefaults.standard)
        let outputs = secondRepo.loadArray(key: StoreKey.Array.test2)

        // Then
        XCTAssertTrue(inputs == outputs)
    }

    func testWriteIntArray() {
        // Gigen
        let firstRepo = Repository<Int>(via: UserDefaults.standard)
        let inputs = [ 0, 01, 55]
        firstRepo.save(inputs, key: StoreKey.Dictionary.test2)

        // When
        let secondRepo = Repository<Int>(via: UserDefaults.standard)
        let outputs = secondRepo.loadArray(key: StoreKey.Dictionary.test2)

        // Then
        XCTAssertTrue(inputs == outputs)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
