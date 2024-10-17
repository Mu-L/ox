-- Configure Events --
event_mapping = {
    -- Cursor movement
    ["up"] = function() 
        editor:move_up() 
    end,
    ["down"] = function() 
        editor:move_down() 
    end,
    ["left"] = function() 
        editor:move_left() 
    end,
    ["right"] = function() 
        editor:move_right() 
    end,
    ["shift_up"] = function() 
        editor:select_up() 
    end,
    ["shift_down"] = function() 
        editor:select_down() 
    end,
    ["shift_left"] = function() 
        editor:select_left() 
    end,
    ["shift_right"] = function() 
        editor:select_right() 
    end,
    ["ctrl_up"] = function() 
        editor:move_top() 
    end,
    ["ctrl_down"] = function() 
        editor:move_bottom() 
    end,
    ["ctrl_left"] = function() 
        editor:move_previous_word() 
    end,
    ["ctrl_right"] = function() 
        editor:move_next_word() 
    end,
    ["home"] = function() 
        editor:move_home() 
    end,
    ["end"] = function() 
        editor:move_end() 
    end,
    ["pageup"] = function() 
        editor:move_page_up() 
    end,
    ["pagedown"] = function() 
        editor:move_page_down() 
    end,
    ["ctrl_g"] = function()
        local line = editor:prompt("Go to line")
        editor:move_to(0, tonumber(line))
    end,
    -- Searching & Replacing
    ["ctrl_f"] = function()
        editor:search()
    end,
    ["ctrl_r"] = function()
        editor:replace()
    end,
    -- Document Management
    ["ctrl_n"] = function()
        editor:new()
    end,
    ["ctrl_o"] = function()
        editor:open()
    end,
    ["ctrl_s"] = function()
        editor:save()
    end,
    ["alt_s"] = function()
        editor:save_as()
    end,
    ["alt_a"] = function()
        editor:save_all()
    end,
    ["ctrl_q"] = function()
        editor:quit()
    end,
    ["alt_left"] = function()
        editor:previous_tab()
    end,
    ["alt_right"] = function()
        editor:next_tab()
    end,
    -- Clipboard Interaction
    ["ctrl_a"] = function()
        editor:select_all()
    end,
    ["ctrl_x"] = function()
        editor:cut()
    end,
    ["ctrl_c"] = function()
        editor:copy()
    end,
    ["ctrl_v"] = function()
        editor:display_info("Use ctrl+shift+v for paste or set your terminal emulator to do paste on ctrl+v")
    end,
    -- Undo & Redo
    ["ctrl_z"] = function()
        editor:undo()
    end,
    ["ctrl_y"] = function()
        editor:redo()
    end,
    -- Miscellaneous
    ["ctrl_h"] = function()
        help_message.enabled = not help_message.enabled
    end,
    ["ctrl_d"] = function()
        editor:remove_line()
    end,
    ["ctrl_k"] = function()
        editor:open_command_line()
    end,
    ["alt_up"] = function()
        -- current line information
        line = editor:get_line()
        y = editor.cursor.y
        -- insert a new line
        editor:insert_line_at(line, y - 1)
        -- delete old copy and reposition cursor
        editor:remove_line_at(y + 1)
        editor:move_up()
        -- correct indentation level
        autoindent:fix_indent()
    end,
    ["alt_down"] = function()
        -- current line information
        line = editor:get_line()
        y = editor.cursor.y
        -- insert a new line
        editor:insert_line_at(line, y + 2)
        -- delete old copy and reposition cursor
        editor:remove_line_at(y)
        editor:move_down()
        -- correct indentation level
        autoindent:fix_indent()
    end,
    ["ctrl_w"] = function()
        y = editor.cursor.y
        x = editor.cursor.x
        if editor:get_character() == " " then 
            start = 0 
        else 
            start = 1 
        end
        editor:move_previous_word()
        new_x = editor.cursor.x
        diff = x - new_x
        if editor.cursor.y == y then
            -- Cursor on the same line
            for i = start, diff do
                editor:remove_at(new_x, y)
            end
        else
            -- Cursor has passed up onto the previous line
        end
    end,
}

-- Define user-defined commands
commands = {
    ["readonly"] = function(arguments)
        arg = arguments[1]
        if arg == "true" then
            editor:set_read_only(true)
        elseif arg == "false" then
            editor:set_read_only(false)
        end
    end,
    ["filetype"] = function(arguments)
        local file_type_name = table.concat(arguments, " ")
        editor:set_file_type(file_type_name)
    end,
    ["reload"] = function(arguments)
        editor:reload_config()
        editor:reload_plugins()
        editor:display_info("Configuration file and plugins reloaded")
    end,
}

