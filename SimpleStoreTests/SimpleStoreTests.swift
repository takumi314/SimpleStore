//
//  SimpleStoreTests.swift
//  SimpleStoreTests
//
//  Created by NishiokaKohei on 2018/05/16.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import XCTest
@testable import SimpleStore

extension StoreKey {
    enum TestArray {
        static let string = StoreKey(rawValue: "string")
        static let int = StoreKey(rawValue: "int")
        static let float = StoreKey(rawValue: "float")

        static let performance = StoreKey(rawValue: "performance")
    }
}

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
        firstRepo.save(inputs, key: StoreKey.TestArray.string)

        // When
        let secondRepo = Repository<String>(via: UserDefaults.standard)
        let outputs = secondRepo.loadArray(key: StoreKey.TestArray.string)

        // Then
        XCTAssertTrue(inputs == outputs)
    }

    func testWriteIntArray() {
        // Gigen
        let firstRepo = Repository<Int>(via: UserDefaults.standard)
        let inputs = [ 0, 01, 55]
        firstRepo.save(inputs, key: StoreKey.TestArray.int)

        // When
        let secondRepo = Repository<Int>(via: UserDefaults.standard)
        let outputs = secondRepo.loadArray(key: StoreKey.TestArray.int)

        // Then
        XCTAssertTrue(inputs == outputs)
    }

    func testWriteCGFloatArray() {
        // Given
        let firstRepo = Repository<CGFloat>(via: UserDefaults.standard)
        let inputs = [CGFloat(12.3), CGFloat(-0.08)]
        firstRepo.save(inputs, key: StoreKey.TestArray.float)

        // When
        let outputs = firstRepo.loadArray(key: StoreKey.TestArray.float)

        // Then
        XCTAssertTrue(inputs == outputs)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        let repo = Repository<String>(via: UserDefaults.standard)
        let array = ["A","B","C","D"]

        self.measure {
            repo.save(array, key: StoreKey.TestArray.performance)
        }
    }
    
}
