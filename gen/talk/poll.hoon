::  Set up a poll
::
::::  /hoon/poll/talk/gen
  ::
/?    310
/-    talk, sole
::
::::
  !:
[. talk sole]
:-  %ask
|=  {{now/@da eny/@uvJ bec/beak} $~ $~}
^-  (sole-result (cask poll-action))
::
::  can't do this here:
::  %-  sole-so
::  :-  %talk-poll-action
|-
%+  sole-yo  leaf+"Welcome to the poll management wizard!"
%+  sole-yo  leaf+"Do you want to 'make', 'edit', or 'show' a poll?"
%+  sole-lo  [& %$ "poll action: "]
|=  act/tape
?:  =(act "make")
  ::
  %+  sole-yo  leaf+"What is the poll question?"
  %+  sole-lo  [& %$ "poll question: "]
  |=  question/tape
  %+  sole-yo  leaf+"> {question}"
  ::
  %+  sole-yo  leaf+"What are the answers? End with an empty line."
  =|  answers/(list cord)
  |-  ^-  (sole-result (cask poll-action))
  %+  sole-lo  [& %$ "poll answer: "]
  |=  answer/tape
  ?.  =(answer "")
    %+  sole-yo  leaf+:(weld (scow %ud (lent answers)) ") " answer)
    ^$(answers [(crip answer) answers])
  ::
  %+  sole-yo  leaf+"Max allowed votes pp? (default 1)"
  %+  sole-lo  [& %$ "max votes: "]
  %+  sole-go  ;~(pose dem:ag (easy 1))
  |=  votes/@ud
  =.  votes  (max 1 (min votes (lent answers)))
  %+  sole-yo  leaf+"> {(scow %ud votes)}"
  ::
  %+  sole-yo  leaf+"Allow vote editing? (y/n, default n)"
  %+  sole-lo  [& %$ "vote editing: "]
  %+  sole-go  ;~  pose
                 (cold | (just 'n'))
                 (cold & (just 'y'))
                 (easy |)
               ==
  |=  edit/?
  %+  sole-yo  leaf+"> {(trip ?:(edit '' 'dis'))}allow vote editing"
  ::
  %+  sole-yo  leaf+"Poll duration? (relative time, default forever)"
  %+  sole-lo  [& %$ "poll duration: "]
  ::TODO  Parse "5 days, 12 hours, 4 seconds" and sum them up.
  %+  sole-go  ;~  pose  ::TODO  talk's ++dare
                 %+  cook  some
                 %+  sear
                   |=  d/dime  ^-  (unit @dr)
                   ?:  =(p.d ~.dr)  `q.d  ~
                 crub:so
                 (easy ~)
               ==
  |=  duration/(unit @dr)
  =/  close/(unit @da)
    ?~  duration  ~
    `(add now u.duration)
  %+  sole-yo  :-  %leaf
               %+  weld  "> poll closes "
               ?~  close  "never"
               (scow %da u.close)
  ::
  %+  sole-yo  leaf+"Display results before closing date? (y/n, default y)"
  %+  sole-lo  [& %$ "transparency: "]
  %+  sole-go  ;~  pose
                 (cold | (just 'n'))
                 (cold & (just 'y'))
                 (easy &)
               ==
  |=  clear/?
  %+  sole-yo  leaf+"> {(trip ?:(clear '' 'no '))}results before poll closes"
  ::
  %+  sole-yo  leaf+"Immediately send the poll to a station? (station, default none)"
  %+  sole-lo  [& %$ "station: "]
  %+  sole-go  ;~  pose  ::TODO  talk's ++stan
                 %+  cook  some
                 ;~(plug ;~(pfix sig fed:ag) ;~(pfix fas sym))
                 (easy ~)
               ==
  |=  send/(unit station)
  %+  sole-yo  :-  %leaf
               %+  weld  "> "
               ?~  send  "not sending poll"
               ;:  weld  "sending poll to "
                 (scow %p p.u.send)
                 "/"
                 (trip q.u.send)
               ==
  ::
  %+  sole-so  %talk-poll-action
  :-  %make
  :_  send
  [(crip question) (flop answers) ~ [votes edit close clear]]
