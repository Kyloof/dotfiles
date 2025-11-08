-- NOTE:
-- Basic Autocommands
-- See `:help lua-guide-autocommands`
-- An autocommand is a Vim command or a Lua function that is automatically
-- executed whenever one or more events are triggered

-- Highlight when yanking (copying) text
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
