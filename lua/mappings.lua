require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "f", "<cmd>lua require'hop'.hint_words()<cr>", {})
map("n", "F", "<cmd>lua require'hop'.hint_words()<cr>", {})

-- restore the session for the current directory
map("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
-- restore the last session
map("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
-- stop Persistence => session won't be saved on exit
map("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
