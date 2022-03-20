vim.cmd([[
try
  set background=dark
  set termguicolors
  let g:neosolarized_termtrans=1
  colorscheme Neosolarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]])
