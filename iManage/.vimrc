" Here is a basic vimrc. Typically, you place this in your home directory
" and call it .vimrc (i.e. "mv basic_vimrc ~/.vimrc" should do this for
" you). Next time you open vim, all settings will be applied, and your
" life will be a bit better. I'll make comments along the way, so you can know
" what's what.
"
" If you want to learn more about any option, try ":help <command>"
" Once you open one of those windows, your control will be in the information
" pane, feel free to just ":q" to close it.


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" (Vim = Vi iMproved, Vi is an oooooooold text editor, like sed)
set nocompatible

" Turn on some of the filetype magic, see ":help filetype" and
" scroll down to ":help filetype-overview"
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" This makes backspace work as expected
set backspace=indent,eol,start

" Don't create backups of files that you are currently editing. I would
" recommend, otherwise you get weird extra files all over. But this is
" up to you.
set nobackup

" This turn on a "line, column" indicator in the bottom right.
set ruler

" This displays parts of commands typed so far. If you were to type "d" in
" normal mode, it would show up somehwere along the bottom because it awaits
" some sort of directional command. That is, "de" Deletes to the End of the
" word. When you type the "e", the "d" would disappear.
set showcmd

" If you try to search for something by typing "/search_word", incsearch will
" highlight as you start typing. With it off, no results are show until you
" hit enter.
set incsearch

" How big a tab should be. Some people like 3, some 4. This is emacs/vim level
" religious wars.
set tabstop=4

" Both of these make tabs work a little better. Kinda hard to explain.
set shiftwidth=4
set softtabstop=4

" First tab under an indented line will indent to match the line above.
set smarttab

" All tabs become actual spaces. Cuz tabs suck.
set expandtab

" Try to be smart about indents when starting new lines. Like match the one
" above it, and indent if the previous line ended with "{".
set smartindent
