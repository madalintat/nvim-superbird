require("cetusian.core.options")
require("cetusian.core.keymaps")

local py = vim.fn.expand("~/gen_ai_course/gen_ai/bin/python")
if vim.uv.fs_stat(py) then
  vim.g.python3_host_prog = py
end
