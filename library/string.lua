--- @meta string

--- @class stringlib
string = {}

--- Returns the internal numeric codes of the characters `s[i], s[i+1], ..., s[j]`.
--- 
--- @nodiscard
--- @param s string | number The string to convert to bytes.
--- @param i number The starting index.
--- @param j number The ending index.
--- @return number ... The converted bytes.
function string.byte(s, i, j) end

--- Returns a string with length equal to the number of arguments, in which each character has the internal numeric code equal to its corresponding argument.
--- 
--- @nodiscard
--- @param ... number The bytes to convert to a string.
--- @return string # The converted string.
function string.char(...) end


--- Returns a string containing a binary representation (a *binary chunk*) of the given function.
--- 
--- @deprecated Unavailable in CC: Tweaked, as no bytecode format is defined.
--- 
--- @nodiscard
--- @param f async fun(...): ... The function to dump.
--- @param strip boolean? Whether to strip debug information.
function string.dump(f, strip) end

--- Looks for the first match of `pattern` (see §6.4.1) in the string.
--- 
--- @nodiscard
--- @param s string | number The string to search in.
--- @param pattern string | number The pattern to search for.
--- @param init number? The starting index to start searching.
--- @param plain boolean? Whether the pattern should be literal.
function string.find(s, pattern, init, plain) end

--- Returns a formatted version of its variable number of arguments following the description given in its first argument.
--- 
--- @nodiscard
--- @param s string | number The pattern to format the arguments to.
--- @param ... any The arguments to format.
--- @return string # The formatted string.
function string.format(s, ...) end

--- Returns an iterator function that, each time it is called, returns the next captures from `pattern` (see §6.4.1) over the string s.
--- 
--- As an example, the following loop will iterate over all the words from string s, printing one per line:
--- ```lua
--- s = "hello world from Lua"
--- for w in string.gmatch(s, "%a+") do
---     print(w)
--- end
--- ```
--- 
--- @nodiscard
--- @param s string | number The string to search.
--- @param pattern string | number The pattern to match.
--- @return fun(): string # The iterator function that returns matches.
function string.gmatch(s, pattern) end

--- Returns a copy of s in which all (or the first `n`, if given) occurrences of the `pattern` (see §6.4.1) have been replaced by a replacement string specified by `repl`.
--- 
--- @nodiscard
--- @param s string | number The string to replace matches in.
--- @param pattern string | number The pattern to replace.
--- @param repl string | number | table | function The value to replace matches with.
--- @param n number? The amount of matches to replace.
--- @return string # The output string with replaced matches.
--- @return number count The amount of replaced matches.
function string.gsub(s, pattern, repl, n) end

--- Returns its length.
--- 
--- @nodiscard
--- @param s string | number The string to get the length of.
--- @return number # The length of the string.
function string.len(s) end


--- Returns a copy of this string with all uppercase letters changed to lowercase.
--- 
--- @nodiscard
--- @param s string | number The string to convert to lowercase.
--- @return string # The converted string. 
function string.lower(s) end

--- Looks for the first match of `pattern` (see §6.4.1) in the string.
--- 
--- @nodiscard
--- @param s string | number The string to search.
--- @param pattern string | number The pattern to match.
--- @param init number? The starting index to start searching.
--- @return string ... The found match.
function string.match(s, pattern, init) end

--- Returns a binary string containing the values `v1`, `v2`, etc. packed (that is, serialized in binary form) according to the format string `fmt` (see §6.4.2) .
--- 
--- @nodiscard
--- @param fmt string The format to use for packing.
--- @param ... string | number The arguments to pack.
--- @return string binary The output packed data.
function string.pack(fmt, ...) end

--- Returns the size of a string resulting from `string.pack` with the given format string `fmt` (see §6.4.2) .
--- 
--- This function does not work when the format contains variable-sized fields.
--- 
--- @nodiscard
--- @param fmt string The format to use for packing.
--- @return number # The packed size.
function string.packsize(fmt) end

--- Returns a string that is the concatenation of `n` copies of the string `s` separated by the string `sep`.
--- 
--- @nodiscard
--- @param s string | number The string to repeat.
--- @param n number How many times to repeat the string.
--- @param sep string | number? The seperator in between the repeated string, defaults to "".
--- @return string # The output string.
function string.rep(s, n, sep) end


--- Returns a string that is the string `s` reversed.
--- 
--- @nodiscard
--- @param s string | number The string to reverse.
--- @return string # The reversed string.
function string.reverse(s) end

--- Returns the substring of the string that starts at `i` and continues until `j`.
--- 
--- @nodiscard
--- @param s string | number The string to substring.
--- @param i number The starting index of the substring.
--- @param j number? The ending index of the substring.
--- @return string # The output substring.
function string.sub(s, i, j) end

--- Returns the values packed in string according to the format string `fmt` (see §6.4.2) .
--- 
--- @nodiscard
--- @param fmt string The format to use for unpacking.
--- @param s string The packed data to unpack.
--- @param pos number? The position of the values to unpack.
--- @return any ... The unpacked values.
--- @return number offset The index of the first unread byte.
function string.unpack(fmt, s, pos) end

--- Returns a copy of this string with all lowercase letters changed to uppercase.
--- 
--- @nodiscard
--- @param s string | number The string to convert to uppercase.
--- @return string # The converted string.
function string.upper(s) end

return string