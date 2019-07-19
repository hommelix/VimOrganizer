
function! org#syntax#TodoSyntax(donespec, notdonespec)
    syntax clear DONETODO
    syntax clear NOTDONETODO
    exec "syntax match DONETODO '" . a:donespec . "' containedin=OL1,OL2,OL3,OL4,OL5,OL6"
    exec "syntax match NOTDONETODO '" . a:notdonespec . "' containedin=OL1,OL2,OL3,OL4,OL5,OL6"
endfunction
