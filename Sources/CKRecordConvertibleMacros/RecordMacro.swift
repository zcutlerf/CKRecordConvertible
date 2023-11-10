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
        // Get all of the property names from the type to be expanded.
        let members = declaration.memberBlock.members
        let bindings: [PatternBindingListSyntax.Element] = members.compactMap { member in
            member.decl.as(VariableDeclSyntax.self)?.bindings.first
        }
        
        // All of the properties' identifiers and types, as a tuple.
        let identifiersAndTypes = bindings.compactMap { binding in
#warning("Ignore if member has default value")
            if let name = binding.as(PatternBindingListSyntax.Element.self)?
                .pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
                
                if let type = binding
                    .typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text {
                    return (name: name, type: type)
                } else if let type = binding.typeAnnotation?.type.as(ArrayTypeSyntax.self)?.element.as(IdentifierTypeSyntax.self)?.name.text {
                    return (name: name, type: "[\(type)]")
                } else {
#warning("What else do we need to handle besides arrays?")
                    return nil
                }
            } else {
                return nil
            }
        }
        
        // All of the properties with their types, for standard initializer signature.
        let identifiersAndTypesForInit = identifiersAndTypes.map { (name, type) in
            "\(name): \(type)"
        }.joined(separator: ", ")
        
        // All of the properties, setting to self.
        let allPropertiesSetToSelf = identifiersAndTypes.map { (name, _) in
            "self.\(name) = \(name)"
        }.joined(separator: "\n")
        
        // Create the extension.
        let newMembers: DeclSyntax =
            """
            var id: String
            
            init(id: String = UUID().uuidString, \(raw: identifiersAndTypesForInit)) {
                self.id = id
                \(raw: allPropertiesSetToSelf)
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
        // Get all of the property names from the type to be expanded.
        let members = declaration.memberBlock.members
        let bindings: [PatternBindingListSyntax.Element] = members.compactMap { member in
            member.decl.as(VariableDeclSyntax.self)?.bindings.first
        }
        
        // All of the properties' identifiers and types, as a tuple.
        let identifiersAndTypes = bindings.compactMap { binding in
#warning("Ignore if member has default value")
            if let name = binding.as(PatternBindingListSyntax.Element.self)?
                .pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
                
                if let type = binding
                    .typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text {
                    return (name: name, type: type)
                } else if let type = binding.typeAnnotation?.type.as(ArrayTypeSyntax.self)?.element.as(IdentifierTypeSyntax.self)?.name.text {
                    return (name: name, type: "[\(type)]")
                } else {
#warning("What else do we need to handle besides arrays?")
                    return nil
                }
            } else {
                return nil
            }
        }
        // All of the properties' identifier names, separated by commas, to use as cases of the RecordKeys enum.
        let recordKeysIdentifierNames = identifiersAndTypes.map { (name, _) in
            "\(name)"
        }.joined(separator: ", ")
        
        // All of the optional constants we expect from incoming CKRecord, to use in our guard statement in the initializer.
        let accessingValuesFromCKRecord = identifiersAndTypes.map { (name, type) in
            "let \(name) = record[RecordKeys.\(name).rawValue] as? \(type)"
        }.joined(separator: ",\n")
        
        // All of the properties to be filled into the initializer.
        let fillingInInitializerWithProperties = identifiersAndTypes.map { (name, _) in
            "\(name): \(name)"
        }.joined(separator: ", ")
        
        // Create the extension.
        let recordExtension: DeclSyntax =
            """
            extension \(type.trimmed): Record {
                static var recordType: String = "\(type.trimmed)"
            
                enum RecordKeys: String, CaseIterable {
                    case \(raw: recordKeysIdentifierNames)
                }
            
                init?(from record: CKRecord) {
                    guard \(raw: accessingValuesFromCKRecord) else {
                        return nil
                    }
                     
                    self = \(type.trimmed)(id: record.recordID.recordName, \(raw: fillingInInitializerWithProperties))
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
