return {
  cmd = {
    "clangd",
    "--clang-tidy",
    "--background-index",
    "--offset-encoding=utf-8",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=llvm",
    "--pch-storage=memory",
    "-j=4",
  },
}
