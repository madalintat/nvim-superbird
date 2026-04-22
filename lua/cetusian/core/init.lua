require("cetusian.core.options")
require("cetusian.core.keymaps")

local py = vim.fn.expand("~/gen_ai_course/gen_ai/bin/python")
if vim.fn.executable(py) == 1 then
  vim.g.python3_host_prog = py
end
