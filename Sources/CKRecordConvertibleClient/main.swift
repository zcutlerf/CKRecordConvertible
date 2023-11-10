import CKRecordConvertible
import Foundation
import CloudKit

struct ChildType {
    
}

@Record
struct SomeRecord {
    var stringProperty: String
    var intProperty: Int
    var dateProperty: Date
    
    #warning("Collection types not working yet.")
    var arrayOfInt: [Int] = []
    
    func someMethod() {
        print("this is a method")
    }
}
