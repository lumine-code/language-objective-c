[
  "@interface"
  "@implementation"
  "@protocol"
  "@end"
  "@class"
  "@import"
  "@compatibility_alias"
  "@autoreleasepool"
  "@synchronized"
  "@try"
  "@catch"
  "@finally"
  "@throw"
  "@selector"
  "@encode"
  "@available"
  "@synthesize"
  "@dynamic"
  "@property"
  "@optional"
  "@required"
] @keyword.control.objcpp

[
  "NS_ENUM"
  "NS_OPTIONS"
  "NS_CLOSED_ENUM"
  "NS_ERROR_ENUM"
  "CF_ENUM"
  "CF_OPTIONS"
  "CF_CLOSED_ENUM"
] @support.function.macro.objcpp

(visibility_specification) @storage.modifier.objcpp
(type_qualifier) @storage.modifier.objcpp

[
  "__covariant"
  "__contravariant"
] @storage.modifier.objcpp

[
  "BOOL"
  "IMP"
  "SEL"
  "Class"
  "id"
] @support.type.builtin.objcpp

(method_declaration
  ["+" "-"] @storage.type.method.objcpp)

(method_definition
  ["+" "-"] @storage.type.method.objcpp)

(method_declaration
  (identifier) @entity.name.function.method.objcpp)

(method_definition
  (identifier) @entity.name.function.method.objcpp)

(message_expression
  method: (identifier) @entity.name.function.method.objcpp)

(message_expression
  receiver: (identifier) @variable.other.object.objcpp)

(selector_expression
  (method_identifier
    (identifier) @entity.name.function.method.objcpp))

(protocol_declaration
  (identifier) @entity.name.type.protocol.objcpp)

(protocol_forward_declaration
  (identifier) @entity.name.type.protocol.objcpp)

((identifier) @entity.name.type.protocol.objcpp
  (#is? test.childOfType protocol_reference_list))

(class_interface
  (identifier) @entity.name.type.class.objcpp)

(class_implementation
  (identifier) @entity.name.type.class.objcpp)

(class_forward_declaration
  (identifier) @entity.name.type.class.objcpp)

(class_interface
  category: (identifier) @entity.name.type.category.objcpp)

(class_implementation
  category: (identifier) @entity.name.type.category.objcpp)

(class_interface
  superclass: (identifier) @entity.other.inherited-class.objcpp)

(class_implementation
  superclass: (identifier) @entity.other.inherited-class.objcpp)

(property_attribute
  (identifier) @entity.other.attribute-name.objcpp)

(property_declaration
  (struct_declaration
    (struct_declarator
      (identifier) @variable.other.property.objcpp)))

(property_declaration
  (struct_declaration
    (struct_declarator
      (pointer_declarator
        declarator: (identifier) @variable.other.property.objcpp))))

(property_implementation
  (identifier) @variable.other.property.objcpp)

(module_import
  path: (identifier) @entity.name.namespace.objcpp)

(availability_attribute_specifier) @entity.other.attribute-name.objcpp

"@" @punctuation.definition.keyword.objcpp

(block_literal
  "^" @keyword.operator.block.objcpp)

(block_pointer_declarator
  "^" @keyword.operator.block.objcpp)

(dictionary_literal
  "{" @punctuation.definition.dictionary.begin.bracket.curly.objcpp
  "}" @punctuation.definition.dictionary.end.bracket.curly.objcpp)

(array_literal
  "[" @punctuation.definition.array.begin.bracket.square.objcpp
  "]" @punctuation.definition.array.end.bracket.square.objcpp)

(string_literal
  "@" @punctuation.definition.string.objcpp)

(version_number) @constant.numeric.version.objcpp
(platform) @constant.language.platform.objcpp
