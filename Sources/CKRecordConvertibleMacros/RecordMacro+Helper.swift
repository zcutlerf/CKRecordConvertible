import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension RecordMacro {
    struct VariableDeclaration {
        var name: PatternSyntax
        var type: TypeSyntax
        var initialValue: ExprSyntax?
    }
    
    internal static func init_standardSignature(variables: [VariableDeclaration]) -> SyntaxNodeString {
        var syntaxNodeString: String = "init(id: String = UUID().uuidString, "
        syntaxNodeString += variables.map { variable in
            if let initialValue = variable.initialValue {
                return "\(variable.name): \(variable.type) = \(initialValue)"
            } else if variable.type.is(OptionalTypeSyntax.self) {
                return "\(variable.name): \(variable.type) = nil"
            } else {
                return "\(variable.name): \(variable.type)"
            }
        }.joined(separator: ", ")
        syntaxNodeString += ")"
        return SyntaxNodeString(stringLiteral: syntaxNodeString)
    }
    
    internal static func init_setPropertiesToSelf(variables: [VariableDeclaration]) -> SyntaxNodeString {
        SyntaxNodeString(stringLiteral: variables.map { variable in
            "self.\(variable.name) = \(variable.name)"
        }.joined(separator: "\n"))
    }
    
    internal static func recordKeys_cases(variables: [VariableDeclaration]) -> SyntaxNodeString {
        SyntaxNodeString(stringLiteral: variables.compactMap { variable in
            if variable.initialValue == nil && !variable.type.is(OptionalTypeSyntax.self) {
                return "\(variable.name)"
            } else {
                return nil
            }
        }.joined(separator: ", "))
    }
    
    internal static func initFromRecord_unwrapCKRecordProperties(variables: [VariableDeclaration]) -> SyntaxNodeString {
        SyntaxNodeString(stringLiteral: variables.compactMap { variable in
            if variable.initialValue == nil && !variable.type.is(OptionalTypeSyntax.self) {
                return "let \(variable.name) = record[RecordKeys.\(variable.name).rawValue] as? \(variable.type)"
            } else {
                return nil
            }
        }.joined(separator: ",\n"))
    }
    
    internal static func initFromRecord_fillInStandardInit(variables: [VariableDeclaration]) -> SyntaxNodeString {
        SyntaxNodeString(stringLiteral: variables.compactMap { variable in
            if variable.initialValue == nil && !variable.type.is(OptionalTypeSyntax.self) {
                return "\(variable.name): \(variable.name)"
            } else {
                return nil
            }
        }.joined(separator: ", "))
    }
}
