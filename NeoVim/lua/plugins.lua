-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ 
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000,
		lazy = true,
	},
	-- nice bar at the bottom
	{
		'itchyny/lightline.vim',
		lazy = false, -- also load at start since it's UI
		config = function()
			-- no need to also show mode in cmd line when we have bar
			vim.o.showmode = false
			vim.g.lightline = {
				colorscheme = 'catppuccin',
				active = {
					left = {
						{ 'mode', 'paste' },
						{ 'readonly', 'filename', 'modified' }
					},
					right = {
						{ 'lineinfo' },
						{ 'percent' },
						{ 'fileencoding', 'filetype' }
					},
				},
				component_function = {
					filename = 'LightlineFilename'
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand('%:t') == '' then
					return '[No Name]'
				else
					return vim.fn.getreg('%')
				end
			end
			-- https://github.com/itchyny/lightline.vim/issues/657
			vim.api.nvim_exec(
			[[
				function! g:LightlineFilename()
					return v:lua.LightlineFilenameInLua()
				endfunction
			]],
			true
			)
		end
	},
	
	--{
	--	'junegunn/fzf.vim',
	--	dependencies = {
	--		{ 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
	--	},
	--	config = function()
	--		-- stop putting a giant window over my editor
	--		vim.g.fzf_layout = { down = '~20%' }
	--	end
	--},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>o', builtin.find_files, {})
			vim.keymap.set('n', '<c-p>', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>b', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end
		
	},
	-- better %
	{
		'andymass/vim-matchup',
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end
	},
	-- LSP
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- Setup language servers.

			-- Rust
			vim.lsp.config('rust_analyzer', {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						imports = {
							group = {
								enable = false,
							},
						},
						completion = {
							postfix = {
								enable = false,
							},
						},
					},
				},
			})
			vim.lsp.enable('rust_analyzer')

			util = require "lspconfig/util"

			local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			vim.lsp.config('gopls', {
				capabilities = capabilities,
				flags = { debounce_text_changes = 200 },
				settings = {
					gopls = {
						usePlaceholders = true,
						gofumpt = true,
						analyses = {
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						experimentalPostfixCompletions = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-node_modules" },
						semanticTokens = true,
						hints = {
							assignVariableTypes = false,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = false,
							functionTypeParameters = true,
							parameterNames = false,
							rangeVariableTypes = true,
						},
					},
				},
			})
			vim.lsp.enable('gopls')


			-- Bash LSP
			if vim.fn.executable('bash-language-server') == 1 then
				vim.lsp.enable('bashls')
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
					-- *and* there's some way to make it only apply to the current line.
					if client.server_capabilities.inlayHintProvider then
					    vim.lsp.inlay_hint.enable(true)
					end

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
					-- client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end
	},
	-- LSP-based code-completion
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			'neovim/nvim-lspconfig',
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require'cmp'
			cmp.setup({
				snippet = {
					-- REQUIRED by nvim-cmp. get rid of it once we can
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					-- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					['<CR>'] = cmp.mapping.confirm({ select = false }),
					['<Tab>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = "copilot", group_index = 2 },
				}, {
					{ name = 'path' },
				}),
				experimental = {
					ghost_text = true,
				},
			})

			-- Enable completing paths in :
			cmp.setup.cmdline(':', {
				sources = cmp.config.sources({
					{ name = 'path' }
				})
			})

		end
	},
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require "lsp_signature".setup({
				doc_lines = 0,
				handler_opts = {
					border = "none"
				},
			})
		end
	},
	-- language support
	-- toml
	'cespare/vim-toml',
	-- yaml
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- rust
	{
		'rust-lang/rust.vim',
		ft = { "rust" },
		config = function()
			vim.g.rustfmt_autosave = 1
			vim.g.rustfmt_emit_files = 1
			vim.g.rustfmt_fail_silently = 0
			vim.g.rust_clip_command = 'wl-copy'
		end
	},
	-- fish
	'khaveesh/vim-fish-syntax',
	-- markdown
	{
		'plasticboy/vim-markdown',
		ft = { "markdown" },		dependencies = {
			'godlygeek/tabular',
		},
		config = function()
			-- never ever fold!
			vim.g.vim_markdown_folding_disabled = 1
			-- support front-matter in .md files
			vim.g.vim_markdown_frontmatter = 1
			-- 'o' on a list item should insert at same level
			vim.g.vim_markdown_new_list_item_indent = 0
			-- don't add bullets when wrapping:
			-- https://github.com/preservim/vim-markdown/issues/232
			vim.g.vim_markdown_auto_insert_bullets = 0
		end
	},
	{
		"fatih/vim-go",
		config = function ()
			-- we disable most of these features because treesitter and nvim-lsp
			-- take care of it
			vim.g['go_gopls_enabled'] = 0
			vim.g['go_code_completion_enabled'] = 0
			vim.g['go_fmt_autosave'] = 0
			vim.g['go_imports_autosave'] = 0
			vim.g['go_mod_fmt_autosave'] = 0
			vim.g['go_doc_keywordprg_enabled'] = 0
			vim.g['go_def_mapping_enabled'] = 0
			vim.g['go_textobj_enabled'] = 0
			vim.g['go_list_type'] = 'quickfix'
		end,
	},
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				filters = {
					dotfiles = true,
				},
				on_attach = function(bufnr)
					local api = require('nvim-tree.api')

					local function opts(desc)
						return {
							desc = 'nvim-tree: ' .. desc,
							buffer = bufnr,
							noremap = true,
							silent = true,
							nowait = true,
						}
					end

					api.config.mappings.default_on_attach(bufnr)

					vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
					vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
					vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
				end
			})
		end,
	},
	"tpope/vim-fugitive",
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"AndrewRadev/splitjoin.vim",
		lazy = false,
	},
	"rest-nvim/rest.nvim",
	{
		"epwalsh/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

		},
		opts = {
			disable_frontmatter = true,
			workspaces = {
				{
					name = "Acronis",
					path = "~/Documents/AcronisV",
				}
			},
			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = "Periodic/Daily",
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = "%Y/%m/%d-%b",
			},

		},
	}	
})



require("catppuccin").setup({
	flavour = "mocha",
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" } -- Change the style of comment
	},
})

require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'bash',
		'fish',
		'go',
		'gomod',
		'json',
		'lua',
		'markdown',
		'markdown_inline',
		'mermaid',
		'rust',
		'vim',
		'vimdoc',
		'yaml',

	},
	highlight = {
		enable = true,
		-- Disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}
require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
