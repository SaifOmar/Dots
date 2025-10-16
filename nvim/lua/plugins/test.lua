return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
      "V13Axel/neotest-pest",
      "nvim-neotest/neotest-jest",
    },
    opts = function(_, opts)
      opts.adapters = {
        require("neotest-plenary"),
        require("neotest-pest")({
          php_executable = "/home/saif/.config/herd-lite/bin/php", -- or path to your php
        }),
        require("neotest-jest")({
          -- jest options
        }),
      }
    end,
  },
}
