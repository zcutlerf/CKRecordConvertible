#  Struct declaration

├─attributes: AttributeListSyntax
│ ╰─[0]: AttributeSyntax
│   ├─atSign: atSign
│   ╰─attributeName: IdentifierTypeSyntax
│     ╰─name: identifier("Record")
├─modifiers: DeclModifierListSyntax
├─structKeyword: keyword(SwiftSyntax.Keyword.struct)
├─name: identifier("SomeRecord")
╰─memberBlock: MemberBlockSyntax
  ├─leftBrace: leftBrace
  ├─members: MemberBlockItemListSyntax
  │ ├─[0]: MemberBlockItemSyntax
  │ │ ╰─decl: VariableDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─bindingSpecifier: keyword(SwiftSyntax.Keyword.var)
  │ │   ╰─bindings: PatternBindingListSyntax
  │ │     ╰─[0]: PatternBindingSyntax
  │ │       ├─pattern: IdentifierPatternSyntax
  │ │       │ ╰─identifier: identifier("stringProperty")
  │ │       ╰─typeAnnotation: TypeAnnotationSyntax
  │ │         ├─colon: colon
  │ │         ╰─type: IdentifierTypeSyntax
  │ │           ╰─name: identifier("String")
  │ ├─[1]: MemberBlockItemSyntax
  │ │ ╰─decl: VariableDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─bindingSpecifier: keyword(SwiftSyntax.Keyword.var)
  │ │   ╰─bindings: PatternBindingListSyntax
  │ │     ╰─[0]: PatternBindingSyntax
  │ │       ├─pattern: IdentifierPatternSyntax
  │ │       │ ╰─identifier: identifier("intProperty")
  │ │       ├─typeAnnotation: TypeAnnotationSyntax
  │ │       │ ├─colon: colon
  │ │       │ ╰─type: IdentifierTypeSyntax
  │ │       │   ╰─name: identifier("Int")
  │ │       ╰─initializer: InitializerClauseSyntax
  │ │         ├─equal: equal
  │ │         ╰─value: IntegerLiteralExprSyntax
  │ │           ╰─literal: integerLiteral("1")
  │ ├─[2]: MemberBlockItemSyntax
  │ │ ╰─decl: VariableDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─bindingSpecifier: keyword(SwiftSyntax.Keyword.var)
  │ │   ╰─bindings: PatternBindingListSyntax
  │ │     ╰─[0]: PatternBindingSyntax
  │ │       ├─pattern: IdentifierPatternSyntax
  │ │       │ ╰─identifier: identifier("dateProperty")
  │ │       ╰─typeAnnotation: TypeAnnotationSyntax
  │ │         ├─colon: colon
  │ │         ╰─type: IdentifierTypeSyntax
  │ │           ╰─name: identifier("Date")
  │ ├─[3]: MemberBlockItemSyntax
  │ │ ╰─decl: VariableDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─bindingSpecifier: keyword(SwiftSyntax.Keyword.var)
  │ │   ╰─bindings: PatternBindingListSyntax
  │ │     ╰─[0]: PatternBindingSyntax
  │ │       ├─pattern: IdentifierPatternSyntax
  │ │       │ ╰─identifier: identifier("arrayOfString")
  │ │       ╰─typeAnnotation: TypeAnnotationSyntax
  │ │         ├─colon: colon
  │ │         ╰─type: ArrayTypeSyntax
  │ │           ├─leftSquare: leftSquare
  │ │           ├─element: ArrayTypeSyntax
  │ │           │ ├─leftSquare: leftSquare
  │ │           │ ├─element: IdentifierTypeSyntax
  │ │           │ │ ╰─name: identifier("String")
  │ │           │ ╰─rightSquare: rightSquare
  │ │           ╰─rightSquare: rightSquare
  │ ├─[4]: MemberBlockItemSyntax
  │ │ ╰─decl: VariableDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─bindingSpecifier: keyword(SwiftSyntax.Keyword.var)
  │ │   ╰─bindings: PatternBindingListSyntax
  │ │     ╰─[0]: PatternBindingSyntax
  │ │       ├─pattern: IdentifierPatternSyntax
  │ │       │ ╰─identifier: identifier("arrayOfInt")
  │ │       ├─typeAnnotation: TypeAnnotationSyntax
  │ │       │ ├─colon: colon
  │ │       │ ╰─type: ArrayTypeSyntax
  │ │       │   ├─leftSquare: leftSquare
  │ │       │   ├─element: IdentifierTypeSyntax
  │ │       │   │ ╰─name: identifier("Int")
  │ │       │   ╰─rightSquare: rightSquare
  │ │       ╰─initializer: InitializerClauseSyntax
  │ │         ├─equal: equal
  │ │         ╰─value: ArrayExprSyntax
  │ │           ├─leftSquare: leftSquare
  │ │           ├─elements: ArrayElementListSyntax
  │ │           ╰─rightSquare: rightSquare
  │ ├─[5]: MemberBlockItemSyntax
  │ │ ╰─decl: VariableDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─bindingSpecifier: keyword(SwiftSyntax.Keyword.var)
  │ │   ╰─bindings: PatternBindingListSyntax
  │ │     ╰─[0]: PatternBindingSyntax
  │ │       ├─pattern: IdentifierPatternSyntax
  │ │       │ ╰─identifier: identifier("arrayOfBool")
  │ │       ╰─typeAnnotation: TypeAnnotationSyntax
  │ │         ├─colon: colon
  │ │         ╰─type: IdentifierTypeSyntax
  │ │           ├─name: identifier("Array")
  │ │           ╰─genericArgumentClause: GenericArgumentClauseSyntax
  │ │             ├─leftAngle: leftAngle
  │ │             ├─arguments: GenericArgumentListSyntax
  │ │             │ ╰─[0]: GenericArgumentSyntax
  │ │             │   ╰─argument: IdentifierTypeSyntax
  │ │             │     ╰─name: identifier("Bool")
  │ │             ╰─rightAngle: rightAngle
  │ ├─[6]: MemberBlockItemSyntax
  │ │ ╰─decl: MacroExpansionDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─pound: pound
  │ │   ├─macroName: identifier("warning")
  │ │   ├─leftParen: leftParen
  │ │   ├─arguments: LabeledExprListSyntax
  │ │   │ ╰─[0]: LabeledExprSyntax
  │ │   │   ╰─expression: StringLiteralExprSyntax
  │ │   │     ├─openingQuote: stringQuote
  │ │   │     ├─segments: StringLiteralSegmentListSyntax
  │ │   │     │ ╰─[0]: StringSegmentSyntax
  │ │   │     │   ╰─content: stringSegment("Does not ignore optional values yet.")
  │ │   │     ╰─closingQuote: stringQuote
  │ │   ├─rightParen: rightParen
  │ │   ╰─additionalTrailingClosures: MultipleTrailingClosureElementListSyntax
  │ ├─[7]: MemberBlockItemSyntax
  │ │ ╰─decl: VariableDeclSyntax
  │ │   ├─attributes: AttributeListSyntax
  │ │   ├─modifiers: DeclModifierListSyntax
  │ │   ├─bindingSpecifier: keyword(SwiftSyntax.Keyword.var)
  │ │   ╰─bindings: PatternBindingListSyntax
  │ │     ╰─[0]: PatternBindingSyntax
  │ │       ├─pattern: IdentifierPatternSyntax
  │ │       │ ╰─identifier: identifier("optional")
  │ │       ╰─typeAnnotation: TypeAnnotationSyntax
  │ │         ├─colon: colon
  │ │         ╰─type: OptionalTypeSyntax
  │ │           ├─wrappedType: IdentifierTypeSyntax
  │ │           │ ╰─name: identifier("Int")
  │ │           ╰─questionMark: postfixQuestionMark
  │ ╰─[8]: MemberBlockItemSyntax
  │   ╰─decl: FunctionDeclSyntax
  │     ├─attributes: AttributeListSyntax
  │     ├─modifiers: DeclModifierListSyntax
  │     ├─funcKeyword: keyword(SwiftSyntax.Keyword.func)
  │     ├─name: identifier("someMethod")
  │     ├─signature: FunctionSignatureSyntax
  │     │ ╰─parameterClause: FunctionParameterClauseSyntax
  │     │   ├─leftParen: leftParen
  │     │   ├─parameters: FunctionParameterListSyntax
  │     │   ╰─rightParen: rightParen
  │     ╰─body: CodeBlockSyntax
  │       ├─leftBrace: leftBrace
  │       ├─statements: CodeBlockItemListSyntax
  │       │ ╰─[0]: CodeBlockItemSyntax
  │       │   ╰─item: FunctionCallExprSyntax
  │       │     ├─calledExpression: DeclReferenceExprSyntax
  │       │     │ ╰─baseName: identifier("print")
  │       │     ├─leftParen: leftParen
  │       │     ├─arguments: LabeledExprListSyntax
  │       │     │ ╰─[0]: LabeledExprSyntax
  │       │     │   ╰─expression: StringLiteralExprSyntax
  │       │     │     ├─openingQuote: stringQuote
  │       │     │     ├─segments: StringLiteralSegmentListSyntax
  │       │     │     │ ╰─[0]: StringSegmentSyntax
  │       │     │     │   ╰─content: stringSegment("this is a method")
  │       │     │     ╰─closingQuote: stringQuote
  │       │     ├─rightParen: rightParen
  │       │     ╰─additionalTrailingClosures: MultipleTrailingClosureElementListSyntax
  │       ╰─rightBrace: rightBrace
  ╰─rightBrace: rightBrace)
