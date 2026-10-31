describe("objective-c editing settings", () => {
  let editor;
  beforeEach(async () => {
    jasmine.useRealClock();
    editor = null;
    await lumine.packages.activatePackage("language-objective-c");
    await lumine.packages.activatePackage("language-c");
  });
  afterEach(() => editor?.destroy());
  async function start(scope, text = "value") {
    editor ??= await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName(scope));
    editor.setText(text);
    expect(await editor.whenGrammarSettled()).toBe(true);
    editor.update({ autoIndent: false });
  }
  for (const [scope, line, block] of [
    ["source.objc", "//", ["/*", "*/"]],
    ["source.objcpp", "//", ["/*", "*/"]],
    ["source.strings", "//", ["/*", "*/"]],
  ]) {
    it("exposes line and block comment metadata in " + scope, async () => {
      await start(scope);
      expect(await editor.getCommentDelimitersForBufferPosition([0, 0])).toEqual({ line, block });
      await editor.toggleLineCommentsForBufferRows(0, 0);
      expect(editor.getText()).toBe(line + " value");
      await editor.toggleLineCommentsForBufferRows(0, 0);
      expect(editor.getText()).toBe("value");
    });
    it("round trips block comments using the advertised delimiters in " + scope, async () => {
      await start(scope);
      const { block } = await editor.getCommentDelimitersForBufferPosition([0, 0]);
      const options = {
        commentStrings: { commentStartString: block[0], commentEndString: block[1] },
      };
      await editor.toggleLineCommentsForBufferRows(0, 0, options);
      expect(editor.getText()).toBe(block[0] + " value " + block[1]);
      await editor.toggleLineCommentsForBufferRows(0, 0, options);
      expect(editor.getText()).toBe("value");
    });
  }
  it("uses explicit Objective-C markers to select ambiguous headers", () => {
    for (const text of ["#include <stdint.h>\nint value;", "# include <stdint.h>\nint value;"])
      expect(lumine.grammars.selectGrammar("header.h", text).scopeName).toBe("source.c");
    for (const text of [
      "#import <Foundation/Foundation.h>\n",
      "// Header\n@interface Test\n@end",
      "#include <stdint.h>\n@class Test;",
    ])
      expect(lumine.grammars.selectGrammar("header.h", text).scopeName).toBe("source.objc");
    expect(
      lumine.grammars.selectGrammar("header.h", "#include <vector>\nnamespace example {}\n")
        .scopeName,
    ).toBe("source.cpp");
  });
});
