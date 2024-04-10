-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'nvim-treesitter/nvim-treesitter-context',
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-k>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-l>', function()
        harpoon:list():select(4)
      end)
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
          section_separators = { left = '\u{e0c6}', right = '\u{e0c7}' },
          component_separators = { left = '\u{e0bb}', right = '\u{e0b9}' },
        },
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Fugitive: Git Status' })

      local fugitive_keymaps_group = vim.api.nvim_create_augroup('Fugitive_Keymaps', {})

      vim.api.nvim_create_autocmd('BufWinEnter', {
        group = fugitive_keymaps_group,
        pattern = '*',
        callback = function()
          if vim.bo.ft ~= 'fugitive' then
            return
          end

          local curburr = vim.api.nvim_get_current_buf()

          vim.keymap.set('n', '<leader>p', function()
            vim.cmd.Git 'push'
          end, { buffer = curburr, remap = false, desc = 'Fugitive: Git [p]ush' })

          vim.keymap.set('n', '<leader>P', function()
            vim.cmd.Git { 'pull', '--rebase' }
          end, { buffer = curburr, remap = false, desc = 'Fugitive: Git [P]ull' })
        end,
      })
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo Tree: Toggle' })
    end,
  },
}
