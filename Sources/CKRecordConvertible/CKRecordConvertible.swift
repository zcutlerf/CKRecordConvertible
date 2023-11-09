// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: named(id))
@attached(extension, conformances: Record, names: named(recordType), named(RecordKeys), named(init(from:)), named(init))
public macro Record() = #externalMacro(module: "CKRecordConvertibleMacros", type: "RecordMacro")
