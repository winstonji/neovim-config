return {
	{
		{
			'williamboman/mason.nvim',
			lazy = false,
			opts = {},
		},

		-- Autocompletion
		{
			'hrsh7th/nvim-cmp',
			event = 'InsertEnter',
			config = function()
				local cmp = require('cmp')
				local cmp_select = {behavior = cmp.SelectBehavior.Select}
				cmp.setup({
					sources = {
						{ name = 'nvim_lsp' },
					},
					mapping = cmp.mapping.preset.insert({
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-u>'] = cmp.mapping.scroll_docs(-4),
						['<C-d>'] = cmp.mapping.scroll_docs(4),
						['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
						['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
						['<C-y>'] = cmp.mapping.confirm({select = true}),
					}),
					snippet = {
						expand = function(args)
							require('luasnip').lsp_expand(args.body)
						end,
					},
				})
			end
		},

		-- LSP
		{
			'neovim/nvim-lspconfig',
			cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
			event = { 'BufReadPre', 'BufNewFile' },
			dependencies = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'williamboman/mason.nvim' },
				{ 'williamboman/mason-lspconfig.nvim' },
			},
			init = function()
				-- Reserve a space in the gutter
				-- This will avoid an annoying layout shift in the screen
				vim.opt.signcolumn = 'yes'
			end,
			config = function()
				local lsp_defaults = require('lspconfig').util.default_config

				-- Add cmp_nvim_lsp capabilities settings to lspconfig
				-- This should be executed before you configure any language server
				lsp_defaults.capabilities = vim.tbl_deep_extend(
					'force',
					lsp_defaults.capabilities,
					require('cmp_nvim_lsp').default_capabilities()
				)

				-- LspAttach is where you enable features that only work
				-- if there is a language server active in the file
				vim.api.nvim_create_autocmd('LspAttach', {
					desc = 'LSP actions',
					callback = function(event)
						local opts = { buffer = event.buf }

						vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
						vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
						vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
						vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
						vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
						vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
						vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
						vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
					end,
				})

				require('mason-lspconfig').setup({
					ensure_installed = {'lua_ls', 'pyright', 'tsserver', 'clangd', 'html', 'cssls', 'jsonls'},
					automatic_installation = true,
					handlers = {
						-- this first function is the "default handler"
						-- it applies to every language server without a "custom handler"
						function(server_name)
							require('lspconfig')[server_name].setup({})
						end,
					}
				})
			end
		}
	}
}
