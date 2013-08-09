let s:save_cpo = &cpo
set cpo&vim

let s:source = {
\ 'name' : 'simplenote',
\ 'default_action' : 'edit',
\ 'description' : 'candidates for simplenote',
\ }

function! unite#sources#simplenote#define()
  return s:source
endfunction

function! s:source.gather_candidates(args, context)
  let candidates = metarw#sn#complete('', '', '')
  return map(len(candidates) > 0 ? candidates[0] : [], "{
  \ 'word': s:create_description(),
  \ 'kind': 'command', 'action__command': printf('Edit sn:%s\n', candidates.key),
  \}")
endfunction

function! s:create_description(candidate)
  return candidate.modifydate . ':' . candidate.tags . ':' . candidate.title
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
