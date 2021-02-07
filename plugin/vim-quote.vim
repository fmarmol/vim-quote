if !has('python3')
    echo "Error: Required vim compiled with +python3"
    finish
endif
if exists('g:define_vim_quote')
    finish
endif
let g:define_vim_quote = 1
command! -nargs=0 Quote call Quote()

function! Quote()
python3 << EOF
import vim
buf = vim.current.buffer
line = vim.current.line
line_number, col = vim.current.window.cursor

# line_number start at 1
# col start at 0
# gg

index_min = col
index_max = col
current_char = line[index_min]
while current_char.isalnum() or current_char in {'_', '-'}:
    if index_min > 0:
        index_min = index_min - 1
    else:
        index_min= -1
        break
    current_char = line[index_min]
index_min=index_min+1

current_char=line[index_max]
while current_char.isalnum() or current_char in {'_', '-'}:
    if index_max < len(line)-1:
        index_max = index_max + 1
    else:
        index_max = len(line)
        break
    current_char = line[index_max]
index_max=index_max-1

line = line[:index_min] + '"' + line[index_min:index_max+1] + '"' + line[index_max+1:]
buf[line_number-1] = line
EOF

endfunction
