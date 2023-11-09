import CloudKit

/// Conform custom types to this protocol to use them with CloudKit.
///
/// Usage:
/// - Conform to the Record protocol.
/// ```
/// struct SomeRecord: Record {
///     var id: String
///     init?(from record: CKRecord) { }
/// }
/// ```
/// - Add properties that you would like to store, with types that CloudKit can store.
/// ```
/// struct SomeRecord: Record {
///     ...
///
///     var someProperty: String
/// }
/// ```
/// - Implement RecordKeys enum.
///      - Each case of RecordKeys should match a property named in a Record type exactly.
///      - Do not include `id` in RecordKeys, because CKRecord.ID handles this separately.
///      - Do not include parents, children, or other properties that reference custom types or relationships in RecordKeys. To establish these relationships in CloudKit, use CloudKitService methods for parents and children AND set values locally.
/// ```
/// struct SomeRecord: Record {
///     ...
///
///     enum RecordKeys: String, CaseIterable {
///         case someProperty
///     }
/// }
/// ```
/// - Create a memberwise initializer for local use.
/// ```
/// struct SomeRecord: Record {
///     ...
///
///     init(id: String = UUID().uuidString, someProperty: String) {
///         self.id = id
///         self.someProperty = someProperty
///     }
/// }
/// ```
/// - Implement `init?(from record: CKRecord)`
///     - First, attempt to get properties from CKRecord using subscripts, and cast them to their types. If this doesn't succeed, return nil (fail the initializer).
///     - If we succeed in getting the properties, call the memberwise initializer with the values obtained.
/// ```
/// struct SomeRecord: Record {
///     init?(from record: CKRecord) {
///         guard let someProperty = record[RecordKeys.someProperty.rawValue] as? String else {
///             return nil
///         }
///
///         self = SomeRecord(id: record.recordID.recordName, someProperty: someProperty)
///     }
/// }
/// ```
public protocol Record: Identifiable, Hashable {
    /// The record type that CloudKit uses as an identifier for each table of records.
    ///
    /// Usage:
    /// - Make sure to set this value to correspond to what you want the CKRecord.RecordType to be in CloudKit.
    static var recordType: String { get }
    
    /// RecordKeys represents the names of each field of a CKRecord to be stored in CloudKit.
    ///
    /// Usage:
    /// - Implement a RecordKeys enum for each type that conforms to the Record protocol.
    /// - Each case of RecordKeys should match a property named in a Record type exactly.
    /// - Do not include `id` in RecordKeys, because CKRecord.ID handles this separately.
    /// - Do not include parents, children, or other properties that reference custom types or relationships in RecordKeys. To establish these relationships in CloudKit, use CloudKitService methods for parents and children AND set values locally.
    associatedtype RecordKeys: RawRepresentable, CaseIterable where RecordKeys.RawValue: StringProtocol
    
    /// An id that reflects the UUID "Name" property for CloudKit records, or CKRecord.ID for local records.
    /// You can also use `SomeRecord.recordID` for an id that is typed CKRecord.ID.
    ///
    /// Usage:
    /// - When initializing a Record type, use
    /// ```
    /// self = SomeRecord(id: record.recordID.recordName, ...)
    /// ```
    var id: String { get }
    
    /// Initializes an instance of a Record type from a CKRecord.
    init?(from record: CKRecord)
}

public extension Record {
    /// An id that reflects the UUID "Name" property for CloudKit records, as a CKRecord.ID.
    ///
    /// You can also use SomeRecord.id for an id that is typed String.
    var recordID: CKRecord.ID {
        record.recordID
    }
    
    /// All cases of a Record type's RecordKeys enum.
    static var recordKeys: [String] {
        RecordKeys.allCases.compactMap { $0.rawValue as? String }
    }
    
    /// A CKRecord that reflects the local version of a Record type.
    ///
    /// This is computed each time it is used, by comparing RecordKeys cases with the properties of the record.
    var record: CKRecord {
        let record = CKRecord(recordType: Self.recordType, recordID: CKRecord.ID(recordName: id))
        let propertiesMirrored = Mirror(reflecting: self)
        for recordKey in Self.recordKeys {
            if let propertyLabel = propertiesMirrored.children.first(where: { label, value in
                guard let label = label else {
                    return false
                }
                return label == recordKey
            }) {
                record.setValue(propertyLabel.value, forKey: recordKey)
            }
        }
        return record
    }
    
    // MARK: Hashable conformance
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
