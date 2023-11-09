import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(CKRecordInitializableMacros)
import CKRecordInitializableMacros

let testMacros: [String: Macro.Type] = [
    "recordMacro": RecordMacro.self,
]
#endif

final class CKRecordInitializableTests: XCTestCase {
    func testMacro() throws {
//        #if canImport(CKRecordInitializableMacros)
//        assertMacroExpansion(
//            """
//            #stringify(a + b)
//            """,
//            expandedSource: """
//            (a + b, "a + b")
//            """,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
    }

    func testMacroWithStringLiteral() throws {
//        #if canImport(CKRecordInitializableMacros)
//        assertMacroExpansion(
//            #"""
//            #stringify("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
    }
}