" Syntax file options
let php_parent_error_close=1
let php_parent_error_open=1

" Documentation via K, see scripts/php_doc.sh
set keywordprg=php_doc

" Update control structures to PSR whitespacing.
noremap <Leader>p :%s/\(if\\|switch\\|for\\|foreach\\|while\)(/\1 (/ge<CR>
    \:%s/\(function\\|trait\\|interface\\|class\) \(.*\) {/\1 \2\r{/e<CR>

" Re-orders and formats the contents of a long PHP array.
noremap <Leader>o vib<gv:s/, /,\r/g<CR>vib:sort<CR>gvJgqq>ibgv:s/ $//<CR>

" Method declaration abbreviations
abbr prf private function%()<CR>{<CR>}<CR><ESC>?%<CR>xi
abbr puf public function%()<CR>{<CR>}<CR><ESC>?%<CR>xi

" Dump local PHP variables (names, name=>contents).
abbr dlv {<CR>$locals = get_defined_vars();<CR>
    \$buffers = array(); while(ob_get_level()) $buffers[] = ob_get_clean();<CR>
    \$buffers = array_filter($buffers) ?: null;<CR>
    \header('Content-Type: text/html; charset=UTF-8');<CR>
    \var_dump(array_keys($locals), $locals, compact('buffers'));<CR>
    \function_exists('xdebug_print_function_stack') AND xdebug_print_function_stack();<CR>
    \die();<CR>}<ESC>^v%J^

" Like dlv but dumps JSON.
abbr djv {<CR>$locals = get_defined_vars();<CR>
    \(PHP_SAPI === 'cli') OR header('Content-Type: application/json');<CR>
    \echo json_encode(array(array_keys($locals), $locals));<CR>
    \die();<CR>}<ESC>^v%J^