::
?:  =(act "edit")
  ::
  %+  sole-yo  leaf+"Which poll do you want to edit?"
  %+  sole-lo  [& %$ "poll id: "]
  %+  sole-go  dem:ag
  |=  id/@ud
  %+  sole-yo  leaf+"> editing poll {(scow %ud id)}"
  ::
  ::TODO  do better than just copy-pasting!
  %+  sole-yo  leaf+"Allow vote editing? (y/n, default n)"
  %+  sole-lo  [& %$ "vote editing: "]
  %+  sole-go  ;~  pose
                 (cold | (just 'n'))
                 (cold & (just 'y'))
                 (easy |)
               ==
  |=  edit/?
  %+  sole-yo  leaf+"> {(trip ?:(edit '' 'dis'))}allow vote editing"
  ::
  %+  sole-yo  leaf+"Poll duration? (relative time, default forever)"
  %+  sole-lo  [& %$ "poll duration: "]
  %+  sole-go  ;~  pose  ::TODO  talk's ++dare
                 %+  cook  some
                 %+  sear
                   |=  d/dime  ^-  (unit @dr)
                   ?:  =(p.d ~.dr)  `q.d  ~
                 crub:so
                 (easy ~)
               ==
  |=  duration/(unit @dr)
  =/  close/(unit @da)
    ?~  duration  ~
    `(add now u.duration)
  %+  sole-yo  :-  %leaf
               %+  weld  "> poll closes "
               ?~  close  "never"
               (scow %da u.close)
  ::
  %+  sole-yo  leaf+"Display results before closing date? (y/n, default y)"
  %+  sole-lo  [& %$ "transparency: "]
  %+  sole-go  ;~  pose
                 (cold | (just 'n'))
                 (cold & (just 'y'))
                 (easy &)
               ==
  |=  clear/?
  %+  sole-yo  leaf+"> {(trip ?:(clear '' 'no '))}results before poll closes"
  ::
  %+  sole-yo  leaf+"Immediately send the poll to a station? (station, default none)"
  %+  sole-lo  [& %$ "station: "]
  %+  sole-go  ;~  pose  ::TODO  talk's ++stan
                 %+  cook  some
                 ;~(plug ;~(pfix sig fed:ag) ;~(pfix fas sym))
                 (easy ~)
               ==
  |=  send/(unit station)
  %+  sole-yo  :-  %leaf
               %+  weld  "> "
               ?~  send  "not sending poll"
               ;:  weld  "sending poll to "
                 (scow %p p.u.send)
                 "/"
                 (trip q.u.send)
               ==
  ::
  %-  sole-so
  :-  %talk-poll-action
  :-  %edit
  [id [0 edit close clear] send]
?:  =(act "show")  ::TODO  Delet this! Just do this in talk, ;poll 123
  ::TODO  Do better than just copy-pasting!
  %+  sole-yo  leaf+"Which poll do you want to send?"
  %+  sole-lo  [& %$ "poll id: "]
  %+  sole-go  dem:ag
  |=  id/@ud
  ::
  %+  sole-yo  leaf+"What station do you want to send poll {(scow %ud id)} to?"
  %+  sole-lo  [& %$ "station: "]
  %+  sole-go  ;~(plug ;~(pfix sig fed:ag) ;~(pfix fas sym))  ::TODO  talk's ++stan
  |=  stat/station
  %-  sole-so
  :-  %talk-poll-action
  :-  %show
  [id stat]
?:  =(act "test")
  %-  sole-so
  :-  %talk-poll-action
  [%test ~]
%+  sole-yo  leaf+"Invalid action."
^$
