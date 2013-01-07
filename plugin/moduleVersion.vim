" Vim plugin to check up version of installed perl module.
" File: moduleVersion.vim
" Author: moznion (Taiki Kawakami) <moznion@gmail.com>
" Last Modified: 7 Jan 2013.
" License: MIT License


let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* ModuleVersion call ModuleVersion(<f-args>)

func! ModuleVersion(moduleName)
  let l:messagelines = split(system("perl -MV='" . a:moduleName . "'"), "\n")

  " Output the target module name
  echo l:messagelines[0]

  if s:DoesExist(l:messagelines[1]) == 0
    call s:NotExist(l:messagelines[1])
  else
    call s:Exists(l:messagelines[1:])
  endif
endf

" If module was installed then this function returns 1. Other case, returns 0.
func! s:DoesExist(message)
  if !match(a:message, ".*Not found")
    return 0
  endif
  return 1
endf

" Output messages for exists by decorate.
func! s:Exists(messages)
  echohl Function
  for msg in a:messages
    echo msg
  endfor
  echohl None
endf

" Output message for not exists by decorate.
func! s:NotExist(message)
  echohl ErrorMsg
  echo a:message
  echohl None
endf

let &cpo = s:save_cpo
unlet s:save_cpo
