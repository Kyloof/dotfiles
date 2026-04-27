-- NOTE:
-- Basic Keymaps
-- See :help vim.keymap.set()

-- Clear highlights on search when pressing <Esc> in normal mode
-- See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Exit terminal mode
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--
--
-- IMAGES
--
-- Paste images
-- I use a Ctrl keymap so that I can paste images in insert mode
-- I tried using <C-v> but duh, that's used for visual block mode
-- so don't do it
vim.keymap.set({ "n", "v", "i" }, "<C-a>", function()
	-- Call the paste_image function from the Lua API
	-- Using the plugin's Lua API (require("img-clip").paste_image()) instead of the
	-- PasteImage command because the Lua API returns a boolean value indicating
	-- whether an image was pasted successfully or not.
	-- The PasteImage command does not
	-- https://github.com/HakonHarnes/img-clip.nvim/blob/main/README.md#api
	local pasted_image = require("img-clip").paste_image()
	if pasted_image then
		-- "Update" saves only if the buffer has been modified since the last save
		vim.cmd("update")
		print("Image pasted and file saved")
		-- Only if updated I'll refresh the images by clearing them first
		-- I'm using [[ ]] to escape the special characters in a command
		vim.cmd([[lua require("image").clear()]])
		-- Reloads the file to reflect the changes
		vim.cmd("edit!")
		-- Switch back to command mode
		vim.cmd("stopinsert")
	else
		print("No image pasted. File not updated.")
	end
end, { desc = "Paste image from system clipboard" })

-- ############################################################################

-- Open image under cursor in the Preview app (macOS)
vim.keymap.set("n", "<leader>io", function()
	local function get_image_path()
		-- Get the current line
		local line = vim.api.nvim_get_current_line()
		-- Pattern to match image path in Markdown
		local image_pattern = "%[.-%]%((.-)%)"
		-- Extract relative image path
		local _, _, image_path = string.find(line, image_pattern)

		return image_path
	end

	-- Get the image path
	local image_path = get_image_path()

	if image_path then
		-- Check if the image path starts with "http" or "https"
		if string.sub(image_path, 1, 4) == "http" then
			print("URL image, use 'gx' to open it in the default browser.")
		else
			-- Construct absolute image path
			local current_file_path = vim.fn.expand("%:p:h")
			local absolute_image_path = current_file_path .. "/" .. image_path

			-- Construct command to open image in Preview
			local command = "open -a Preview " .. vim.fn.shellescape(absolute_image_path)
			-- Execute the command
			local success = os.execute(command)

			if success then
				print("Opened image in Preview: " .. absolute_image_path)
			else
				print("Failed to open image in Preview: " .. absolute_image_path)
			end
		end
	else
		print("No image found under the cursor")
	end
end, { desc = "(macOS) Open image under cursor in Preview" })

-- ############################################################################

-- Open image under cursor in Finder (macOS)
--
-- THIS ONLY WORKS IF YOU'RE NNNNNOOOOOOTTTTT USING ABSOLUTE PATHS,
-- BUT INSTEAD YOURE USING RELATIVE PATHS
--
-- If using absolute paths, use the default `gx` to open the image instead
vim.keymap.set("n", "<leader>if", function()
	local function get_image_path()
		-- Get the current line
		local line = vim.api.nvim_get_current_line()
		-- Pattern to match image path in Markdown
		local image_pattern = "%[.-%]%((.-)%)"
		-- Extract relative image path
		local _, _, image_path = string.find(line, image_pattern)

		return image_path
	end

	-- Get the image path
	local image_path = get_image_path()

	if image_path then
		-- Check if the image path starts with "http" or "https"
		if string.sub(image_path, 1, 4) == "http" then
			print("URL image, use 'gx' to open it in the default browser.")
		else
			-- Construct absolute image path
			local current_file_path = vim.fn.expand("%:p:h")
			local absolute_image_path = current_file_path .. "/" .. image_path

			-- Open the containing folder in Finder and select the image file
			local command = "open -R " .. vim.fn.shellescape(absolute_image_path)
			local success = vim.fn.system(command)

			if success == 0 then
				print("Opened image in Finder: " .. absolute_image_path)
			else
				print("Failed to open image in Finder: " .. absolute_image_path)
			end
		end
	else
		print("No image found under the cursor")
	end
end, { desc = "(macOS) Open image under cursor in Finder" })

-- ############################################################################

-- Delete image file under cursor using trash app (macOS)
vim.keymap.set("n", "<leader>id", function()
	local function get_image_path()
		-- Get the current line
		local line = vim.api.nvim_get_current_line()
		-- Pattern to match image path in Markdown
		local image_pattern = "%[.-%]%((.-)%)"
		-- Extract relative image path
		local _, _, image_path = string.find(line, image_pattern)

		return image_path
	end

	-- Get the image path
	local image_path = get_image_path()

	if image_path then
		-- Check if the image path starts with "http" or "https"
		if string.sub(image_path, 1, 4) == "http" then
			vim.api.nvim_echo({
				{ "URL image cannot be deleted from disk.", "WarningMsg" },
			}, false, {})
		else
			-- Construct absolute image path
			local current_file_path = vim.fn.expand("%:p:h")
			local absolute_image_path = current_file_path .. "/" .. image_path

			-- Check if trash utility is installed
			if vim.fn.executable("trash") == 0 then
				vim.api.nvim_echo({
					{ "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
					{ "- In macOS run `brew install trash`\n", nil },
				}, false, {})
				return
			end

			-- Prompt for confirmation before deleting the image
			vim.ui.input({
				prompt = "Delete image file? (y/n) ",
			}, function(input)
				if input == "y" or input == "Y" then
					-- Delete the image file using trash app
					local success, _ = pcall(function()
						vim.fn.system({ "trash", vim.fn.fnameescape(absolute_image_path) })
					end)

					if success then
						vim.api.nvim_echo({
							{ "Image file deleted from disk:\n", "Normal" },
							{ absolute_image_path, "Normal" },
						}, false, {})
						-- I'll refresh the images, but will clear them first
						-- I'm using [[ ]] to escape the special characters in a command
						vim.cmd([[lua require("image").clear()]])
						-- Reloads the file to reflect the changes
						vim.cmd("edit!")
					else
						vim.api.nvim_echo({
							{ "Failed to delete image file:\n", "ErrorMsg" },
							{ absolute_image_path, "ErrorMsg" },
						}, false, {})
					end
				else
					vim.api.nvim_echo({
						{ "Image deletion canceled.", "Normal" },
					}, false, {})
				end
			end)
		end
	else
		vim.api.nvim_echo({
			{ "No image found under the cursor", "WarningMsg" },
		}, false, {})
	end
end, { desc = "(macOS) Delete image file under cursor" })

-- ############################################################################

-- Refresh the images in the current buffer
-- Useful if you delete an actual image file and want to see the changes
-- without having to re-open neovim
vim.keymap.set("n", "<leader>ir", function()
	-- First I clear the images
	-- I'm using [[ ]] to escape the special characters in a command
	vim.cmd([[lua require("image").clear()]])
	-- Reloads the file to reflect the changes
	vim.cmd("edit!")
	print("Images refreshed")
end, { desc = "Refresh images" })

-- ############################################################################

-- Set up a keymap to clear all images in the current buffer
vim.keymap.set("n", "<leader>ic", function()
	-- This is the command that clears the images
	-- I'm using [[ ]] to escape the special characters in a command
	vim.cmd([[lua require("image").clear()]])
	print("Images cleared")
end, { desc = "Clear images" })
