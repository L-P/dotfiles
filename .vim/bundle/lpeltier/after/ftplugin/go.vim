abbr ife if err :=%; err != nil {<CR>}<CR><ESC>?%<CR>xi

let b:ale_linters = ['golangci-lint']
let b:ale_fixers = ['goimports', 'gofmt']
let b:ale_fix_on_save = 1
let g:ale_go_golangci_lint_package = 1
