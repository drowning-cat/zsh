/*
 * Nodejs script for syncing line numbers in README.md
 */

const readline = require("readline");
const fs = require("fs");
const path = require("path");
const os = require("os");

const cachedFiles = new Map();
const getFileLineArray = (fileUrl) => {
  if (!cachedFiles.has(fileUrl)) {
    cachedFiles.set(fileUrl, fs.readFileSync(fileUrl, "utf-8").split("\n"));
  }
  return cachedFiles.get(fileUrl);
};

const parseReadmeLine = (line) => {
  const [num, str] = [
    line.split(":", 2).at(0),
    line.substring(line.indexOf(":") + 1),
  ].map((l) => l.trimStart());
  if (!num || !str) {
    throw new Error(`Invalid input: ${line}`);
  }
  return [num, str];
};

let exitCode = 0;
let link = "";

readline
  .createInterface({
    input: fs.createReadStream(path.resolve(__dirname, "..", "README.md")),
  })
  .on("line", (rline) => {
    const readmeLine = rline.trim();

    if (readmeLine.startsWith("```") && readmeLine.includes("#link")) {
      link = readmeLine.split("#link ").at(1).trim();
      link = link.replace("~", os.homedir());
      return;
    }
    if (readmeLine.startsWith("```")) {
      link = "";
      return;
    }

    if (link.length) {
      if (readmeLine === "...") {
        return;
      }

      const [num, str] = parseReadmeLine(readmeLine);
      const linkFileContent = getFileLineArray(link);

      for (let li = 0; li < linkFileContent.length; li++) {
        const linkLine = linkFileContent[li];
        const linkNum = li + 1;
        if (linkLine.trim() === str.trim()) {
          if (linkNum === Number(num)) {
            console.log("✅", readmeLine);
          } else {
            console.error("❌", `(${linkNum} ←)`, readmeLine);
            exitCode = 1;
          }
          return;
        }
      }
      console.error("❓", readmeLine);
      exitCode = 1;
      return;
    }
  })
  .on("close", () => {
    process.exit(exitCode);
  });

