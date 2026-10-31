; Raw-string parentheses quote data, including when recovery drops the literal
; wrapper. Its raw prefix identifies the opener without rejecting other errors.
(raw_string_literal ["(" ")"] @_IGNORE_ (#set! capture.final true))
(ERROR ["R\"" "LR\"" "uR\"" "UR\"" "u8R\""]
  . (raw_string_delimiter)? . "(" @_IGNORE_
  (#set! capture.final true))

; Only explicit delimiters change indentation; incomplete expressions do not.
["{" "[" "("] @indent
["}" "]" ")"] @dedent

; Reindent code without rewriting whitespace that belongs to multiline text.
([(string_literal) (raw_string_literal) (comment)] @preserve
  (#is? indent.reindent true)
  (#is-not? indent.matchesCurrentRow startPosition)
  (#set! indent.force true))
