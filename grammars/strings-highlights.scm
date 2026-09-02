(block_comment) @comment.block.strings
(line_comment) @comment.line.double-slash.strings

((block_comment) @punctuation.definition.comment.begin.strings
  (#set! adjust.startAndEndAroundFirstMatchOf "^/\\*"))
((block_comment) @punctuation.definition.comment.end.strings
  (#set! adjust.startAndEndAroundFirstMatchOf "\\*/$"))
((line_comment) @punctuation.definition.comment.strings
  (#set! adjust.startAndEndAroundFirstMatchOf "^//"))

(assignment_statement
  left: (string_literal) @constant.other.key.strings)

(assignment_statement
  right: (string_literal) @string.quoted.double.strings)

((string_literal) @punctuation.definition.string.begin.strings
  (#set! adjust.startAndEndAroundFirstMatchOf "^\""))
((string_literal) @punctuation.definition.string.end.strings
  (#set! adjust.startAndEndAroundFirstMatchOf "\"$"))

"=" @keyword.operator.assignment.strings
";" @punctuation.terminator.statement.strings
