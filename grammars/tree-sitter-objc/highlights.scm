; inherits: c

; Preprocs

(preproc_undef
  name: (_) @constant.other.objc) @keyword.control.directive.objc

; Includes

(module_import "@import" @keyword.control.import.objc path: (identifier) @entity.name.namespace.objc)

((preproc_include
  _ @keyword.control.import.objc path: (_))
  (#any-of? @keyword.control.import.objc "#include" "#import"))

; Type Qualifiers

[
  "@optional"
  "@required"
  "__covariant"
  "__contravariant"
  (visibility_specification)
] @support.type.qualifier.objc

; Storageclasses

[
  "@autoreleasepool"
  "@synthesize"
  "@dynamic"
  "volatile"
  (protocol_qualifier)
] @storage.modifier.objc

; Keywords

[
  "@protocol"
  "@interface"
  "@implementation"
  "@compatibility_alias"
  "@property"
  "@selector"
  "@defs"
  "availability"
  "@end"
] @keyword.control.objc

(class_declaration "@" @keyword.control.objc "class" @keyword.control.objc) ; I hate Obj-C for allowing "@ class" :)

(method_definition ["+" "-"] @storage.type.function.objc)
(method_declaration ["+" "-"] @storage.type.function.objc)

[
  "__typeof__"
  "__typeof"
  "typeof"
  "in"
] @keyword.operator.word.objc

[
  "@synchronized"
  "oneway"
] @keyword.control.objc

; Exceptions

[
  "@try"
  "__try"
  "@catch"
  "__catch"
  "@finally"
  "__finally"
  "@throw"
] @keyword.control.exception.objc

; Variables

((identifier) @variable.language.objc
  (#any-of? @variable.language.objc "self" "super"))

; Functions & Methods

[
  "objc_bridge_related"
  "@available"
  "__builtin_available"
  "va_arg"
  "asm"
] @support.function.builtin.objc

(method_definition (identifier) @entity.name.function.method.objc)

(method_declaration (identifier) @entity.name.function.method.objc)

(method_identifier (identifier)? @entity.name.function.method.objc ":" @entity.name.function.method.objc (identifier)? @entity.name.function.method.objc)

(message_expression method: (identifier) @support.other.function.method.objc)

; Constructors

((message_expression method: (identifier) @entity.name.function.constructor.objc)
  (#eq? @entity.name.function.constructor.objc "init"))

; Attributes

(availability_attribute_specifier
  [
    "CF_FORMAT_FUNCTION" "NS_AVAILABLE" "__IOS_AVAILABLE" "NS_AVAILABLE_IOS"
    "API_AVAILABLE" "API_UNAVAILABLE" "API_DEPRECATED" "NS_ENUM_AVAILABLE_IOS"
    "NS_DEPRECATED_IOS" "NS_ENUM_DEPRECATED_IOS" "NS_FORMAT_FUNCTION" "DEPRECATED_MSG_ATTRIBUTE"
    "__deprecated_msg" "__deprecated_enum_msg" "NS_SWIFT_NAME" "NS_SWIFT_UNAVAILABLE"
    "NS_EXTENSION_UNAVAILABLE_IOS" "NS_CLASS_AVAILABLE_IOS" "NS_CLASS_DEPRECATED_IOS" "__OSX_AVAILABLE_STARTING"
    "NS_ROOT_CLASS" "NS_UNAVAILABLE" "NS_REQUIRES_NIL_TERMINATION" "CF_RETURNS_RETAINED"
    "CF_RETURNS_NOT_RETAINED" "DEPRECATED_ATTRIBUTE" "UI_APPEARANCE_SELECTOR" "UNAVAILABLE_ATTRIBUTE"
  ]) @entity.other.attribute-name.objc

; Macros

(type_qualifier
  [
    "_Complex"
    "_Nonnull"
    "_Nullable"
    "_Nullable_result"
    "_Null_unspecified"
    "__autoreleasing"
    "__block"
    "__bridge"
    "__bridge_retained"
    "__bridge_transfer"
    "__complex"
    "__kindof"
    "__nonnull"
    "__nullable"
    "__ptrauth_objc_class_ro"
    "__ptrauth_objc_isa_pointer"
    "__ptrauth_objc_super_pointer"
    "__strong"
    "__thread"
    "__unsafe_unretained"
    "__unused"
    "__weak"
  ]) @entity.name.function.macro.builtin.objc

[ "__real" "__imag" ] @entity.name.function.macro.builtin.objc

((call_expression function: (identifier) @entity.name.function.macro.objc)
  (#eq? @entity.name.function.macro.objc "testassert"))

; Types

(class_declaration (identifier) @support.type.objc)

(class_interface "@interface" . (identifier) @support.type.objc superclass: _? @support.type.objc category: _? @entity.name.namespace.objc)

(class_implementation "@implementation" . (identifier) @support.type.objc superclass: _? @support.type.objc category: _? @entity.name.namespace.objc)

(protocol_forward_declaration (identifier) @support.type.objc) ; @interface :(

(protocol_reference_list (identifier) @support.type.objc) ; ^

[
  "BOOL"
  "IMP"
  "SEL"
  "Class"
  "id"
] @support.type.builtin.objc

; Constants

(property_attribute (identifier) @constant.other.objc "="?)

[ "__asm" "__asm__" ] @entity.name.function.preprocessor.objc

; Properties

(property_implementation "@synthesize" (identifier) @variable.other.member.objc)

((identifier) @variable.other.member.objc
  (#is? test.descendantOfType "struct_declaration"))

; Parameters

(method_parameter ":" @entity.name.function.method.objc (identifier) @variable.parameter.objc)

(method_parameter declarator: (identifier) @variable.parameter.objc)

(parameter_declaration
  declarator: (function_declarator
                declarator: (parenthesized_declarator
                              (block_pointer_declarator
                                declarator: (identifier) @variable.parameter.objc))))

"..." @variable.parameter.builtin.objc

; Operators

[
  "^"
] @keyword.operator.objc

; Literals

(platform) @string.other.objc

(version_number) @markup.underline.link.objc @constant.numeric.objc

; Punctuation

; The `@` that introduces a directive or a literal.
"@" @punctuation.definition.keyword.objc

"<" @punctuation.definition.protocol.begin.bracket.angle.objc
">" @punctuation.definition.protocol.end.bracket.angle.objc
