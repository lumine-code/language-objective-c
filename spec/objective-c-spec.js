const path = require("path");

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
    const languageMode = editor.getBuffer().getLanguageMode();

    expect(editor.getGrammar().scopeName).toBe("source.objcpp");
    expect(languageMode.tree.rootNode.hasError).toBe(false);

    const scopes = editor.scopeDescriptorForBufferPosition([7, 11]).getScopesArray();
    expect(scopes).toContain("entity.name.type.class.objcpp");
  });

  it("parses Strings files and distinguishes keys from values", async () => {
    const editor = await openFixture("sample.strings");
    const languageMode = editor.getBuffer().getLanguageMode();

    expect(editor.getGrammar().scopeName).toBe("source.strings");
    expect(languageMode.tree.rootNode.hasError).toBe(false);
    expect(editor.scopeDescriptorForBufferPosition([1, 2]).getScopesArray()).toContain(
      "constant.other.key.strings",
    );
    expect(editor.scopeDescriptorForBufferPosition([1, 19]).getScopesArray()).toContain(
      "string.quoted.double.strings",
    );
  });
});
