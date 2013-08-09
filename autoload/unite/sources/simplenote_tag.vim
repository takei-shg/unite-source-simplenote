let s:save_cpo = &cpo
set cpo&vim

let s:source = {
\ 'name' : 'simplenote_tag',
\ 'default_action' : 'edit',
\ 'description' : 'show & editing simplenote tags',
\ }

function! unite#sources#simplenote_tag#define()
  return s:source
endfunction

function! s:source.gather_candidates(args, context)
  let candidates = metarw#sn_tag#complete('', '', '')
  " candidate = [ {fakepath} , {sn:} , {} ]
  return map(len(candidates) > 0 ? candidates[0] : [], "{
  \ 'word': v:val, 'addr': v:val, 'action__path': v:val,
  \ 'kind': 'command', 'action__command': printf('Edit sn_tag:%s\n', s:parse_note_key(v:val)),
  \}")
endfunction

function! s:parse_note_key(fakepath)
  " FIXME: cannot use : for file name.
  let tokens = split(a:fakepath, ':')
  " tokens = [ sn: , {filename} , {note_key} ]
  return tokens[2]
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
