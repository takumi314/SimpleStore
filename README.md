#  SimpleStore


This is sample source for persistiing Array and Dictionary, which provides protocols and functions based on UserDefaults.


## How to implement

For Array's type, delare a Repository object into which UserDefaults instance is passed, and also specify what type that is by <Type> and a unique key-name.

```swift:

let repository = Repository<String>(via: UserDefaults.standard)

repository.save(["A1", "B2", "C3", "D4"], key: "key_name_for_array")

```

Call `loadArray(key:)` with key name when loading data with Array's type.

```swift:

let loadedArray = repository.loadArray(key: "key_name_for_array")

//
// ["A1", "B2", "C3", "D4"]
//

```

For Dictionary's type, delare a Repository into which passed UserDefaults instance, and specify a unique key-name.

```
let dic = ["a":"hoge", "b": 0.5, "c": true, "d": "😎", "e": 0.05] as [String : Any]

repository.save(dictionary: dic, key: "key_name_for_dictionary")

```

```swift:

let loadedDictionary = repository.loadDictionary(key: "key_name_for_dictionary")

```

