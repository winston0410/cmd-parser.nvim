# cmd-parser.nvim

I built this plugin to help other plugin authors to easily parse the command inputted by users and do awesome tricks with it.

Input

```lua
local parse_cmd = require'cmd-parser'.parse_cmd
parse_cmd("10+2++,/hello/-3d")
```

Output

```lua
{ ["start_increment_number"] = 4,["end_increment"] = -3,["command"] = d,["start_range"] = 10,["end_increment_number"] = -3,["start_increment"] = +2++,["end_range"] = /hello/,}
```

## Installtion

### `Paq.nvim`

```lua
paq{'winston0410/cmd-parser.nvim'}
```

## Testing

This plugin is well tested. To run the test case or help with testing, you need to install lester

```shell
luarocks install lester
```
