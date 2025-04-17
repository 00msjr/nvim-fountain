-- nvim-fountain syntax module
local M = {}

-- Setup syntax highlighting
function M.setup()
  -- Define highlight groups
  local highlight_groups = {
    FountainTitlePage = { link = "Title" },
    FountainSceneHeading = { link = "Title" },
    FountainCharacter = { link = "Identifier" },
    FountainDialogue = { link = "Statement" },
    FountainParenthetical = { link = "Function" },
    FountainTransition = { link = "Todo" },
    FountainTransitionForced = { link = "Todo" },
    FountainCentered = { link = "Character" },
    FountainUnderlined = { underline = true },
    FountainItalic = { italic = true },
    FountainBold = { bold = true },
    FountainBoldItalic = { bold = true, italic = true },
    FountainPagebreak = { link = "Conditional" },
    FountainNotes = { link = "Comment" },
    FountainBoneyard = { link = "NonText" },
    FountainHeader1 = { link = "htmlH1" },
    FountainHeader2 = { link = "htmlH2" },
    FountainHeader3 = { link = "htmlH3" },
    FountainHeader4 = { link = "htmlH4" },
    FountainHeader5 = { link = "htmlH5" },
    FountainHeader6 = { link = "htmlH6" },
    FountainSynopses = { link = "Number" },
    FountainSceneNumber = { link = "Number" },
  }

  -- Apply highlight groups
  for group_name, group_settings in pairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group_name, group_settings)
  end
end

return M
