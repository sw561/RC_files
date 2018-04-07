" Modify the definitions of diffOldFile and diffNewFile, since they seem to be
" wrong by default

syntax match diffOldFile "^--- .*"
syntax match diffNewFile "^+++ .*"
