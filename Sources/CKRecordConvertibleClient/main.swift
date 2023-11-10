import CKRecordConvertible
import Foundation
import CloudKit

struct ChildType {
    
}

@Record
struct SomeRecord {
    // These properties will be stored in CloudKit, with a recordType of "SomeRecord", and columns named the "stringProperty", "dateProperty", etc (e.g.)
    var stringProperty: String
    var dateProperty: Date
    var arrayOfArrayOfString: [[String]]
    var arrayOfBool: Array<Bool>
    
    // Properties with default values will not be stored in CloudKit
    var intPropertyWithDefaultValue: Int = 1
    var arrayOfInt: [Int] = []
    
    // Optional values will not be stored in CloudKit
    var optionalValue: Int?
    
    func someMethod() { }
}
