-- Uninstalling all lazy plugins:
-- rm -rf ~/.local/share/nvim/lazy ~/.local/state/nvim/lazy ~/.config/nvim/lazy-lock.json


return {
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            adapters = {
                acp = {
                    claude_code = function()
                        return require("codecompanion.adapters").extend("claude_code", {
                            env = {
                                api_key = "CLAUDE_CODE_OAUTH_TOKEN",
                            },
                        })
                    end,
                },
            },
            strategies = {
                chat = {
                    adapter = "claude_code",
                    model = "claude-haiku-4.5",
                    -- model = "claude-sonnet-4.5",
                },
                inline = {
                    adapter = "claude_code",
                    model = "claude-haiku-4.5",
                },
            },
        },
    },
    {
        "yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        -- ⚠️ must add this setting! ! !
        build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            -- add any opts here
            -- this file can contain specific instructions for your project
            instructions_file = "avante.md",
            -- for example
            provider = "claude-code",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-mini/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "stevearc/dressing.nvim", -- for input provider dressing
            "folke/snacks.nvim", -- for input provider snacks
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
    {
        "GeorgesAlkhouri/nvim-aider",
        enabled = false,
        cmd = "Aider",
        -- Example key mappings for common actions:
        keys = {
            { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
            { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
            { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
            { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
            { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
            { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
            { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
            { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
            -- Example nvim-tree.lua integration if needed
            { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
            { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
        },
        dependencies = {
            { "folke/snacks.nvim", version = ">=2.24.0" },
            --- The below dependencies are optional
            "catppuccin/nvim",
            "nvim-tree/nvim-tree.lua",
            --- Neo-tree integration
            {
                "nvim-neo-tree/neo-tree.nvim",
                opts = function(_, opts)
                    -- Example mapping configuration (already set by default)
                    -- opts.window = {
                        --   mappings = {
                            --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
                            --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
                            --     ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" }
                            --   }
                            -- }
                            require("nvim_aider.neo_tree").setup(opts)
                        end,
                },
            },
            config = function()
            require("nvim_aider").setup({
                aider_cmd = "aider --model ollama_chat/deepseek-r1:1.5b",
                args = {
                    "--no-gitignore",
                    "--no-auto-commits",
                    "--pretty",
                    "--stream",
                },
                auto_reload = false,
                idle_timeout = 5000,
                response_timeout = 30000,
                quick_idle_timeout = 500,
                quick_commands = {
                    "/add",
                    "/drop",
                    "/read-only",
                    "/ls",
                    "/clear",
                    "/reset",
                    "/undo",
                },
                notifications = true,
                theme = {
                    user_input_color = "#a6da95",
                    tool_output_color = "#8aadf4",
                    tool_error_color = "#ed8796",
                    tool_warning_color = "#eed49f",
                    assistant_output_color = "#c6a0f6",
                    completion_menu_color = "#cad3f5",
                    completion_menu_bg_color = "#24273a",
                    completion_menu_current_color = "#181926",
                    completion_menu_current_bg_color = "#f4dbd6",
                },
                picker_cfg = {
                    preset = "vscode",
                },
                config = {
                    os = { editPreset = "nvim-remote" },
                    gui = { nerdFontsVersion = "3" },
                },
                win = {
                    wo = { winbar = "Aider" },
                    style = "nvim_aider",
                    position = "right",
                },
            })
        end,
    },
    {
        "nekowasabi/aider.vim",
        enabled = false,
        dependencies = "vim-denops/denops.vim",
        config = function()
            vim.g.aider_command = 'aider --no-auto-commits --no-gitignore --model ollama_chat/deepseek-r1:1.5b'
            -- vim.g.aider_command = 'aider --no-auto-commits --no-gitignore --model openrouter/qwen/qwen3-coder:free'
            -- Where to show Aider
            -- 'floating': inside Neovim. 'vsplit'/'split': if inside tmux, use a tmux pane
            vim.g.aider_buffer_open_type = 'floating'
            vim.g.aider_floatwin_width = 100
            vim.g.aider_floatwin_height = 20

            vim.api.nvim_create_autocmd('User',
            {
                pattern = 'AiderOpen',
                callback =
                function(args)
                    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
                    vim.keymap.set('n', '<Esc>', '<cmd>AiderHide<CR>', { buffer = args.buf })
                end
            })
            vim.api.nvim_set_keymap('n', '<leader>at', ':AiderRun<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>aa', ':AiderAddCurrentFile<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>ar', ':AiderAddCurrentFileReadOnly<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>aw', ':AiderAddWeb<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>ax', ':AiderExit<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>ai', ':AiderAddIgnoreCurrentFile<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>aI', ':AiderOpenIgnore<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>ap', ':AiderPaste<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>ah', ':AiderHide<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('v', '<leader>av', ':AiderVisualTextWithPrompt<CR>', { noremap = true, silent = true })
        end
    },
	{
		"robitx/gp.nvim",
        enabled = false,
		-- { "robitx/gp.nvim", enabled = false },
		config = function()
			local conf = {
				-- For customization, refer to Install > Configuration in the Documentation/Readme
			}
			require("gp").setup(conf)

			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
		end,
    },
    -- Amp Plugin
    {
        "sourcegraph/amp.nvim",
        enabled = false,
        branch = "main", 
        lazy = false,
        opts = { auto_start = true, log_level = "info" },
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
            message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
        },

    },
    {
		"frankroeder/parrot.nvim",
		event = "VeryLazy",
		enabled = false,
		dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
		dev = vim.fn.has "macunix" == 1 and vim.fn.expand "$USER" == "frankroeder",
		lazy = false,
		config = function(_, opts)
			-- add ollama if executable found
			require("parrot").setup(opts)
		end,
		opts = {
            providers = {
                openai = {
                    name = "openai",
                    api_key = os.getenv "OPENAI_API_KEY",
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    params = {
                        chat = { temperature = 1.1, top_p = 1 },
                        command = { temperature = 1.1, top_p = 1 },
                    },
                    topic = {
                        model = "gpt-5",
                        params = { max_completion_tokens = 64 },
                    },
                    models ={
                        "gpt-5",
                        "gpt-4o",
                        "o4-mini",
                        "gpt-4.1-nano",
                    }
                },
--				anthropic = {
--					api_key = os.getenv "ANTHROPIC_API_KEY",
--					params = {
--						chat = {
--							max_tokens = 4096,
--							thinking = {
--								budget_tokens = 1024,
--								type = "enabled",
--							},
--						},
--						command = { max_tokens = 4096 },
--					},
--				},
--				gemini = {
--					api_key = os.getenv "GEMINI_API_KEY",
--				},
--				github = {
--					api_key = os.getenv "GITHUB_TOKEN",
--				},
--				xai = {
--					api_key = os.getenv "XAI_API_KEY",
--				},
			},
			cmd_prefix = "Prt",
			chat_conceal_model_params = false,
			user_input_ui = "buffer",
			toggle_target = "tabnew",
			online_model_selection = true,
			command_auto_select_response = true,
			show_context_hints = true,
			hooks = {
				Complete = function(prt, params)
					local template = [[
					I have the following code from {{filename}}:

					```{{filetype}}
					{{selection}}
					```

					Please finish the code above carefully and logically.
					Respond just with the snippet of code that should be inserted."
					]]
					local model_obj = prt.get_model "command"
					prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
				end,
				CompleteFullContext = function(prt, params)
					local template = [[
					I have the following code from {{filename}}:

					```{{filetype}}
					{{filecontent}}
					```

					Please look at the following section specifically:
					```{{filetype}}
					{{selection}}
					```

					Please finish the code above carefully and logically.
					Respond just with the snippet of code that should be inserted.
					]]
					local model_obj = prt.get_model "command"
					prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
				end,
				CompleteMultiContext = function(prt, params)
					local template = [[
					I have the following code from {{filename}} and other realted files:

					```{{filetype}}
					{{multifilecontent}}
					```

					Please look at the following section specifically:
					```{{filetype}}
					{{selection}}
					```

					Please finish the code above carefully and logically.
					Respond just with the snippet of code that should be inserted.
					]]
					local model_obj = prt.get_model "command"
					prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
				end,
				Explain = function(prt, params)
					local template = [[
					Your task is to take the code snippet from {{filename}} and explain it with gradually increasing complexity.
					Break down the code's functionality, purpose, and key components.
					The goal is to help the reader understand what the code does and how it works.

					```{{filetype}}
					{{selection}}
					```

					Use the markdown format with codeblocks and inline code.
					Explanation of the code above:
					]]
					local model = prt.get_model "command"
					prt.logger.info("Explaining selection with model: " .. model.name)
					prt.Prompt(params, prt.ui.Target.new, model, nil, template)
				end,
				FixBugs = function(prt, params)
					local template = [[
					You are an expert in {{filetype}}.
					Fix bugs in the below code from {{filename}} carefully and logically:
					Your task is to analyze the provided {{filetype}} code snippet, identify
					any bugs or errors present, and provide a corrected version of the code
					that resolves these issues. Explain the problems you found in the
					original code and how your fixes address them. The corrected code should
					be functional, efficient, and adhere to best practices in
					{{filetype}} programming.

					```{{filetype}}
					{{selection}}
					```

					Fixed code:
					]]
					local model_obj = prt.get_model "command"
					prt.logger.info("Fixing bugs in selection with model: " .. model_obj.name)
					prt.Prompt(params, prt.ui.Target.new, model_obj, nil, template)
				end,
				Optimize = function(prt, params)
					local template = [[
					You are an expert in {{filetype}}.
					Your task is to analyze the provided {{filetype}} code snippet and
					suggest improvements to optimize its performance. Identify areas
					where the code can be made more efficient, faster, or less
					resource-intensive. Provide specific suggestions for optimization,
					along with explanations of how these changes can enhance the code's
					performance. The optimized code should maintain the same functionality
					as the original code while demonstrating improved efficiency.

					```{{filetype}}
					{{selection}}
					```

					Optimized code:
					]]
					local model_obj = prt.get_model "command"
					prt.logger.info("Optimizing selection with model: " .. model_obj.name)
					prt.Prompt(params, prt.ui.Target.new, model_obj, nil, template)
				end,
				UnitTests = function(prt, params)
					local template = [[
					I have the following code from {{filename}}:

					```{{filetype}}
					{{selection}}
					```

					Please respond by writing table driven unit tests for the code above.
					]]
					local model_obj = prt.get_model "command"
					prt.logger.info("Creating unit tests for selection with model: " .. model_obj.name)
					prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
				end,
				Debug = function(prt, params)
					local template = [[
					I want you to act as {{filetype}} expert.
					Review the following code, carefully examine it, and report potential
					bugs and edge cases alongside solutions to resolve them.
					Keep your explanation short and to the point:

					```{{filetype}}
					{{selection}}
					```
					]]
					local model_obj = prt.get_model "command"
					prt.logger.info("Debugging selection with model: " .. model_obj.name)
					prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
				end,
				CommitMsg = function(prt, params)
					local futils = require "parrot.file_utils"
					if futils.find_git_root() == "" then
						prt.logger.warning "Not in a git repository"
						return
					else
						local template = [[
						I want you to act as a commit message generator. I will provide you
						with information about the task and the prefix for the task code, and
						I would like you to generate an appropriate commit message using the
						conventional commit format. Do not write any explanations or other
						words, just reply with the commit message.
						Start with a short headline as summary but then list the individual
						changes in more detail.

						Here are the changes that should be considered by this message:
						]] .. vim.fn.system "git diff --no-color --no-ext-diff --staged"
						local model_obj = prt.get_model "command"
						prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
					end
				end,
				SpellCheck = function(prt, params)
					local chat_prompt = [[
					Your task is to take the text provided and rewrite it into a clear,
					grammatically correct version while preserving the original meaning
					as closely as possible. Correct any spelling mistakes, punctuation
					errors, verb tense issues, word choice problems, and other
					grammatical mistakes.
					]]
					prt.ChatNew(params, chat_prompt)
				end,
				CodeConsultant = function(prt, params)
					local chat_prompt = [[
					Your task is to analyze the provided {{filetype}} code and suggest
					improvements to optimize its performance. Identify areas where the
					code can be made more efficient, faster, or less resource-intensive.
					Provide specific suggestions for optimization, along with explanations
					of how these changes can enhance the code's performance. The optimized
					code should maintain the same functionality as the original code while
					demonstrating improved efficiency.

					Here is the code
					```{{filetype}}
					{{filecontent}}
					```
					]]
					prt.ChatNew(params, chat_prompt)
				end,
				ProofReader = function(prt, params)
					local chat_prompt = [[
					I want you to act as a proofreader. I will provide you with texts and
					I would like you to review them for any spelling, grammar, or
					punctuation errors. Once you have finished reviewing the text,
					provide me with any necessary corrections or suggestions to improve the
					text. Highlight the corrected fragments (if any) using markdown backticks.

					When you have done that subsequently provide me with a slightly better
					version of the text, but keep close to the original text.

					Finally provide me with an ideal version of the text.

					Whenever I provide you with text, you reply in this format directly:

					## Corrected text:

					{corrected text, or say "NO_CORRECTIONS_NEEDED" instead if there are no corrections made}

					## Slightly better text

					{slightly better text}

					## Ideal text

					{ideal text}
					]]
					prt.ChatNew(params, chat_prompt)
				end,
			},
		},
		keys = {
			{ "<C-g>c", "<cmd>PrtChatNew<cr>", mode = { "n", "i" }, desc = "New Chat" },
			{ "<C-g>c", ":<C-u>'<,'>PrtChatNew<cr>", mode = { "v" }, desc = "Visual Chat New" },
			{ "<C-g>t", "<cmd>PrtChatToggle<cr>", mode = { "n", "i" }, desc = "Toggle Popup Chat" },
			{ "<C-g>f", "<cmd>PrtChatFinder<cr>", mode = { "n", "i" }, desc = "Chat Finder" },
			{ "<C-g>r", "<cmd>PrtRewrite<cr>", mode = { "n", "i" }, desc = "Inline Rewrite" },
			{ "<C-g>r", ":<C-u>'<,'>PrtRewrite<cr>", mode = { "v" }, desc = "Visual Rewrite" },
			{
				"<C-g>j",
				"<cmd>PrtRetry<cr>",
				mode = { "n" },
				desc = "Retry rewrite/append/prepend command",
			},
			{ "<C-g>a", "<cmd>PrtAppend<cr>", mode = { "n", "i" }, desc = "Append" },
			{ "<C-g>a", ":<C-u>'<,'>PrtAppend<cr>", mode = { "v" }, desc = "Visual Append" },
			{ "<C-g>o", "<cmd>PrtPrepend<cr>", mode = { "n", "i" }, desc = "Prepend" },
			{ "<C-g>o", ":<C-u>'<,'>PrtPrepend<cr>", mode = { "v" }, desc = "Visual Prepend" },
			{ "<C-g>e", ":<C-u>'<,'>PrtEnew<cr>", mode = { "v" }, desc = "Visual Enew" },
			{ "<C-g>s", "<cmd>PrtStop<cr>", mode = { "n", "i", "v", "x" }, desc = "Stop" },
			{
				"<C-g>i",
				":<C-u>'<,'>PrtComplete<cr>",
				mode = { "n", "i", "v", "x" },
				desc = "Complete visual selection",
			},
			{ "<C-g>x", "<cmd>PrtContext<cr>", mode = { "n" }, desc = "Open context file" },
			{ "<C-g>n", "<cmd>PrtModel<cr>", mode = { "n" }, desc = "Select model" },
			{ "<C-g>p", "<cmd>PrtProvider<cr>", mode = { "n" }, desc = "Select provider" },
			{ "<C-g>q", "<cmd>PrtAsk<cr>", mode = { "n" }, desc = "Ask a question" },
		},
	},
	{
		"lewis6991/fileline.nvim"
	},
}


