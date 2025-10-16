-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_user_command("CreatePHPCS", function()
  local cwd = vim.fn.getcwd()
  local artisan_path = cwd .. "/artisan"
  local phpcs_path = cwd .. "/phpcs.xml"

  if vim.fn.filereadable(artisan_path) == 0 then
    vim.notify("No artisan file found in current directory!", vim.log.levels.ERROR)
    return
  end

  if vim.fn.filereadable(phpcs_path) == 1 then
    vim.notify("phpcs.xml already exists!", vim.log.levels.WARN)
    return
  end

  local content = [[
<?xml version="1.0"?>
<ruleset name="RelaxedSniffer">
  <rule ref="PSR12" />

  <!-- Ignore annoying rules globally -->
  <exclude name="Generic.Files.LineLength"/>
  <exclude name="Squiz.WhiteSpace.SuperfluousWhitespace"/>

  <!-- Ignore all test files -->
  <exclude-pattern>tests/*</exclude-pattern>
  <exclude-pattern>*/Tests/*</exclude-pattern>
  <exclude-pattern>*/tests/*</exclude-pattern>

  <severity>3</severity>
</ruleset>
  ]]

  local file = io.open(phpcs_path, "w")
  if not file then
    vim.notify("Failed to create phpcs.xml file!", vim.log.levels.ERROR)
    return
  end
  if content == nil then
    vim.notify("Failed to create phpcs.xml file!", vim.log.levels.ERROR)
  else
    file:write(content)
    file:close()
    vim.notify("phpcs.xml created successfully!", vim.log.levels.INFO)
  end
end, {
  desc = "Create a relaxed phpcs.xml in the artisan project root",
})
local OpenCheatSheet = function()
  if vim.fn.has("win32") == 1 then
    vim.notify("Why are you using windows you little sucker", vim.log.levels.ERROR)
    return
  end
  local path = vim.fn.expand("~") .. "/personal/cheat_sheet.md"
  local dir = vim.fn.fnamemodify(path, ":h")

  -- ensure the directory exists
  if vim.fn.isdirectory(dir) == 0 then
    local success, err = pcall(vim.fn.mkdir, dir, "p")
    if not success then
      vim.notify("Failed to create directory " .. dir .. ": " .. err, vim.log.levels.ERROR)
      return
    end
  end

  -- check if the file exists
  if vim.fn.filereadable(path) == 0 then
    vim.notify("Cheat sheet not found at " .. path .. ", creating it...", vim.log.levels.WARN)
    local file = io.open(path, "w")
    if not file then
      vim.notify("Failed to create cheat sheet at " .. path, vim.log.levels.ERROR)
      return
    end
    file:close()
    vim.notify("Cheat sheet created at " .. path, vim.log.levels.INFO)
  end

  -- open the file in a buffer
  local buf = vim.fn.bufadd(path)
  vim.api.nvim_set_current_buf(buf)
  return buf
end
local Plan = function()
  local cwd = vim.fn.getcwd()
  local filePath = cwd .. "/.plan.md"

  if vim.fn.filereadable(filePath) == 0 then
    local ok, err = pcall(function()
      local fh, ferr = io.open(filePath, "w")
      if not fh then
        error("io.open failed: " .. (ferr or "unknown error"))
      end
      fh:close()
    end)

    if not ok then
      vim.notify("Error creating " .. filePath .. ": " .. tostring(err), vim.log.levels.ERROR)
      return
    end

    vim.notify("Created file: " .. filePath, vim.log.levels.INFO)
  end

  local buf
  local ok, err = pcall(function()
    buf = vim.fn.bufadd(filePath)
  end)
  if not ok or not buf then
    vim.notify("Error adding buffer for " .. filePath .. ": " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  ok, err = pcall(function()
    vim.api.nvim_set_current_buf(buf)
  end)
  if not ok then
    vim.notify("Error setting buffer for " .. filePath .. ": " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  return buf
end

-- local OpenWeztermConfig = function()
-- 	local path = ''
-- 	local is_wsl = vim.fn.has("wsl") == 1
-- 	local is_linux = vim.fn.has("linux") == 1
-- 	if is_wsl then
-- 		path = "/mnt/c/Users/saife/.wezterm.lua"
-- 	elseif is_linux then
-- 		path = "/home/saif/.wezterm.lua"
-- 	else
-- 		path = "C:\\Users\\saife\\.wezterm.lua"
-- 	end
--
-- 	local buf = vim.fn.bufadd(path)
-- 	vim.fn.bufload(buf)
-- 	vim.api.nvim_set_current_buf(buf)
--
-- 	-- local window = require("core.config.plugins.window")
-- 	-- local todo_window = window.open_floating_win({
-- 	-- 	buf = buf,
-- 	-- })
-- 	-- return buf
-- end
-- vim.api.nvim_create_user_command("WeztermConfig", OpenWeztermConfig, {})
vim.api.nvim_create_user_command("Cheat", OpenCheatSheet, {})

-- local ZenMode = function()
--   vim.cmd.colorscheme("rose-pine")
-- end
-- vim.api.nvim_create_user_command("Zen", ZenMode, {})
-- local UnZen = function()
--   vim.cmd.colorscheme("onedark")
-- end
--
-- vim.api.nvim_create_user_command("Cool", UnZen, {})
-- vim.api.nvim_create_user_command("Light", LightMode, {})
vim.api.nvim_create_user_command("Plan", Plan, {})
-- vim.lsp.handlers["$/progress"] = function() end

vim.api.nvim_create_user_command("Rest", require("kulala").run, {})
vim.api.nvim_create_user_command("RestAll", require("kulala").run_all, {})
vim.api.nvim_create_user_command("RestScratchpad", require("kulala").scratchpad, {})

local map = vim.keymap.set

map("n", "<leader>ks", "<cmd>Rest<CR>")
map("n", "<leader>ka", "<cmd>RestAll<CR>")
map("n", "<leader>kb", "<cmd>RestScrathPad<CR>")

local authGenerics = {
  {
    method = "POST",
    path = "/auth/login",
    body = '{ "email": "saif@gmail.com", "password": "123456" }',
  },
  {
    method = "POST",
    path = "/auth/register",
    body = '{ "name": "Saif", "email": "saif@gmail.com", "password": "123456", "password_confirmation": "123456" }',
  },
}

local generics = {
  {
    method = "GET",
    path = "",
    body = "",
  },
  {
    method = "POST",
    path = "",
    body = "{}",
  },
}

local generateEndpoints = function(protocol, domain, port, path, method)
  local endpoint = method .. " " .. protocol .. "://" .. domain .. ":" .. port .. path .. " " .. "HTTP/1.1"
  return endpoint
end

local printTofile = function(endpoint, body, filePath)
  local file = io.open(filePath, "a")
  if not file then
    vim.notify("Failed to open file " .. filePath, vim.log.levels.ERROR)
    return
  end
  file:write(endpoint .. "\n")
  file:write("Content-Type: application/json" .. "\n\n")
  file:write(body .. "\n")
  file:write("###" .. "\n")
  file:close()
end

local seedGenericFiles = function(protocol, domain, port, path, current)
  if not protocol then
    protocol = "http"
  end
  if not port then
    port = "8000"
  end
  if not domain then
    domain = "127.0.0.1"
  end
  if not path then
    path = ""
  end

  local authFilePath = current .. "/rest/auth/auth.http"
  for _, v in pairs(authGenerics) do
    local endpoint = generateEndpoints(protocol, domain, port, path .. v.path, v.method)
    printTofile(endpoint, v.body, authFilePath)
  end

  local genericsFilePath = current .. "/rest/generics/generics.http"
  for _, v in pairs(generics) do
    local endpoint = generateEndpoints(protocol, domain, port, path .. v.path, v.method)
    printTofile(endpoint, v.body, genericsFilePath)
  end
end

-- need to make this better but I am lazy for now :)
local CreateRestFolder = function()
  local current = vim.fn.getcwd()
  print("Current directory: " .. current)

  if vim.fn.isdirectory(current .. "/rest") == 0 then
    vim.fn.mkdir(current .. "/rest", "p")
    vim.notify("Created directory: " .. current .. "/rest", vim.log.levels.INFO)
  end

  if vim.fn.isdirectory(current .. "/rest/auth") == 0 then
    vim.fn.mkdir(current .. "/rest/auth", "p")
    vim.notify("Created directory: " .. current .. "/rest/auth", vim.log.levels.INFO)
  end

  if vim.fn.isdirectory(current .. "/rest/generics") == 0 then
    vim.fn.mkdir(current .. "/rest/generics", "p")
    vim.notify("Created directory: " .. current .. "/rest/generics", vim.log.levels.INFO)
  end

  if vim.fn.filereadable(current .. "/rest/auth/auth.http") == 0 then
    local file = io.open(current .. "/rest/auth/auth.http", "w")
    if not file then
      vim.notify("Failed to create file " .. current .. "/rest/auth/auth.http", vim.log.levels.ERROR)
      return
    end
    file:close()
    vim.notify("File created at " .. current .. "/rest/auth/auth.http", vim.log.levels.INFO)
  end

  if vim.fn.filereadable(current .. "/rest/generics/generics.http") == 0 then
    local file = io.open(current .. "/rest/generics/generics.http", "w")
    if not file then
      vim.notify("Failed to create file " .. current .. "/rest/generics/generics.http", vim.log.levels.ERROR)
      return
    end
    file:close()
    vim.notify("File created at " .. current .. "/rest/generics/generics.http", vim.log.levels.INFO)
  end

  seedGenericFiles("http", "127.0.0.1", "8000", "", current)

  vim.notify("REST folder structure created successfully!", vim.log.levels.INFO)
end
vim.api.nvim_create_user_command("RestCreateGenerics", CreateRestFolder, {})

-- local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
--
-- -- Define Blade directives
-- local blade_directives = {
--   -- Opening directives with descriptions
--   ["@if"] = "if statement",
--   ["@for"] = "for loop",
--   ["@csrf"] = "CSRF token",
--   ["@foreach"] = "foreach loop",
--   ["@forelse"] = "forelse loop",
--   ["@else"] = "else clause",
--   ["@elseif"] = "elseif clause",
--   ["@section"] = "section definition",
--   ["@extends"] = "template extension",
--   ["@yield"] = "yield content",
--   ["@include"] = "include template",
--   ["@component"] = "component definition",
--   ["@slot"] = "slot content",
--   ["@continue"] = "continue loop",
--   ["@break"] = "break loop",
--   ["@isset"] = "check if set",
--   ["@empty"] = "check if empty",
--   ["@auth"] = "auth check",
--   ["@guest"] = "guest check",
--   ["@method"] = "HTTP method",
--   ["@route"] = "route helper",
--   ["@json"] = "JSON output",
--   ["@php"] = "PHP code block",
--   ["@push"] = "push content to a stack",
--   ["@prepend"] = "prepend content to a stack",
--   ["@stack"] = "render stack content",
--   ["@error"] = "display form validation errors",
--   ["@verbatim"] = "output raw HTML without Blade compilation",
--   ["@env"] = "retrieve the value of an environment variable",
--   ["@unless"] = "conditional clause that works like !if",
--   ["@can"] = "check if a user has permission",
--   ["@cannot"] = "check if a user cannot perform an action",
--
--   -- Closing directives with descriptions
--   ["@endif"] = "end of if statement",
--   ["@endfor"] = "end of for loop",
--   ["@endforeach"] = "end of foreach loop",
--   ["@endforelse"] = "end of forelse loop",
--   ["@endsection"] = "end of section",
--   ["@endextends"] = "end of extends",
--   ["@endyield"] = "end of yield content",
--   ["@endinclude"] = "end of include template",
--   ["@endcomponent"] = "end of component definition",
--   ["@endslot"] = "end of slot content",
--   ["@endcontinue"] = "end of continue loop",
--   ["@endbreak"] = "end of break loop",
--   ["@endisset"] = "end of isset check",
--   ["@endempty"] = "end of empty check",
--   ["@endauth"] = "end of auth check",
--   ["@endguest"] = "end of guest check",
--   ["@endmethod"] = "end of HTTP method",
--   ["@endroute"] = "end of route helper",
--   ["@endjson"] = "end of JSON output",
--   ["@endphp"] = "end of PHP code block",
--   ["@endpush"] = "end of push content to a stack",
--   ["@endprepend"] = "end of prepend content to a stack",
--   ["@endverbatim"] = "end of raw HTML output",
--   ["@endunless"] = "end of unless statement",
--   ["@endcan"] = "end of can check",
--   ["@endcannot"] = "end of cannot check",
-- }
--
-- -- Table to store all snippets
-- local blade_snippets = {}
--
-- -- Process each directive to create appropriate snippets
-- for directive, description in pairs(blade_directives) do
--   -- Check if it's an opening directive (doesn't start with @end)
--   if not directive:match("^@end") then
--     -- For opening directives that typically have parameters
--     if
--       directive == "@if"
--       or directive == "@elseif"
--       or directive == "@for"
--       or directive == "@foreach"
--       or directive == "@forelse"
--       or directive == "@include"
--       or directive == "@component"
--       or directive == "@extends"
--       or directive == "@section"
--       or directive == "@push"
--       or directive == "@prepend"
--       or directive == "@error"
--       or directive == "@unless"
--       or directive == "@can"
--       or directive == "@cannot"
--       or directive == "@env"
--       or directive == "@method"
--       or directive == "@isset"
--       or directive == "@empty"
--     then
--       blade_snippets[#blade_snippets + 1] = s(directive, {
--         t(directive .. "("),
--         i(1, ""),
--         t(")"),
--       }, { descr = description }) -- Add description here
--     else
--       -- For directives without parameters
--       blade_snippets[#blade_snippets + 1] = s(directive, {
--         t(directive),
--       }, { descr = description }) -- Add description here
--     end
--   else
--     -- For closing directives (simple, no insert nodes)
--     blade_snippets[#blade_snippets + 1] = s(directive, {
--       t(directive),
--     }, { descr = description }) -- Add description here
--   end
-- end
--
-- -- Add all snippets to the blade filetype
-- ls.add_snippets("blade", blade_snippets)
-- local c = ls.choice_node
--
-- -- Common Laravel Blade helpers with descriptions
-- local laravel_helpers = {
--   -- Asset helpers
--   ["asset"] = "Generate URL for an asset",
--   ["url"] = "Generate a fully qualified URL",
--   ["secure_asset"] = "Generate URL for an asset using HTTPS",
--   ["secure_url"] = "Generate HTTPS URL",
--   ["mix"] = "Get URL for a versioned Mix file",
--   ["vite"] = "Get URL for a Vite asset",
--
--   -- Route helpers
--   ["route"] = "Generate URL for a named route",
--   ["action"] = "Generate URL for a controller action",
--
--   -- String helpers
--   ["__"] = "Translate a string",
--   ["trans"] = "Translate a string",
--   ["trans_choice"] = "Translate a plural string",
--
--   -- Config helpers
--   ["config"] = "Get a configuration value",
--   ["env"] = "Get an environment variable",
--
--   -- Auth helpers
--   ["auth"] = "Get the authenticated user",
--
--   -- Session helpers
--   ["session"] = "Get a session value",
--   ["old"] = "Get old input value",
--
--   -- App helpers
--   ["app"] = "Get the app container instance",
--   ["resolve"] = "Resolve an instance from the container",
--
--   -- Collection helpers
--   ["collect"] = "Create a collection from an array",
--
--   -- Request helpers
--   ["request"] = "Get the request instance or input item",
--
--   -- Response helpers
--   ["response"] = "Create a response instance",
--
--   -- View helpers
--   ["view"] = "Create a view instance",
--
--   -- Form helpers
--   ["csrf_field"] = "Generate a CSRF token hidden field",
--   ["method_field"] = "Generate a method spoof hidden field",
--
--   -- Storage helpers
--   ["storage_path"] = "Get the path to a storage file",
--   ["storage"] = "Get a storage disk instance",
--
--   -- Misc helpers
--   ["dd"] = "Dump and die - debug helper",
--   ["dump"] = "Dump a variable for debugging",
--   ["now"] = "Get a Carbon instance for the current time",
-- }
--
-- -- Create all the snippets
-- local blade_expression_snippets = {}
-- for trigger, description in pairs(laravel_helpers) do
--   -- Create two variants and let the user choose
--   blade_expression_snippets[#blade_expression_snippets + 1] = s(trigger, {
--     c(1, {
--       -- Option 1: With {{ }}
--       {
--         t("{{ " .. trigger .. "("),
--         i(1, ""),
--         t(") }}"),
--       },
--       -- Option 2: Without {{ }}
--       {
--         t(trigger .. "("),
--         i(1, ""),
--         t(")"),
--       },
--     }),
--   }, { descr = description })
-- end
--
-- -- Add all the snippets to the blade filetype
-- ls.add_snippets("blade", blade_expression_snippets)

local M = {}

-- Man I love lua
M.todo_path = vim.fn.expand("~") .. "/personal/todos/todo.md"
M.load_todos = function()
  if vim.fn.has("win32") == 1 then
    vim.notify("Why are you using windows you little sucker", vim.log.levels.ERROR)
    return
  end
  local dir = vim.fn.fnamemodify(M.todo_path, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    local success, err = pcall(vim.fn.mkdir, dir, "p")
    if not success then
      vim.notify("Failed to create directory " .. dir .. ": " .. err, vim.log.levels.ERROR)
      return
    end
    local file = io.open(M.todo_path, "w")
    if not file then
      vim.notify("Failed to create cheat sheet at " .. M.todo_path, vim.log.levels.ERROR)
      return
    end
    file:close()
    vim.notify("Cheat sheet created at " .. M.todo_path, vim.log.levels.INFO)
  end

  local buf = vim.fn.bufadd(M.todo_path)
  vim.api.nvim_set_current_buf(buf)

  return buf
end
vim.api.nvim_create_user_command("Todo", function()
  M.load_todos()
end, {})

vim.keymap.set("n", "<leader>td", ":Todo<CR>", { noremap = true, silent = true })

-- we are creating the core funtionality of the window in here
local S = {}

S.open_floating_win = function(opts)
  opts = opts or {}
  local width = opts.width or math.floor((vim.o.columns * 0.7))
  local height = opts.height or math.floor((vim.o.lines * 0.7))

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }
  local buf = nil

  if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local M = {}

-- Path for caching the Artisan commands
local cache_path = vim.fn.stdpath("cache") .. "/artisan_commands.json"

-- Attempt to require Telescope modules
local has_telescope, pickers = pcall(require, "telescope.pickers")
local has_telescope_finders, finders = pcall(require, "telescope.finders")
local has_telescope_conf, conf = pcall(require, "telescope.config")
local has_telescope_actions, actions = pcall(require, "telescope.actions")
local actions_state = has_telescope_actions and require("telescope.actions.state") or nil

-- Require my custom floating window module
local floating_win = S

-- Table to store the commands
M.artisan_commands = {}

--- Returns the path to the artisan file if found.
M.get_artisan_path = function()
  local path = vim.fn.findfile("artisan", vim.fn.getcwd() .. ";")
  return (path ~= "" and path or nil)
end

--- Loads cached commands from disk.
M.load_cached_commands = function()
  local file = io.open(cache_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    local ok, data = pcall(vim.json.decode, content)
    if ok and data and data.commands then
      M.artisan_commands = data.commands
      return true
    end
  end
  return false
end

--- Saves commands to the cache file.
M.save_cached_commands = function(commands)
  local file = io.open(cache_path, "w")
  if file then
    file:write(vim.json.encode({ commands = commands }))
    file:close()
    vim.notify("Artisan commands have been saved", vim.log.levels.INFO)
  else
    vim.notify("Failed to write Artisan commands cache", vim.log.levels.ERROR)
  end
end

--- Fetches the Artisan commands by calling `php artisan list --format=json`.
M.fetch_artisan_commands = function()
  local artisan = M.get_artisan_path()
  if not artisan then
    vim.notify("No artisan file found in the current directory", vim.log.levels.ERROR)
    return
  end

  local handle = io.popen("php " .. artisan .. " list --format=json 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    local ok, data = pcall(vim.json.decode, result)
    if ok and data and data.commands then
      M.artisan_commands = data.commands
      M.save_cached_commands(data.commands)
    else
      vim.notify("Failed to fetch Artisan commands", vim.log.levels.ERROR)
    end
  else
    vim.notify("Failed to execute artisan command", vim.log.levels.ERROR)
  end
end

--- Returns the list of Artisan commands, loading from cache if available.
M.get_artisan_commands = function()
  if vim.tbl_isempty(M.artisan_commands) then
    if not M.load_cached_commands() then
      M.fetch_artisan_commands()
    end
  end
  return M.artisan_commands
end

--------------------------------------------------------------------------------
-- Helper: Opens a terminal in a floating window (using your window module)
--------------------------------------------------------------------------------
local function run_in_terminal(cmd)
  local opts = {
    width = math.floor(vim.o.columns * 0.7),
    height = math.floor(vim.o.lines * 0.7),
    border = "rounded",
    title = "Artisan Terminal",
    title_pos = "center",
    winblend = 10, -- slight transparency for aesthetics
  }
  local win_data = floating_win.open_floating_win(opts)
  if not win_data or not win_data.buf or not win_data.win then
    vim.notify("Failed to open Artisan terminal window", vim.log.levels.ERROR)
    return
  end
  local term_bufnr = win_data.buf
  local term_win = win_data.win

  -- (Don't manually set 'buftype' here; termopen will handle that automatically.)

  -- Map keys inside the terminal:
  -- In terminal mode, press <leader>q to close.
  vim.api.nvim_buf_set_keymap(term_bufnr, "t", "<leader>q", "<C-\\><C-n>:close<CR>", { noremap = true, silent = true })
  -- In normal mode (after entering terminal normal mode with <C-\\><C-n>), press q to close.
  vim.api.nvim_buf_set_keymap(term_bufnr, "n", "q", ":close<CR>", { noremap = true, silent = true })

  -- Start the terminal job with bash executing the given command.
  local job = vim.fn.termopen({ "bash", "-c", cmd }, {
    on_exit = function(_, exit_code, _)
      if exit_code ~= 0 then
        vim.schedule(function()
          vim.notify("Artisan command exited with error code: " .. exit_code, vim.log.levels.ERROR)
        end)
      end
    end,
  })
  if job == 0 then
    vim.notify("Failed to start terminal job", vim.log.levels.ERROR)
  end
end

--------------------------------------------------------------------------------
-- Runs the selected Artisan command.
--------------------------------------------------------------------------------
M.run_artisan_command = function(command)
  local artisan = M.get_artisan_path()
  if not artisan then
    vim.print("No artisan file found in the current directory")
    return
  end

  local cmd_details = nil
  for _, cmd in ipairs(M.artisan_commands) do
    if cmd.name == command then
      cmd_details = cmd
      break
    end
  end

  if not cmd_details then
    vim.notify("Command not found", vim.log.levels.ERROR)
    return
  end

  local command_string = "php " .. artisan .. " " .. command
  -- If the command appears to need parameters, prompt the user.
  if type(cmd_details.definition) == "string" and cmd_details.definition:match("%{%w+%}") then
    vim.ui.input({ prompt = "Enter parameters: " }, function(input)
      if input and input ~= "" then
        command_string = command_string .. " " .. input
      end
      run_in_terminal(command_string)
    end)
  else
    run_in_terminal(command_string)
  end
end

--------------------------------------------------------------------------------
-- Opens a searchable picker for Artisan commands using Telescope (or a fallback).
--------------------------------------------------------------------------------
M.open_artisan_picker = function()
  local commands = M.get_artisan_commands()
  if vim.tbl_isempty(commands) then
    return
  end

  local command_list = {}
  for _, cmd in ipairs(commands) do
    table.insert(command_list, { cmd.name, cmd.description or "" })
  end

  if has_telescope and has_telescope_finders and has_telescope_conf and has_telescope_actions then
    pickers
      .new({}, {
        prompt_title = "Laravel Artisan Commands",
        finder = finders.new_table({
          results = command_list,
          entry_maker = function(entry)
            return {
              value = entry[1],
              display = entry[1] .. " - " .. entry[2],
              ordinal = entry[1],
            }
          end,
        }),
        sorter = conf.values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            local selection = actions_state.get_selected_entry(prompt_bufnr)
            actions.close(prompt_bufnr)
            if selection then
              M.run_artisan_command(selection.value)
            end
          end)
          return true
        end,
      })
      :find()
  else
    -- Fallback: display the list in your custom floating window.
    local win_data = floating_win.open_floating_win({
      width = math.floor(vim.o.columns * 0.7),
      height = math.floor(vim.o.lines * 0.7),
      border = "rounded",
      title = "Laravel Artisan Commands",
      title_pos = "center",
    })
    local buf = win_data.buf
    local lines = {}
    for _, entry in ipairs(command_list) do
      table.insert(lines, entry[1] .. " - " .. entry[2])
    end
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
      noremap = true,
      silent = true,
      callback = function()
        local line = vim.api.nvim_get_current_line()
        local cmd = line:match("^(%S+)")
        if cmd then
          M.run_artisan_command(cmd)
        end
      end,
    })
  end
end

--------------------------------------------------------------------------------
-- Refreshes the Artisan commands cache.
--------------------------------------------------------------------------------
M.refresh_artisan_cache = function()
  M.fetch_artisan_commands()
end

M.go_to_laravel_directory = function()
  -- we need to check if I am on wsl or on windows then use the correct path
  --  windows_path = "E:\\dev\\laravel"
  -- wsl_path = "~/dev/laravel"
  local is_wsl = vim.fn.has("wsl") == 1

  local laravel_path = ""
  if is_wsl then
    -- WSL path
    laravel_path = "~/dev/laravel"
  else
    -- Windows path
    laravel_path = "E:\\dev\\laravel"
  end
  -- now change directory the larvel path
  vim.cmd("cd " .. laravel_path)

  if not has_telescope then
    vim.notify("Telescope is not installed", vim.log.levels.ERROR)
    return
  end

  local projects = vim.fn.split(vim.fn.glob(laravel_path .. "/*"), "\n")

  -- Filter to only include directories
  local project_dirs = {}
  for _, project in ipairs(projects) do
    if vim.fn.isdirectory(project) == 1 then
      table.insert(project_dirs, project)
    end
  end

  -- Create a table to store the project names for display
  local project_names = {}
  for _, project in ipairs(project_dirs) do
    -- Get the name of the project
    local name = vim.fn.fnamemodify(project, ":t")
    table.insert(project_names, name)
  end

  -- Exit if no projects found
  if #project_names == 0 then
    vim.notify("No Laravel projects found in " .. laravel_path, vim.log.levels.WARN)
    return
  end
  pickers
    .new({}, {
      prompt_title = "Laravel Projects",
      finder = finders.new_table({
        results = project_names,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry,
            ordinal = entry,
          }
        end,
      }),
      sorter = conf.values.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = actions_state.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          if selection then
            -- Find the full path for the selected project
            local selected_project = nil
            for _, project in ipairs(project_dirs) do
              if vim.fn.fnamemodify(project, ":t") == selection.value then
                selected_project = project
                break
              end
            end

            if selected_project then
              -- Change directory to the selected project
              vim.cmd("cd " .. selected_project)
              vim.notify("Changed to project: " .. selection.value, vim.log.levels.INFO)
              vim.cmd("Telescope find_files")
              -- vim.cmd("Ex" .. selected_project)
            end
          end
        end)
        return true
      end,
    })
    :find()
end

-- installs laravel ide helper
M.get_laravel_ide_helper = function()
  local artisan = M.get_artisan_path()
  if not artisan then
    return
  end
  local cmd = "composer require --dev barryvdh/laravel-ide-helper"
  vim.cmd("terminal " .. cmd)
end

-- we are going to run the commands for laravel ide helper
M.generate_ide_helper_file = function()
  if not M.get_artisan_path() then
    return
  end
  local cmd = "php artisan ide-helper:generate"
  vim.cmd("terminal " .. cmd)
end

M.generate_models_helpers = function()
  if not M.get_artisan_path() then
    return
  end
  local cmd = "php artisan ide-helper:models -RW"
  vim.cmd("terminal " .. cmd)
end

M.add_ide_helper_to_gitignore = function()
  if not M.get_artisan_path() then
    return
  end
  local cmd = 'echo "_ide_helper.php" >> .gitignore  echo "_ide_helper_models.php" >> .gitignore'
  vim.cmd("terminal " .. cmd)
end

M.generate_dot_env_file = function()
  if not M.get_artisan_path() then
    return
  end
  local cmd = "cp .env.example .env"
  vim.cmd("terminal " .. cmd)
end
-- User commands.
vim.api.nvim_create_user_command("GetLIH", M.get_laravel_ide_helper, {})
vim.api.nvim_create_user_command("Artisan", M.open_artisan_picker, {})
vim.api.nvim_create_user_command("ArtisanRefresh", M.refresh_artisan_cache, {})
vim.api.nvim_create_user_command("Laraveldirectory", M.go_to_laravel_directory, {})
vim.api.nvim_create_user_command("GenerateDotEnvFile", M.generate_dot_env_file, {})
vim.api.nvim_create_user_command("AddIdeHelperToGitIgnore", M.add_ide_helper_to_gitignore, {})

vim.api.nvim_create_user_command("GenearteModelsHelpers", M.generate_models_helpers, {})
vim.api.nvim_create_user_command("GenearteIdeHelper", M.generate_ide_helper_file, {})
-- Keymaps for quick access.
vim.keymap.set("n", "<leader>aa", ":Artisan<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ar", ":ArtisanRefresh<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>lp", ":Laraveldirectory<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>li", ":GetLIH<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>lg", ":GenearteIdeHelper<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>lgm", ":GenearteModelsHelpers<CR>", { noremap = true, silent = true })

-- local client_id = vim.lsp.start({
--   name = "phplsp",
--   cmd = { "/home/saif/Dev/personal-projects/phplsp/main" },
-- })
--
-- if not client_id then
--   vim.notify("Failed to start phplsp", vim.log.levels.ERROR)
-- else
--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function()
--       vim.lsp.buf_attach_client(0, client_id)
--     end,
--   })
-- end
