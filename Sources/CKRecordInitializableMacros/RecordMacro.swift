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
        // Add a new property id that is a UUID().
        return ["let id = UUID()"]
    }
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        // Get all of the property names from the type to be expanded.
        let members = declaration.memberBlock.members
        let bindings: [PatternBindingListSyntax.Element] = members.compactMap { member in
            member.decl.as(VariableDeclSyntax.self)?.bindings.first
        }
        let identifierStrings: [String] = bindings.compactMap { binding in
            binding.as(PatternBindingListSyntax.Element.self)?
                .pattern.as(IdentifierPatternSyntax.self)?.identifier.text
        }
        // All of the identifiers, separated by commas, to use as cases of the RecordKeys enum.
        let allIdentifiers = identifierStrings.joined(separator: ", ")
        
        // Guard stuff
        let identifiersAndTypes = bindings.compactMap { binding in
            if let name = binding.as(PatternBindingListSyntax.Element.self)?
                .pattern.as(IdentifierPatternSyntax.self)?.identifier.text,
               let type = binding.as(PatternBindingListSyntax.Element.self)?
                .typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text {
                return (name: name, type: type)
            } else {
                return nil
            }
        }
        
        // Guard let
        let accessingValuesFromCKRecord = identifiersAndTypes.map { (name, type) in
            "let \(name) = record[RecordKeys.\(name).rawValue as? \(type)]"
        }.joined(separator: ",\n")
        
        // Init fill in
        let fillingInInitializerWithProperties = identifiersAndTypes.map { (name, type) in
            "\(name): \(name)"
        }.joined(separator: ", ")
        
        // Create the extension.
        let recordExtension: DeclSyntax =
            """
            extension \(type.trimmed): Record {
                enum RecordKeys: String, CaseIterable {
                    case \(raw: allIdentifiers)
                }
            
                init?(from record: CKRecord) {
                    guard \(raw: accessingValuesFromCKRecord) else {
                        return nil
                    }
                     
                    self = \(type.trimmed)(id: record.recordID.recordName, \(raw: fillingInInitializerWithProperties)
                }
            }
            """
        
        /*
         init?(from record: CKRecord) {
             guard let displayName = record[RecordKeys.displayName.rawValue] as? String,
                   let startDate = record[RecordKeys.startDate.rawValue] as? Date,
                   let startTime = record[RecordKeys.startTime.rawValue] as? Date,
                   let endTime = record[RecordKeys.endTime.rawValue] as? Date,
                   let allowableAbsenceDays = record[RecordKeys.allowableAbsenceDays.rawValue] as? Int else {
                 return nil
             }
             
             self = \(type.trimmed)(id: record.recordID.recordName, displayName: displayName, startDate: startDate, startTime: startTime, endTime: endTime, allowableAbsenceDays: allowableAbsenceDays)
         }
         */
        
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
