// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: named(id))
@attached(extension, conformances: Record, names: named(RecordKeys), named(init(from:)))
public macro Record() = #externalMacro(module: "CKRecordInitializableMacros", type: "RecordMacro")