-- Configure Documents --
document.tab_width = 4
document.indentation = "spaces"
document.undo_period = 10
document.wrap_cursor = true

-- Configure Colours --
colors.editor_bg = 'transparent'
colors.editor_fg = {255, 255, 255}
colors.line_number_fg = {65, 65, 98}
colors.line_number_bg = 'transparent'

colors.status_bg = {59, 59, 84}
colors.status_fg = {35, 240, 144}

colors.highlight = {35, 240, 144}

colors.tab_inactive_fg = {255, 255, 255}
colors.tab_inactive_bg = {41, 41, 61}
colors.tab_active_fg = {35, 240, 144}
colors.tab_active_bg = {59, 59, 84}

colors.info_fg = {99, 162, 255}
colors.info_bg = 'transparent'
colors.warning_fg = {255, 182, 99}
colors.warning_bg = 'transparent'
colors.error_fg = {255, 100, 100}
colors.error_bg = 'transparent'

colors.selection_fg = {255, 255, 255}
colors.selection_bg = {59, 59, 130}

-- Configure Line Numbers --
line_numbers.enabled = true
line_numbers.padding_left = 1
line_numbers.padding_right = 1

-- Configure Mouse Behaviour --
terminal.mouse_enabled = true

-- Configure Tab Line --
tab_line.enabled = true
tab_line.format = "  {file_name}{modified}  "

-- Configure Status Line --
status_line:add_part("  {file_name}{modified}  │  {file_type}  │") -- The left side of the status line
status_line:add_part("│  {cursor_y} / {line_count}  {cursor_x}  ")  -- The right side of the status line

status_line.alignment = "between" -- This will put a space between the left and right sides

-- Configure Greeting and Help Messages --
greeting_message.enabled = true
help_message.enabled = false

-- Configure Syntax Highlighting Colours --
syntax:set("string", {39, 222, 145}) -- Strings in various programming languages
syntax:set("comment", {113, 113, 169}) -- Comments in various programming languages
syntax:set("digit", {40, 198, 232}) -- Digits in various programming languages
syntax:set("keyword", {134, 76, 232}) -- Keywords in various programming languages
syntax:set("attribute", {40, 198, 232}) -- Attributes in various programming languages
syntax:set("character", {40, 198, 232}) -- Characters in various programming languages
syntax:set("type", {47, 141, 252}) -- Types in various programming languages
syntax:set("function", {47, 141, 252}) -- Function names in various programming languages
syntax:set("header", {40, 198, 232}) -- Headers in various programming language
syntax:set("macro", {223, 52, 249}) -- Macro names in various programming languages
syntax:set("namespace", {47, 141, 252}) -- Namespaces in various programming languages
syntax:set("struct", {47, 141, 252}) -- The names of structs, classes, enums in various programming languages
syntax:set("operator", {113, 113, 169}) -- Operators in various programming languages e.g. +, -, * etc
syntax:set("boolean", {86, 217, 178}) -- Booleans in various programming langauges e.g. true / false
syntax:set("table", {47, 141, 252}) -- Tables in various programming languages
syntax:set("reference", {134, 76, 232}) -- References in various programming languages
syntax:set("tag", {40, 198, 232}) -- Tags in various markup langauges e.g. HTML <p> tags
syntax:set("heading", {47, 141, 252}) -- Headings in various markup languages e.g. # in markdown
syntax:set("link", {223, 52, 249}) -- Links in various markup languages e.g. URLs
syntax:set("key", {223, 52, 249}) -- Keys in various markup languages
syntax:set("quote", {113, 113, 169}) -- Quotes in various markup languages e.g. > in markdown
syntax:set("bold", {40, 198, 232}) -- Quotes in various markup languages e.g. * in markdown
syntax:set("italic", {40, 198, 232}) -- Quotes in various markup languages e.g. _ in markdown
syntax:set("block", {40, 198, 232}) -- Quotes in various markup languages e.g. _ in markdown
syntax:set("list", {86, 217, 178}) -- Quotes in various markup languages e.g. _ in markdown

-- Import plugins (must be at the bottom of this file)
load_plugin("pairs.lua")
load_plugin("autoindent.lua")
