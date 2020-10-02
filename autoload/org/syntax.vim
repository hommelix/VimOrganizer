
function! org#syntax#TodoSyntax(donespec, notdonespec)
"    syntax clear DONETODO
"    syntax clear NOTDONETODO
    exec "syntax match DONETODO '" . a:donespec . "' containedin=OL1,OL2,OL3,OL4,OL5,OL6"
    exec "syntax match NOTDONETODO '" . a:notdonespec . "' containedin=OL1,OL2,OL3,OL4,OL5,OL6"
endfunction

function! org#syntax#OrgCustomTodoHighlights()
    if !exists('g:org_todo_custom_highlights')
        return
    endif
    for item in keys(g:org_todo_custom_highlights)
        let d = g:org_todo_custom_highlights
        if has('gui_running')
            let fg = get(d[item], 'guifg')
            let bg = get(d[item], 'guibg')
            exec 'hi! ' . item . ((fg>#'')  ? ' guifg=' . fg : '') . ((bg>#'') ? ' guibg=' . bg : '')
        else
            let fg = get(d[item], 'ctermfg')
            let bg = get(d[item], 'ctermfg')
            exec 'hi! ' . item . ((fg>#'')  ? ' ctermfg=' . fg : '') . ((bg>#'') ? ' ctermbg=' . bg : '')
        endif

        " xxxx todo put back in containedins, do synclears? check order?
        if bufname('%')=='__Agenda__'
            exec 'syntax match ' . item . ' ' .  '+ \*\+ \zs' . item . ' + containedin=AOL1,AOL2,AOL3,AOL4,AOL5,AOL6' 
        else
            " delete current match if it already exists
            let mymatches = getmatches()
            let tempdict = {}
            for i in range(0, len(mymatches)-1)
                let tempdict[i] = mymatches[i]
            endfor
            for i in keys(tempdict)
                if tempdict[i].group == item
                    exec 'syntax clear ' . tempdict[i].group
                    break
                endif
            endfor
            "now put new match in
            exec 'syntax match ' . item . ' ' .  '+\*\+ \zs' . item . ' + containedin=OL1,OL2,OL3,OL4,OL5,OL6' 
        endif
        
    endfor
endfunction
