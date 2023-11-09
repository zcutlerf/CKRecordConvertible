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
        return ["let id = UUID()"]
    }
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        let members = declaration.memberBlock.members
        let bindings: [PatternBindingListSyntax.Element] = members.compactMap { member in
            member.decl.as(VariableDeclSyntax.self)?.bindings.first
        }
        let identifierStrings: [String] = bindings.compactMap { binding in
            binding.as(PatternBindingListSyntax.Element.self)?
                .pattern.as(IdentifierPatternSyntax.self)?.identifier.text
        }
        let allIdentifiers = identifierStrings.joined(separator: ", ")
        let recordExtension: DeclSyntax =
            """
            extension \(type.trimmed): Record {
                enum RecordKeys: String, CaseIterable {
                    case \(raw: allIdentifiers)
                }
            }
            """
        //TODO: problem is that type is not mirroring anything
        
        guard let recordExtension = recordExtension.as(ExtensionDeclSyntax.self) else {
            return []
        }
        
        return [recordExtension]
    }
}

@main
struct CKRecordInitializablePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        RecordMacro.self,
    ]
}
