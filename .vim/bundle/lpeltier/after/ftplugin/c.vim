setlocal foldmethod=syntax
setlocal nofoldenable
setlocal equalprg=

let b:ale_c_build_dir = 'build'
let b:ale_c_parse_compile_commands = 1
let b:ale_cpp_clang_options = ''
let b:ale_fix_on_save = 1
let b:ale_fixers = ['clang-format']
let b:ale_linters = ['clangtidy', 'clang']
