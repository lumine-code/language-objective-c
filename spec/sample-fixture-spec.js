const path = require("path");

// The fixture beside this file is a plain sample of the language — the file to
// open when you want to look at the highlighting rather than assert on it. This
// spec is only what stops the sample quietly rotting: the grammar still claims
// it, and it still tokenizes.

describe("Objective-C sample fixtures", () => {
  beforeEach(async () => {
    await atom.packages.activatePackage("language-c");
    await atom.packages.activatePackage("language-objective-c");
    atom.config.set("language.useTreeSitterParsers", true);
  });

  it("parses sample.m without error", async () => {
    const editor = await atom.workspace.open(path.join(__dirname, "fixtures", "sample.m"));
    const languageMode = editor.getBuffer().getLanguageMode();
    await languageMode.ready;

    expect(editor.getGrammar().scopeName).toBe("source.objc");
    expect(languageMode.tree.rootNode.hasError).toBe(false);
  });
});
