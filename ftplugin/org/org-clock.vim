" org-clock.vim - Clocking plugin for VimOrganizer
" ------------------------------------------------------------
" Version: 0.01
" Maintainer: Jerome Vandenabeele <hommelix+github@gmail.com>
" Last Change: 2021 May 04
"

" org-mode clock mapping
" ------------------------------------------------------------
onoremap it :<c-u> normal! 0f]hv3b<cr>
onoremap ot :<c-u> normal! 02f]hv3b<cr>

" org-mode clock functions
" ------------------------------------------------------------
if exists('g:org_clock_timestep')
    let s:timestep = g:org_clock_timestep
else
    let s:timestep = 1
endif
" Time() compute the actial time rounded to s:timestep
function OrgTime()
    let time = split(strftime("%H:%M"),":")
    let time[0] = time[0] / 1
    let time[1] = time[1] / 1
    let delta = time[1] - (time[1]/s:timestep)*s:timestep
    if ((delta+0.0)/(s:timestep+0.0) < 0.5)
        let minutes = (time[1]/s:timestep)*s:timestep
    else
        let minutes = (1+(time[1]/s:timestep))*s:timestep
    endif
    if minutes > 59
        let hours = time[0]+1
        let minutes = minutes-60
    else
        let hours = time[0]
    endif
    if minutes < 10
        let minutes = join(["0",minutes],"")
    endif
    if hours < 10
        let hours = join(["0",hours],"")
    endif
    return join([hours,":",minutes],"")
endfunction

" Weekday() return the current weekday in English independently of locale
function OrgWeekday()
    let week = {1:'Mon', 2:'Tue', 3:'Wed', 4:'Thu', 5:'Fri', 6:'Sat', 7:'Sun'}
    let wday = strftime("%u")
    return week[wday]
endfunction
