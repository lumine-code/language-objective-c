; Keep the owning class's first identifier, not its superclass or category.
(class_interface . (identifier) @name) @definition.class
(class_implementation . (identifier) @name) @definition.class
(protocol_declaration . (identifier) @name) @definition.interface
[(method_declaration (identifier) @name .)
 (method_definition (identifier) @name . (compound_statement))] @definition.method
; Keyword methods have arguments after the leading selector identifier.
(method_declaration (identifier) @name (method_parameter)) @definition.method
(method_definition (identifier) @name (method_parameter)) @definition.method
(property_declaration (struct_declaration (struct_declarator (identifier) @name))) @definition.property
(type_definition declarator: (type_identifier) @name) @definition.type
[(struct_specifier name: (type_identifier) @name)
 (enum_specifier name: (type_identifier) @name)] @definition.struct
(function_declarator declarator: (identifier) @name) @definition.function
(preproc_def name: (identifier) @name) @definition.constant
(preproc_function_def name: (identifier) @name) @definition.macro

; Optional call/module references retain the provider's reference mode.
(message_expression receiver: (identifier) @name) @reference.call
(message_expression method: (identifier) @name) @reference.call
(module_import path: (identifier) @name) @reference.module
