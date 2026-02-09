--- @meta _

--- The shell API provides access to CraftOS's command line interface.
--- 
--- It allows you to [start programs](lua://shell.run), [add completion for a program](lua://shell.setCompletionFunction), and much more.
--- 
--- [`shell`](lua://shell) is not a "true" API. Instead, it is a standard program, which injects its API into the programs that it launches. 
--- This allows for multiple shells to run at the same time, but means that the API is not available in the global environment, and so is unavailable to other [APIs](lua://os.loadAPI).
--- 
--- ## Programs and the program path
--- 
--- When you run a command with the shell, either from the prompt or [from Lua code](lua://shell.run), the shell API performs several steps to work out which program to run:
--- 
--- 1. Firstly, the shell attempts to resolve [aliases](lua://shell.aliases). 
---    This allows us to use multiple names for a single command. 
---    For example, the `list` program has two aliases: `ls` and `dir`. 
---    When you write `ls /rom`, that's expanded to `list /rom`.
--- 2. Next, the shell attempts to find where the program actually is. 
---    For this, it uses the [program path](lua://shell.path). 
---    This is a colon separated list of directories, each of which is checked to see if it contains the program.
--- 
---    `list` or `list.lua` doesn't exist in `.` (the current directory), so the shell now looks in `/rom/programs`, where `list.lua` can be found!
--- 3. Finally, the shell reads the file and checks if the file starts with a `#!`. This is a [hashbang](https://en.wikipedia.org/wiki/Shebang_(Unix)), which says that this file shouldn't be treated as Lua, but instead passed to _another_ program, the name of which should follow the `#!`.
--- @class shell
shell = {}



--- Run a program with the supplied arguments.
--- 
--- Unlike [`shell.run`](lua://shell.run), each argument is passed to the program verbatim. 
--- While `shell.run("echo", "b c")` runs `echo` with `b` and `c`, `shell.execute("echo", "b c")` runs `echo` with a single argument `b c`.
--- 
--- Run `paint my-image` from within your program:
--- 
--- ```lua
--- shell.execute("paint", "my-image")
--- ```
--- 
--- @param command string The program to execute.
--- @param ... string Arguments to this program.
--- @return boolean # Whether the program exited successfully.
function shell.execute(command, ...) end

--- Run a program with the supplied arguments.
--- 
--- All arguments are concatenated together and then parsed as a command line. 
--- As a result, `shell.run("program a b")` is the same as `shell.run("program", "a", "b")`.
--- 
--- Run `paint my-image` from within your program:
--- 
--- ```lua
--- shell.run("paint", "my-image")
--- ```
--- 
--- @see shell.execute Run a program directly without parsing the arguments.
--- 
--- @param ... string The program to run and its arguments.
--- @return boolean # Whether the program exited successfully.
function shell.run(...) end

--- Exit the current shell.
--- 
--- This does _not_ terminate your program, it simply makes the shell terminate after your program has finished. 
--- If this is the toplevel shell, then the computer will be shutdown.
function shell.exit() end

--- Return the current working directory. 
--- This is what is displayed before the `> ` of the shell prompt, and is used by [`shell.resolve`](lua://shell.resolve) to handle relative paths.
--- 
--- @see shell.setDir To change the working directory.
--- 
--- @nodiscard
--- @return string # The current working directory.
function shell.dir() end

--- Set the current working directory.
--- 
--- Throws if the path does not exist or is not a directory.
--- 
--- Set the working directory to "rom":
--- 
--- ```lua
--- shell.setDir("rom")
--- ```
--- 
--- @param dir string The new working directory.
function shell.setDir(dir) end

--- Set the path where programs are located.
--- 
--- The path is composed of a list of directory names in a string, each separated by a colon (`:`). 
--- On normal turtles will look in the current directory (`.`), `/rom/programs` and `/rom/programs/turtle` folder, making the path `.:/rom/programs:/rom/programs/turtle`.
--- 
--- @see shell.setPath To change the current path.
--- 
--- @nodiscard
--- @return string # The current shell's path.
function shell.path() end

--- Set the [current program path](lua://shell.path).
--- 
--- Be careful to prefix directories with a `/`. 
--- Otherwise they will be searched for from the [current directory](lua://shell.dir), rather than the computer's root.
--- 
--- @param path string The new program path.
function shell.setPath(path) end

--- Resolve a relative path to an absolute path.
--- 
--- The [`fs`](lua://fs) and [`io`](lua://io) APIs work using absolute paths, and so we must convert any paths relative to the [current directory](lua://shell.dir) to absolute ones. 
--- This does nothing when the path starts with `/`.
--- 
--- Resolve `startup.lua` when in the `rom` folder:
--- 
--- ```lua
--- shell.setDir("rom")
--- print(shell.resolve("startup.lua"))
--- -- => rom/startup.lua
--- ```
--- 
--- @param path string The path to resolve.
--- @return string
function shell.resolve(path) end

--- Resolve a program, using the [program path](lua://shell.path) and list of [aliases](lua://shell.aliases).
--- 
--- Locate the `hello` program:
--- 
--- ```lua
--- shell.resolveProgram("hello")
--- -- => rom/programs/fun/hello.lua
--- ```
--- 
--- @nodiscard
--- @param command string The name of the program
--- @return string? # The absolute path to the program, or `nil` if it could not be found.
function shell.resolveProgram(command) end

--- Return a list of all programs on the [`path`](lua://shell.path).
--- 
--- ```lua
--- textutils.tabulate(shell.programs())
--- ```
--- 
--- @nodiscard
--- @param include_hidden boolean? Include hidden files. Namely, any which start with `.`.
--- @return string[] # A list of available programs.
function shell.programs(include_hidden) end

--- Complete a shell command line.
--- 
--- This accepts an incomplete command, and completes the program name or arguments. 
--- For instance, `l` will be completed to `ls`, and `ls ro` will be completed to `ls rom/`.
--- 
--- Completion handlers for your program may be registered with [`shell.setCompletionFunction`](lua://shell.setCompletionFunction).
--- 
--- @see read For more information about completion.
--- @see shell.completeProgram
--- @see shell.setCompletionFunction
--- @see shell.getCompletionInfo
--- 
--- @nodiscard
--- @param line string The input to complete.
--- @return string[]? # The list of possible completions.
function shell.complete(line) end

--- Complete the name of a program.
--- 
--- @see cc.shell.completion.program
--- 
--- @nodiscard
--- @param program string The name of a program to complete.
--- @return string[] # A list of possible completions.
function shell.completeProgram(program) end

--- @alias shell.completion_function fun(shell: table, text: number, argument: string, previous: string[]): string[]?

--- Set the completion function for a program. 
--- When the program is entered on the command line, this program will be called to provide auto-complete information.
--- 
--- The completion function accepts four arguments:
--- 
--- 1. The current shell. 
---    As completion functions are inherited, this is not guaranteed to be the shell you registered this function in.
--- 2. The index of the argument currently being completed.
--- 3. The current argument. 
---    This may be the empty string.
--- 4. A list of the previous arguments.
--- 
--- For instance, when completing `pastebin put rom/st` our pastebin completion function will receive the shell API, an index of 2, `rom/st` as the current argument, and a "previous" table of `{ "put" }`. 
--- This function may then wish to return a table containing artup.lua, indicating the entire command should be completed to `pastebin put rom/startup.lua`.
--- 
--- You completion entries may also be followed by a space, if you wish to indicate another argument is expected.
--- 
--- @see cc.shell.completion Various utilities to help with writing completion functions.
--- @see shell.complete
--- @see read For more information about completion.
--- 
--- @param program string The path to the program. This should be an absolute path _without_ the leading `/`.
--- @param complete shell.completion_function The completion function.
function shell.setCompletionFunction(program, complete) end

--- Get a table containing all completion functions.
--- 
--- This should only be needed when building custom shells. 
--- Use [`setCompletionFunction`](lua://shell.setCompletionFunction) to add a completion function.
--- 
--- @nodiscard
--- @return { [string]: { fnComplete: shell.completion_function } } # A table mapping the absolute path of programs, to their completion functions.
function shell.getCompletionInfo() end

--- Returns the path to the currently running program.
--- 
--- @nodiscard
--- @return string # The absolute path to the running program.
function shell.getRunningProgram() end

--- Add an alias for a program.
--- 
--- Alias `vim` to the `edit` program:
--- 
--- ```lua
--- shell.setAlias("vim", "edit")
--- ```
--- 
--- @param command string The name of the alias to add.
--- @param program string The name or path to the program.
function shell.setAlias(command, program) end

--- Remove an alias.
--- 
--- @param command string The alias name to remove.
function shell.clearAlias(command) end

--- Get the current aliases for this shell.
--- 
--- Aliases are used to allow multiple commands to refer to a single program. 
--- For instance, the `list` program is aliased to `dir` or `ls`.
--- Running `ls`, `dir` or `list` in the shell will all run the `list` program.
--- 
--- @see shell.setAlias
--- @see shell.resolveProgram This uses aliases when resolving a program name to an absolute path.
--- 
--- @nodiscard
--- @return table<string, string> # A table, where the keys are the names of aliases, and the values are the path to the program.
function shell.aliases() end

--- Open a new [`multishell`](lua://multishell) tab running a command.
--- 
--- This behaves similarly to [`shell.run`](lua://shell.run), but instead returns the process index.
--- 
--- This function is only available if the [`multishell`](lua://multishell) API is.
--- 
--- Launch the Lua interpreter and switch to it:
--- 
--- ```lua
--- local id = shell.openTab("lua")
--- shell.switchTab(id)
--- ```
--- 
--- @see shell.run
--- @see multishell.launch
--- 
--- @param ... string The command line to run.
function shell.openTab(...) end

--- Switch to the [`multishell`](lua://multishell) tab with the given index.
--- 
--- @see multishell.setFocus
--- 
--- @param id number The tab to switch to.
function shell.switchTab(id) end