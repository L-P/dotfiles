abbr ifee if err :=%; err != nil {<CR>}<CR><ESC>?%<CR>xi
abbr ife if err != nil {<CR>return err %<CR>}<CR><ESC>?%<CR>xi

let b:ale_linters = ['gobuild', 'golangci-lint']
let b:ale_fixers = ['goimports', 'gofmt']
let b:ale_fix_on_save = 1
let g:ale_go_golangci_lint_package = 1
