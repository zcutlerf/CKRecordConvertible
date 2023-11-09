import CKRecordConvertible
import Foundation
import CloudKit

@Record
struct SomeRecord {
    var property1: String
    var property2: Int
    var anotherProperty: Date
    
    func someMethod() {
        print("this is a method")
    }
}
