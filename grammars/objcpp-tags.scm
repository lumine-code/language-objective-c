; Objective-C and C declarations share objc-tags.scm; these add C++ constructs.
(class_specifier name: [(type_identifier) (qualified_identifier) (template_type)] @name) @definition.class
(namespace_definition name: [(namespace_identifier) (nested_namespace_specifier)] @name) @definition.module
(function_declarator declarator: (field_identifier) @name) @definition.method
(function_declarator declarator: (qualified_identifier) @name) @definition.function
