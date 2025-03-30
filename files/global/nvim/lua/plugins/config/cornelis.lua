return function(_)
   vim.g.cornelis_split_location = "bottom"
   vim.g.cornelis_no_agda_input  = true

   vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = {"*.agda"},
      callback = function(_)
         vim.cmd("CornelisLoad")
      end
   })

   local set = vim.keymap.set
   local opts = { buffer=true, silent=true }

   set("n", "<localleader>,", vim.cmd.CornelisTypeContextInfer, opts)
   set("n", "<localleader>.", vim.cmd.CornelisTypeContext     , opts)
   set("n", "<localleader>a", vim.cmd.CornelisAuto            , opts)
   set("n", "<localleader>c", vim.cmd.CornelisMakeCase        , opts)
   set("n", "<localleader>e", vim.cmd.CornelisElaborate       , opts)
   set("n", "<localleader>g", vim.cmd.CornelisGive            , opts)
   set("n", "<localleader>l", vim.cmd.CornelisLoad            , opts)
   set("n", "<localleader>n", vim.cmd.CornelisNormalize       , opts)
   set("n", "<localleader>q", vim.cmd.CornelisQuestionToMeta  , opts)
   set("n", "<localleader>r", vim.cmd.CornelisRefine          , opts)
   set("n", "<localleader>s", vim.cmd.CornelisSolve           , opts)
   set("n", "gd"            , vim.cmd.CornelisGoToDefinition  , opts)
   set("n", "[g"            , vim.cmd.CornelisPrevGoal        , opts)
   set("n", "]g"            , vim.cmd.CornelisNextGoal        , opts)
   set("n", "<C-a>"         , vim.cmd.CornelisInc             , opts)
   set("n", "<C-x>"         , vim.cmd.CornelisDec             , opts)

   -- Largely taking these from here:
   --    https://github.com/agda/cornelis/blob/master/agda-input.vim
   -- Add as needed.

   set("i", "<localleader><"   , "⟨")
   set("i", "<localleader>>"   , "⟩")
   set("i", "<localleader>'"   , "′")
   set("i", "<localleader>.-"  , "∸")
   set("i", "<localleader>="   , "≡")
   set("i", "<localleader>all" , "∀")
   set("i", "<localleader>eq"  , "≡")
   set("i", "<localleader>l"   , "λ")
   set("i", "<localleader>qed" , "∎")
   set("i", "<localleader>st"  , "≡⟨⟩")
   set("i", "<localleader>to"  , "→")

   set("i", "<localleader>A", "𝔸")
   set("i", "<localleader>B", "𝔹")
   set("i", "<localleader>C", "ℂ")
   set("i", "<localleader>D", "𝔻")
   set("i", "<localleader>E", "𝔼")
   set("i", "<localleader>F", "𝔽")
   set("i", "<localleader>G", "𝔾")
   set("i", "<localleader>H", "ℍ")
   set("i", "<localleader>I", "𝕀")
   set("i", "<localleader>J", "𝕁")
   set("i", "<localleader>K", "𝕂")
   set("i", "<localleader>L", "𝕃")
   set("i", "<localleader>M", "𝕄")
   set("i", "<localleader>N", "ℕ")
   set("i", "<localleader>O", "𝕆")
   set("i", "<localleader>P", "ℙ")
   set("i", "<localleader>Q", "ℚ")
   set("i", "<localleader>R", "ℝ")
   set("i", "<localleader>S", "𝕊")
   set("i", "<localleader>T", "𝕋")
   set("i", "<localleader>U", "𝕌")
   set("i", "<localleader>V", "𝕍")
   set("i", "<localleader>W", "𝕎")
   set("i", "<localleader>X", "𝕏")
   set("i", "<localleader>Y", "𝕐")
   set("i", "<localleader>Z", "ℤ")

   -- Superscript.
   set("i", "<localleader>^a", "ᵃ")
   set("i", "<localleader>^b", "ᵇ")
   set("i", "<localleader>^c", "ᶜ")
   set("i", "<localleader>^d", "ᵈ")
   set("i", "<localleader>^e", "ᵉ")
   set("i", "<localleader>^f", "ᶠ")
   set("i", "<localleader>^g", "ᵍ")
   set("i", "<localleader>^h", "ʰ")
   set("i", "<localleader>^i", "ⁱ")
   set("i", "<localleader>^j", "ʲ")
   set("i", "<localleader>^k", "ᵏ")
   set("i", "<localleader>^l", "ˡ")
   set("i", "<localleader>^m", "ᵐ")
   set("i", "<localleader>^n", "ⁿ")
   set("i", "<localleader>^o", "ᵒ")
   set("i", "<localleader>^p", "ᵖ")
   set("i", "<localleader>^q", "𐞥")
   set("i", "<localleader>^r", "ʳ")
   set("i", "<localleader>^s", "ˢ")
   set("i", "<localleader>^t", "ᵗ")
   set("i", "<localleader>^u", "ᵘ")
   set("i", "<localleader>^v", "ᵛ")
   set("i", "<localleader>^w", "ʷ")
   set("i", "<localleader>^x", "ˣ")
   set("i", "<localleader>^y", "ʸ")
   set("i", "<localleader>^z", "ᶻ")

   -- Subscript.
   set("i", "<localleader>0", "₀")
   set("i", "<localleader>1", "₁")
   set("i", "<localleader>2", "₂")
   set("i", "<localleader>3", "₃")
   set("i", "<localleader>4", "₄")
   set("i", "<localleader>5", "₅")
   set("i", "<localleader>6", "₆")
   set("i", "<localleader>7", "₇")
   set("i", "<localleader>8", "₈")
   set("i", "<localleader>9", "₉")


   local hl  = vim.api.nvim_set_hl
   hl(0, "CornelisSymbol", { link = "Delimiter" })
end
