" Fountain syntax file - maintained for backward compatibility
" Modern implementation is in lua/nvim-fountain/syntax.lua

if exists("b:current_syntax")
  finish
endif
syn sync minlines=200

syn match fountainSection1 "^\s*# \(\_[^#]\)" fold transparent contains=ALL
syn region fountainTitlePage start="\%^\(.*\):" end="^$" contains=fountainBoneyard,fountainNotes
syn match fountainCharacter "^\(\L\)*$" 
syn region fountainDialogue matchgroup=fountainCharacter start="^\(\L\)*$" end="^\s*$" contains=fountainCharacter,fountainParenthetical,fountainBoneyard,fountainNotes,fountainEmphasis
syn match fountainParenthetical "^\s*\((.*)\)$" contained contains=fountainBoneyard,fountainNotes
syn match fountainTransition "^\(\L\)* TO:$" contains=fountainBoneyard,fountainNotes
syn match fountainTransitionForced "^\s*>\(.*\)" contains=fountainBoneyard,fountainNotes
syn match fountainCentered "^\s*>\(.*\)<" contains=fountainBoneyard,fountainNotes
syn match fountainUnderlined "_[^_]*_" 
syn match fountainItalic "\*[^\*]*\*"
syn match fountainBold "\*\*[^\*]*\*\*"
syn match fountainBoldItalic "\*\*\*[^\*]*\*\*\*" 
syn match fountainPagebreak "^===[=]*$"
syn region fountainNotes start="\[\[" end="\]\]" contains=xLineContinue
syn region fountainHeader1 start="^\s*# " end="$" contains=fountainBoneyard,fountainNotes
syn region fountainHeader2 start="^\s*## " end="$" contains=fountainBoneyard,fountainNotes
syn region fountainHeader3 start="^\s*### " end="$" contains=fountainBoneyard,fountainNotes
syn region fountainHeader4 start="^\s*#### " end="$" contains=fountainBoneyard,fountainNotes
syn region fountainHeader5 start="^\s*##### " end="$" contains=fountainBoneyard,fountainNotes
syn region fountainHeader6 start="^\s*###### " end="$" contains=fountainBoneyard,fountainNotes
syn region fountainSynopses start="^\s*= " end="$" contains=fountainBoneyard,fountainNotes
syn region fountainSceneHeading start="^\s*\(\.\|INT\. \|EXT\. \|INT\./EXT\. \|INT/EXT\. \|INT \|EXT \|INT/EXT \|I/E \|int\. \|ext\. \|int\./ext\. \|int/ext\. \|int \|ext \|int/ext \|i/e \)" end="$" contains=fountainSceneNumber,fountainBoneyard,fountainNotes 
syn region fountainBoneyard start="/\*" end="\*\/" contains=xLineContinue
syn match xLineContinue "\\$" contained
syn region fountainSceneNumber start="#" end="#" contained

" Call Lua function to set up highlights
lua require('nvim-fountain.syntax').setup()

let b:current_syntax = "fountain"
