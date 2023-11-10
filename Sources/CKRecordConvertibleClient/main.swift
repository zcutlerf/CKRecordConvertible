import CKRecordConvertible
import Foundation
import CloudKit

struct ChildType {
    
}

@Record
struct SomeRecord {
    var stringProperty: String
    var intProperty: Int = 1
    var dateProperty: Date
    
    var arrayOfString: [[String]]
    var arrayOfInt: [Int] = []
    var arrayOfBool: Array<Bool>
#warning("Does not ignore optional values yet.")
    var optional: Int?
    
    func someMethod() {
        print("this is a method")
    }
}
