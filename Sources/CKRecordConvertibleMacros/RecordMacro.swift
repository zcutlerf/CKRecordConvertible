import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct RecordMacro: MemberMacro, ExtensionMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        let members = declaration.memberBlock.members
        let variableDeclarations = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
        let variables: [VariableDeclaration] = variableDeclarations.compactMap { declaration in
            guard let name = declaration.bindings.first?.pattern,
                  let type = declaration.bindings.first?.typeAnnotation?.type else {
                return nil
            }
            let initialValue = declaration.bindings.first?.initializer?.value
            return VariableDeclaration(name: name, type: type, initialValue: initialValue)
        }
        
        let init_standardSignature = init_standardSignature(variables: variables)
        let init_setPropertiesToSelf = init_setPropertiesToSelf(variables: variables)
        
        // Create the extension.
        let newMembers: DeclSyntax =
            """
            var id: String
            
            \(init_standardSignature) {
                self.id = id
                \(init_setPropertiesToSelf)
            }
            """
        
        guard let newMembers = newMembers.as(DeclSyntax.self) else {
            return []
        }
        
        return [newMembers]
    }
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        let members = declaration.memberBlock.members
        let variableDeclarations = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
        let variables: [VariableDeclaration] = variableDeclarations.compactMap { declaration in
            guard let name = declaration.bindings.first?.pattern,
                  let type = declaration.bindings.first?.typeAnnotation?.type else {
                return nil
            }
            let initialValue = declaration.bindings.first?.initializer?.value
            return VariableDeclaration(name: name, type: type, initialValue: initialValue)
        }
        
        let recordKeys_cases = recordKeys_cases(variables: variables)
        let initFromRecord_unwrapCKRecordProperties = initFromRecord_unwrapCKRecordProperties(variables: variables)
        let initFromRecord_fillInStandardInit = initFromRecord_fillInStandardInit(variables: variables)
        
        // Create the extension.
        let recordExtension: DeclSyntax =
            """
            extension \(type.trimmed): Record {
                static var recordType: String = "\(type.trimmed)"
            
                enum RecordKeys: String, CaseIterable {
                    case \(recordKeys_cases)
                }
            
                init?(from record: CKRecord) {
                    guard \(initFromRecord_unwrapCKRecordProperties) else {
                        return nil
                    }
                     
                    self = \(type.trimmed)(id: record.recordID.recordName, \(initFromRecord_fillInStandardInit))
                }
            }
            """
        
        guard let recordExtension = recordExtension.as(ExtensionDeclSyntax.self) else {
            return []
        }
        
        return [recordExtension]
    }
}

@main
struct CKRecordConvertiblePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        RecordMacro.self,
    ]
}
