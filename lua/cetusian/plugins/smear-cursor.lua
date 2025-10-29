return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- Smear cursor configuration
    cursor_color = "#d3cdc3",

    -- Smear effect
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,

    -- Animation settings
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    distance_stop_animating = 0.5,
    hide_target_hack = false,
  },
}
