## CC: Tweaked Definitions

This repository contains definitions for the builtin APIs of [CC: Tweaked](https://github.com/cc-tweaked/CC-Tweaked).
These definitions are in the [LuaCATS](https://github.com/LuaCATS) format for use with any [LuaLS](https://github.com/LuaLS/lua-language-server) based language pack.

The repository is structured like a LuaLS addon, with the required configuration in `config.json`, and the definitions contained in the `library` folder.

## Installation

Installation is done by adding this repository as a submodule, then configuring the language server.

Add this repository as a git submodule using:

```sh
git submodule add https://github.com/CelDaemon/cc-definitions libraries/cc-definitions
```

Or clone the repository directly if the workspace is not a git repo:

```sh
git clone https://github.com/CelDaemon/cc-definitions libraries/cc-definitions
```

Then, properly configure the language server.
This is done by adding a `.luarc.json` file to the base of the workspace, 
and adding the following config to the created file:

```json
{
    // Disable all Lua's standard library definitions,
    // definitions specifically for Cobalt are included.
    "runtime.builtin": {
        "table.clear": "disable",
        "debug": "disable",
        "builtin": "enable",
        "table": "disable",
        "os": "disable",
        "jit.util": "disable",
        "coroutine": "disable",
        "basic": "disable",
        "io": "disable",
        "utf8": "disable",
        "package": "disable",
        "jit": "disable",
        "jit.profile": "disable",
        "ffi": "disable",
        "math": "disable",
        "table.new": "disable",
        "string.buffer": "disable",
        "string": "disable",
        "bit32": "disable",
        "bit": "disable"
    },
    "runtime.version": "Lua 5.2", // Cobalt Lua supports syntax from up until Lua 5.2
    "diagnostics.groupFileStatus": {
        "strong": "Any" // Activate stricter checks, such as warning for using possible nil values.
    },
    "workspace.library": [
        "libraries/cc-definitions/library" // Add ComputerCraft definitions.
    ]
}
```

