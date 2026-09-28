const fs = require("fs");
const path = require("path");
const { Point } = require("lumine");

const OBJC_HIGHLIGHTS_PATH = path.join(__dirname, "..", "grammars", "objc-highlights.scm");
const OBJCPP_HIGHLIGHTS_PATH = path.join(__dirname, "..", "grammars", "objcpp-highlights.scm");

describe("Objective-C Tree-sitter grammars", () => {
  beforeEach(async () => {
    await lumine.packages.activatePackage("language-c");
    await lumine.packages.activatePackage("language-objective-c");
  });

  async function openFixture(name) {
    const editor = await lumine.workspace.open(path.join(__dirname, "fixtures", name));
    await editor.languageMode.ready;
    return editor;
  }

  it("parses Objective-C++ and scopes Objective-C declarations", async () => {
    const editor = await openFixture("sample.mm");

    expect(editor.getGrammar().scopeName).toBe("source.objcpp");
    expect((await editor.getSyntaxDiagnostics()).hasError).toBe(false);

    const scopes = editor.scopeDescriptorForBufferPosition([7, 11]).getScopesArray();
    expect(scopes).toContain("entity.name.type.class.objcpp");
  });

  it("parses Strings files and distinguishes keys from values", async () => {
    const editor = await openFixture("sample.strings");

    expect(editor.getGrammar().scopeName).toBe("source.strings");
    expect((await editor.getSyntaxDiagnostics()).hasError).toBe(false);
    expect(editor.scopeDescriptorForBufferPosition([1, 2]).getScopesArray()).toContain(
      "constant.other.key.strings",
    );
    expect(editor.scopeDescriptorForBufferPosition([1, 19]).getScopesArray()).toContain(
      "string.quoted.double.strings",
    );
  });

  it("keeps protocol references local inside a 6000-protocol list", async () => {
    for (const queryPath of [OBJC_HIGHLIGHTS_PATH, OBJCPP_HIGHLIGHTS_PATH]) {
      const query = fs.readFileSync(queryPath, "utf8");
      expect(query).not.toMatch(/\(protocol_reference_list\s+\(identifier\)/);
      expect(query).toContain("(#is? test.childOfType protocol_reference_list)");
    }

    const editor = await lumine.workspace.open("protocol-locality.m");
    const lines = [
      "@protocol Formatter <NSObject,",
      ...Array.from(
        { length: 6000 },
        (_, index) => `  Protocol${index}${index === 5999 ? "" : ","}`,
      ),
      ">",
      "@end",
    ];
    editor.setText(lines.join("\r\n"));
    const languageMode = editor.getBuffer().languageMode;
    await languageMode.ready;
    expect((await editor.getSyntaxDiagnostics()).hasError).toBe(false);
    const protocolColumn = editor.lineTextForBufferRow(1).indexOf("Protocol0");
    expect(editor.scopeDescriptorForBufferPosition([1, protocolColumn]).getScopesArray()).toContain(
      "support.type.objc",
    );

    const startRow = 2998;
    const endRow = startRow + 6;
    const groups = await editor.getGrammarQueryCaptureGroups("highlightsQuery", {
      startPosition: new Point(startRow, 0),
      endPosition: new Point(endRow, 0),
    });
    const captures = groups.find(({ grammar }) => grammar === editor.getGrammar()).captures;
    expect(captures.length).toBeLessThanOrEqual(48);
    expect(
      captures
        .filter(({ name }) => name === "support.type.objc")
        .every(({ node }) => node.startPosition.row >= startRow && node.startPosition.row < endRow),
    ).toBe(true);
  });
});
