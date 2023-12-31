local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },

  -- window = {
  --   completion = cmp.config.window.bordered({
  --     border = 'single'
  --   }),
  --   documentation = cmp.config.window.bordered({
  --     border = 'single'
  --   }),
  -- },

  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<Enter>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'calc' },
    { name = 'emoji' },
    { name = 'skkeleton'},
  }),

  experimental = {
    ghost_text = true
  }
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(),{'i', 'c'}),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(),{'i', 'c'}),
    ['<Enter>'] = cmp.mapping(cmp.mapping.abort(),{'i', 'c'}),
    ['<C-y>'] = cmp.mapping(cmp.mapping.confirm({ select = true }),{'i', 'c'}),
  }
  ),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline', keyword_length = 2 }
  })
})
