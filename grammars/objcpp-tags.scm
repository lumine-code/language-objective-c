(class_interface
  (identifier) @name) @definition.class

(class_implementation
  (identifier) @name) @definition.class

(protocol_declaration
  (identifier) @name) @definition.interface

(method_declaration
  (identifier) @name) @definition.method

(method_definition
  (identifier) @name) @definition.method

(property_declaration
  (struct_declaration
    (struct_declarator
      (identifier) @name))) @definition.field

(message_expression
  receiver: (identifier) @name) @reference.call

(message_expression
  method: (identifier) @name) @reference.call

(module_import
  path: (identifier) @name) @reference.module
