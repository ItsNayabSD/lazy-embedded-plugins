-- Uninstalling all lazy plugins:
-- rm -rf ~/.local/share/nvim/lazy ~/.local/state/nvim/lazy ~/.config/nvim/lazy-lock.json
return {
	{
		"robitx/gp.nvim",
		-- { "robitx/gp.nvim", enabled = false },
		config = function()
			local conf = {
				-- For customization, refer to Install > Configuration in the Documentation/Readme
			}
			require("gp").setup(conf)

			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
		end,
	},
	{
		"f-person/git-blame.nvim",
		-- load the plugin at startup
		event = "VeryLazy",
		-- Because of the keys part, you will be lazy loading this plugin.
		-- The plugin wil only load once one of the keys is used.
		-- If you want to load the plugin at startup, add something like event = "VeryLazy",
		-- or lazy = false. One of both options will work.
		opts = {
			-- your configuration comes here
			-- for example
			enabled = true,  -- if you want to enable the plugin
			message_template = "<<sha>> • <author> • <summary> • <date>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
		},

	}
}
