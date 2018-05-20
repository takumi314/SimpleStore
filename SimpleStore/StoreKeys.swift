//
//  StoreKeys.swift
//  SimpleStore
//
//  Created by NishiokaKohei on 2018/05/20.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation

struct StoreKey: RawRepresentable {
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    var rawValue: String
    typealias RawValue = String
}

extension StoreKey {

    enum Array {
        // definte key which will be used in UserDefaults
        static let test1 = StoreKey(rawValue: "test1")

    }

    enum Dictionary {
        // definte key which will be used in UserDefaults
        static let test1 = StoreKey(rawValue: "test1")

    }

}

