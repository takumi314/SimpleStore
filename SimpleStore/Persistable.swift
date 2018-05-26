//
//  Persistable.swift
//  SimpleStore
//
//  Created by NishiokaKohei on 2018/05/16.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import Foundation

typealias Persistable = WritableContract & ReadableContract

protocol WritableContract {
    func write<T>(_ elements: T, key: StoreKey) where T : Collection
    func write(_ dictionary: [String: Any], key: StoreKey)
}

protocol ReadableContract {
    func read<T>(key: StoreKey) -> T where T : Collection
    func read(key: StoreKey) -> [String: Any]
}

struct Repository<E> {
    private let userDefault: Persistable

    init<T: Persistable>(via userDefault: T) {
        self.userDefault = userDefault
    }

    func save(_ array: Array<E>, key: StoreKey) {
        userDefault.write(array, key: key)
    }
    
    func save(dictionary: [String: Any], key: StoreKey) {
        userDefault.write(dictionary, key: key)
    }

    func loadArray(key: StoreKey) -> Array<E> {
        return userDefault.read(key: key)
    }

    func loadDictionary(key: StoreKey) -> [String: Any] {
        return userDefault.read(key: key)
    }
}

extension UserDefaults: Persistable {

    // MARK: - WritableContract

    func write<T>(_ array: Array<T>, key: StoreKey) {
        (0..<array.count).forEach { (index: Int) in
            self.set(array[index], forKey: "data_array_\(index)_\(key.rawValue)")
            print("write > data_array_\(index)_\(key.rawValue)")
        }
    }

    func write(_ dictionary: [String: Any], key: StoreKey) {
        let data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        self.set(data, forKey: key.rawValue)
        print("write > data_dictionary_\(key.rawValue)")
    }


    // MARK: - ReadableContract

    func read<T>(key: StoreKey) -> Array<T> {
        var index = 0
        var array = [T]()
        while let item = self.object(forKey: "data_array_\(index)_\(key.rawValue)") as? T {
            print("read < data_array_\(index)_\(key.rawValue)")
            array.append(item)
            index += 1
        }
        return array
    }

    func read(key: StoreKey) -> [String: Any] {
        let data = self.data(forKey: key.rawValue)
        print("read < data_dictionary_\(key.rawValue)")
        let dic = NSKeyedUnarchiver.unarchiveObject(with: data!) as! [String: Any]
        return dic
    }

}

