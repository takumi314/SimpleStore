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
        static let stringWithStub = StoreKey(rawValue: "test_array_string_stub")
        static let string = StoreKey(rawValue: "string")
        static let int = StoreKey(rawValue: "int")
        static let float = StoreKey(rawValue: "float")

        static let performance = StoreKey(rawValue: "performance")
    }
    enum TestDictionary {
        static let string = StoreKey(rawValue: "string")
        static let int = StoreKey(rawValue: "int")
        static let float = StoreKey(rawValue: "float")

        static let performance = StoreKey(rawValue: "performance")
    }
}

class SimpleStoreTests: XCTestCase {

    // Stub instead of UserDefaults
    class StubUserDefaults: UserDefaults {

        override class var standard: StubUserDefaults {
            return StubUserDefaults()
        }

        var dictionary = Dictionary<String, Any>()

        override func set(_ value: Any?, forKey defaultName: String) {
            dictionary[defaultName] = value
        }

        override func object(forKey defaultName: String) -> Any? {
            return dictionary[defaultName]
        }

        // NSUserDefaults

        override func string(forKey defaultName: String) -> String? {
            return ""
        }

        override func stringArray(forKey defaultName: String) -> [String]? {
            return [""]
        }
    }

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

    func testWriteStringStub() {
        // Given
        let stub = StubUserDefaults.standard
        let repository = Repository<String>(via: stub)
        let keyName = StoreKey.TestArray.stringWithStub
        let inputs = ["ABC", "🌟🎃🍓", "%$&*<>|@(!;:.,"]

        // When
        repository.save(inputs, key: keyName)

        // Then
        let results = stub.dictionary
        let r0 = results["\(keyName.rawValue)_collection_element0"]
        let r1 = results["\(keyName.rawValue)_collection_element1"]
        let r2 = results["\(keyName.rawValue)_collection_element2"]

        XCTAssertNotNil(r0 as! String)
        XCTAssertNotNil(r1 as! String)
        XCTAssertNotNil(r2 as! String)
        XCTAssertTrue(r0 as! String == "ABC")
        XCTAssertTrue(r1 as! String == "🌟🎃🍓")
        XCTAssertTrue(r2 as! String == "%$&*<>|@(!;:.,")
    }

    func testLoadStringStub() {
        // Given
        let stub = StubUserDefaults()
        let repository = Repository<String>(via: stub)
        let keyName = StoreKey.TestArray.stringWithStub
        stub.dictionary = ["\(keyName.rawValue)_collection_element0": "ABC",
                           "\(keyName.rawValue)_collection_element1": "🌟🎃🍓",
                           "\(keyName.rawValue)_collection_element2": "%$&*<>|@(!;:.,"]

        // When
        let array = repository.loadArray(key: keyName)

        // Then
        XCTAssertTrue(array[0] == "ABC")
        XCTAssertTrue(array[1] == "🌟🎃🍓")
        XCTAssertTrue(array[2] == "%$&*<>|@(!;:.,")
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

    func testWriteStringDictionary() {
        // Gigen 改行コードは除外
        let firstRepo = Repository<String>(via: UserDefaults.standard)
        let inputs = ["a": 0, "b": "2", "c": true, "d": 0.0, "e": "5"] as [String: Any]
        firstRepo.save(dictionary: inputs, key: StoreKey.TestDictionary.string)

        // When
        let secondRepo = Repository<String>(via: UserDefaults.standard)
        let outputs = secondRepo.loadDictionary(key: StoreKey.TestDictionary.string)

        // Then
        for output in outputs.enumerated() {
            let _ =  inputs[output.element.key]

        }
    }

    func testWriteIntDictionary() {
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

    func testWriteCGFloatDictionary() {
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
