globals [
       ;; monitors
          deaths
          births
       ;; Mortality rates per Step
          step_mortality_FP_juveniles
          step_mortality_FP_oneyear
          step_mortality_FP_twoyear
          step_mortality_FP_adults
          step_mortality_P_juveniles
          step_mortality_P_oneyear
          step_mortality_P_twoyear
          step_mortality_P_adults
       ;; Years for supplements
          supple_year
       ;; Scenario names
          scenario]

turtles-own [age raising]

;;
;; SETUP Procedures
;;

to setup
   clear-all                                  ; clear everything (Monitors, Plot, World) before you start a new simulation

;; create the population
 ; create juvenile NBI
   create-turtles Number_FP_Juveniles            ; create Turtles/Agents
     [
       setxy random-pxcor random-pycor        ; with random xy coordinates
       set heading random 360                 ; random direction
       set age 0                              ; set Age to 0
       set raising "FP"
       set shape "nbi"                        ; change the shape to nbi
       set size 1.5                           ; change the size of the turtles
       set color turquoise
     ]

     create-turtles Number_P_Juveniles            ; create Turtles/Agents
     [
       setxy random-pxcor random-pycor        ; with random xy coordinates
       set heading random 360                 ; random direction
       set age 0                              ; set Age to 0
       set raising "P"
       set shape "nbi"                        ; change the shape to nbi
       set size 1.5                           ; change the size of the turtles
       set color lime + 2
     ]




 ; create 1-Year-Old NBI
   create-turtles Number_FP_Subadults_Age1
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 1
       set raising "FP"
       set shape "nbi"
       set size 1.5
       set color turquoise
     ]

  create-turtles Number_P_Subadults_Age1
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 1
       set raising "P"
       set shape "nbi"
       set size 1.5
       set color lime + 2
     ]


 ; create 2-Year-Old NBI
   create-turtles Number_FP_Subadults_Age2
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 2
       set raising "FP"
       set shape "nbi"
       set size 1.5
       set color turquoise
     ]

  create-turtles Number_P_Subadults_Age2
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 2
       set raising "P"
       set shape "nbi"
       set size 1.5
       set color lime + 2
     ]


 ; create adult NBI
   create-turtles Number_FP_Adults
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 3
       set raising "FP"
       set shape "nbi"
       set size 1.5
       set color turquoise
     ]

  create-turtles Number_P_Adults
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 3
       set raising "P"
       set shape "nbi"
       set size 1.5
       set color lime + 2
     ]


;; reset monitors and ticks
   set deaths 0                              ; set deaths (Monitor) to 0
   set births 0                              ; set births (Monitor) to 0
   reset-ticks                               ; set ticks to 0
;; add supplements if the switch is "On"
;   supplement
end

;;
;; GO Procedures
;;

to go
   breeding
   supplement
   death_FP_juveniles
   death_FP_one_year_olds
   death_FP_two_year_olds
   death_FP_adults
   death_P_juveniles
   death_P_one_year_olds
   death_P_two_year_olds
   death_P_adults
   aging
   tick
end

;; Breeding with Fecundity
to breeding
   if Fecundity < 1                                             ; if the fecundity is smaller than 1
     [
       ask turtles with [age >= 3]                              ; ask turtles with age 3 or more
         [
           if random-float 1 < Fecundity                        ; test if the random number is smaller stan step fecundity
             [                                                  ; if it is, then
               hatch 1                                          ; hatch 1 chick (turtle)
                 [                                              ; this chick has the following properties
                   set births births + 1                        ; increase the births (Monitor) by 1 per new turtle
                   setxy random-pxcor random-pycor              ; with random xy coordinates
                   set heading random 360                       ; with random direction
                   set age 0                                   ; set age to -1, because these chicks age in the same tick again, but that should not be, only in the next step
                   set raising "P"                              ; set the raising type to "P" because their parents are birds of the population
                   set label ""                                 ; they are not supplemented, so they need no label
                   set color lime + 2
                 ]

            ;; testing birth procedure
             ; print "I gave birth"
             ]
         ]
     ]


   if (Fecundity >= 1) and (Fecundity < 2)                      ; if the fecundity is at least 1 and smaller than 2
     [
       ask turtles with[age >= 3]
         [
           ifelse random-float 1 + 1 < Fecundity                ; increase the random number by 1 because the fecundity is higher
             [ ;if
               hatch 2                                          ; hatch 2 chicks (turtles)
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                   set color lime + 2
                   ;print "I hatch 2"
                 ]
             ]
             [ ;else
               hatch 1
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                   set color lime + 2
                 ]
             ]
         ]
     ]


   if Fecundity >= 3
     [
       ask turtles with[age >= 3]
         [
           ifelse random-float 1 + 3 < Fecundity
             [ ; if
               print "I hatch 4"
               hatch 4
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                   set color lime + 2
                 ]
             ]
             [ ; else
               hatch 3
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                   set color lime + 2
                 ]
             ]
         ]
     ]
end

to supplement
   if Supplements? = true                                      ; test if the switch "Supplements?" is "On"
     [                                                         ; if it is, then ...
       set supple_year 0                                       ; set the year for supplements to 0
       if ticks < Supplement_Time - 1                      ; as long as the ticks are smaller than the Supplement time do the following:
         [
           create-turtles Number_FP_Supplements                   ; create as many turtles as defined with the Number_Supplements-Slider
             [
               setxy random-pxcor random-pycor
               set heading random 360
               set age 0
               set raising "FP"
               set shape "nbi"
               set size 1.5
               set label "S_FP"
               set color turquoise
               set supple_year supple_year + 1
             ]
          create-turtles Number_P_Supplements                   ; create as many turtles as defined with the Number_Supplements-Slider
             [
               setxy random-pxcor random-pycor
               set heading random 360
               set age 0
               set raising "P"
               set shape "nbi"
               set size 1.5
               set label "S_P"
               set color lime + 2
               set supple_year supple_year + 1
             ]
;          ask n-of 10 turtles with [colony = 0 and age = 0] [set colony "Burghausen" set color green]
;          ask n-of 10 turtles with [colony = 0 and age = 0] [set colony "Kuchl"      set color yellow]
;          ask n-of 10 turtles with [colony = 0 and age = 0] [set colony "Ueberlingen" set color blue]

         ]
     ]
end

to death_FP_juveniles                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age = 0)  and (raising = "FP")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_FP_juveniles random-normal Mortality_FP_Juveniles 0.38                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_FP_juveniles > Mortality_FP_Juveniles - 0.38 and step_mortality_FP_juveniles < Mortality_FP_Juveniles + 0.38 and step_mortality_FP_juveniles > 0 and step_mortality_FP_juveniles < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_FP_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_FP_juveniles      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end

to death_P_juveniles                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age = 0)  and (raising = "P")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_P_juveniles random-normal Mortality_P_Juveniles 0.32                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_P_juveniles > Mortality_P_Juveniles - 0.32 and step_mortality_P_juveniles < Mortality_P_Juveniles + 0.32 and step_mortality_P_juveniles > 0 and step_mortality_P_juveniles < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_P_juveniles      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end

to death_FP_one_year_olds                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age = 1)  and (raising = "FP")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_FP_oneyear random-normal Mortality_FP_Subadults_Age1 0.36                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_FP_oneyear > Mortality_FP_Subadults_Age1 - 0.36 and step_mortality_FP_oneyear < Mortality_FP_Subadults_Age1 + 0.36 and step_mortality_FP_oneyear > 0 and step_mortality_FP_oneyear < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_FP_oneyear      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end

to death_P_one_year_olds                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age = 1)  and (raising = "P")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_P_oneyear random-normal Mortality_P_Subadults_Age1 0.36                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_P_oneyear > Mortality_P_Subadults_Age1 - 0.36 and step_mortality_P_oneyear < Mortality_P_Subadults_Age1 + 0.36 and step_mortality_P_oneyear > 0 and step_mortality_P_oneyear < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_P_oneyear      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end

to death_FP_two_year_olds                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age = 2)  and (raising = "FP")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_FP_twoyear random-normal Mortality_FP_Subadults_Age2 0.33                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_FP_twoyear > Mortality_FP_Subadults_Age2 - 0.33 and step_mortality_FP_twoyear < Mortality_FP_Subadults_Age2 + 0.33 and step_mortality_FP_twoyear > 0 and step_mortality_FP_twoyear < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_FP_twoyear      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end

to death_P_two_year_olds                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age = 2)  and (raising = "P")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_P_twoyear random-normal Mortality_P_Subadults_Age2 0.36                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_P_twoyear > Mortality_P_Subadults_Age2 - 0.36 and step_mortality_P_twoyear < Mortality_P_Subadults_Age2 + 0.36 and step_mortality_P_twoyear > 0 and step_mortality_P_twoyear < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_P_twoyear      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end

to death_FP_adults                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age >= 3)  and (raising = "FP")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_FP_adults random-normal Mortality_FP_Adults 0.20                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_FP_adults > Mortality_FP_Adults - 0.20 and step_mortality_FP_adults < Mortality_FP_Adults + 0.20 and step_mortality_FP_adults > 0 and step_mortality_FP_adults < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_FP_adults      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end

to death_P_adults                                             ; death probabilities per step for stage 1, the juveniles
   ask turtles with [(age >= 3)  and (raising = "P")]                                ; death probabilities per step for stage 1, the juveniles
     [
       let kk 0                                                ; this is a random number for the while loop
      ;print kk
       while [kk = 0]                                          ; while kk is 0
         [                                                     ; do that
           set step_mortality_P_adults random-normal Mortality_P_Adults 0.20                      ; set step_mortality_juveniles to a random number between the Mortality probability for Juveniles +- 1 SD
           if step_mortality_P_adults > Mortality_P_Adults - 0.20 and step_mortality_P_adults < Mortality_P_Adults + 0.20 and step_mortality_P_adults > 0 and step_mortality_P_adults < 1
           ; if it is between the range of 1 SD and is not lower than 0 or higher than 1 go ahead otherwise start the loop again
             [
              ;print step_mortality_juveniles
               set kk 1                                          ; set the random variable to 1 so the while loop will not start again
              ;print kk
               if random-float 1 < step_mortality_P_adults      ; test if the random number is smaller than the mortality probability for the time step
                 [                                               ; if it is, then
                   set deaths deaths + 1                         ; increase Deaths (Monitor) by 1 per death individual
                  ;print "Juvenile dies"                         ; print "Juvenile dies"
                   die                                           ; die
                 ]
             ]
         ]
     ]
end


to aging
   ask turtles                                                 ; ask every turtle
     [
       set age age + 1                                         ; increase age by 1
       forward 0.3                                             ; move by 0.3 patches forward
       if age > 25                                             ; if a turtle is older than 25
         [
           set deaths deaths + 1                               ; increase deaths (Monitor) by 1
           print "I am old"                                    ; print "I am old"
           die                                                 ; die
         ]
     ]
end

;;
;; SUPPLEMENT Procedure
;;
@#$#@#$#@
GRAPHICS-WINDOW
436
10
873
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
1
1
1
Years
30.0

BUTTON
11
14
74
47
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
16
485
190
518
Fecundity
Fecundity
0
4
1.3
0.01
1
NIL
HORIZONTAL

SLIDER
216
93
410
126
Mortality_FP_Juveniles
Mortality_FP_Juveniles
0
1
0.31
0.01
1
NIL
HORIZONTAL

SLIDER
216
126
410
159
Mortality_FP_Subadults_Age1
Mortality_FP_Subadults_Age1
0
1
0.29
0.01
1
NIL
HORIZONTAL

SLIDER
216
159
410
192
Mortality_FP_Subadults_Age2
Mortality_FP_Subadults_Age2
0
1
0.32
0.01
1
NIL
HORIZONTAL

SLIDER
216
192
410
225
Mortality_FP_Adults
Mortality_FP_Adults
0
1
0.28
0.01
1
NIL
HORIZONTAL

PLOT
919
127
1345
408
Population size
Year
N
0.0
10.0
0.0
100.0
true
true
"" ""
PENS
"Population size" 1.0 0 -16777216 true "" "plot count turtles"
"FP" 1.0 0 -14835848 true "" "plot count turtles with [raising = \"FP\"]"
"P" 1.0 0 -8330359 true "" "plot count turtles with [raising = \"P\"]"

MONITOR
920
13
992
58
Individuals
count turtles
17
1
11

MONITOR
1115
13
1172
58
Births
births
17
1
11

MONITOR
1179
13
1236
58
Deaths
deaths
17
1
11

SLIDER
16
93
193
126
Number_FP_Juveniles
Number_FP_Juveniles
0
100
13.0
1
1
NIL
HORIZONTAL

SLIDER
16
126
193
159
Number_FP_Subadults_Age1
Number_FP_Subadults_Age1
0
100
6.0
1
1
NIL
HORIZONTAL

SLIDER
16
159
193
192
Number_FP_Subadults_Age2
Number_FP_Subadults_Age2
0
100
5.0
1
1
NIL
HORIZONTAL

SLIDER
16
192
193
225
Number_FP_Adults
Number_FP_Adults
0
100
10.0
1
1
NIL
HORIZONTAL

BUTTON
91
14
154
47
step
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
165
14
228
47
run
while [any? turtles and ticks < 10][ go ]\n;go\n;while [ticks < 50][ go ]\n;while [ any? turtles ] [ go ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

SWITCH
19
605
183
638
Supplements?
Supplements?
0
1
-1000

SLIDER
19
638
183
671
Number_FP_Supplements
Number_FP_Supplements
0
50
15.0
1
1
NIL
HORIZONTAL

MONITOR
1004
13
1109
58
Number Juveniles
count turtles with [age = 0]
17
1
11

MONITOR
919
68
992
113
FP
count turtles with [raising = \"FP\"]
17
1
11

MONITOR
1006
67
1063
112
P
count turtles with [raising = \"P\"]
17
1
11

MONITOR
1209
70
1343
115
Supplements per Year
supple_year
17
1
11

TEXTBOX
36
64
199
98
Number of FP Individuals
14
0.0
1

TEXTBOX
269
64
412
98
Mortality FP Individuals
14
0.0
1

TEXTBOX
70
459
134
477
Fecundity
14
0.0
1

TEXTBOX
25
577
176
611
Supplements FP chicks
14
0.0
1

SLIDER
19
703
183
736
Supplement_Time
Supplement_Time
0
10
8.0
1
1
NIL
HORIZONTAL

SLIDER
18
290
188
323
Number_P_juveniles
Number_P_juveniles
0
100
10.0
1
1
NIL
HORIZONTAL

SLIDER
18
323
188
356
Number_P_Subadults_Age1
Number_P_Subadults_Age1
0
100
4.0
1
1
NIL
HORIZONTAL

SLIDER
18
356
188
389
Number_P_Subadults_Age2
Number_P_Subadults_Age2
0
100
0.0
1
1
NIL
HORIZONTAL

SLIDER
18
388
188
421
Number_P_Adults
Number_P_Adults
0
100
5.0
1
1
NIL
HORIZONTAL

SLIDER
19
671
183
704
Number_P_Supplements
Number_P_Supplements
0
50
14.0
1
1
NIL
HORIZONTAL

TEXTBOX
37
269
187
287
Number of P Individuals
14
0.0
1

TEXTBOX
237
267
387
285
Mortality P individuals
14
0.0
1

SLIDER
220
291
409
324
Mortality_P_juveniles
Mortality_P_juveniles
0
1.00
0.53
0.01
1
NIL
HORIZONTAL

SLIDER
220
324
409
357
Mortality_P_Subadults_Age1
Mortality_P_Subadults_Age1
0
1.00
0.26
0.01
1
NIL
HORIZONTAL

SLIDER
220
357
409
390
Mortality_P_Subadults_Age2
Mortality_P_Subadults_Age2
0
1.00
0.2
0.01
1
NIL
HORIZONTAL

SLIDER
220
390
409
423
Mortality_P_Adults
Mortality_P_Adults
0
1.00
0.16
0.01
1
NIL
HORIZONTAL

MONITOR
1419
30
1674
75
FP Juveniles
count turtles with [(age = 0)  and (raising = \"FP\")]
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bird
false
0
Polygon -7500403 true true 135 165 90 270 120 300 180 300 210 270 165 165
Rectangle -7500403 true true 120 105 180 237
Polygon -7500403 true true 135 105 120 75 105 45 121 6 167 8 207 25 257 46 180 75 165 105
Circle -16777216 true false 128 21 42
Polygon -7500403 true true 163 116 194 92 212 86 230 86 250 90 265 98 279 111 290 126 296 143 298 158 298 166 296 183 286 204 272 219 259 227 235 240 241 223 250 207 251 192 245 180 232 168 216 162 200 162 186 166 175 173 171 180
Polygon -7500403 true true 137 116 106 92 88 86 70 86 50 90 35 98 21 111 10 126 4 143 2 158 2 166 4 183 14 204 28 219 41 227 65 240 59 223 50 207 49 192 55 180 68 168 84 162 100 162 114 166 125 173 129 180

bird side
false
0
Polygon -7500403 true true 0 120 45 90 75 90 105 120 150 120 240 135 285 120 285 135 300 150 240 150 195 165 255 195 210 195 150 210 90 195 60 180 45 135
Circle -16777216 true false 38 98 14

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

nbi
true
0
Polygon -7500403 true true 210 45 240 45 285 90 240 90 240 180 210 225 105 225 75 255 45 255 75 210 120 150 210 120 210 45
Rectangle -7500403 true true 165 210 195 285

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="MVP_good" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word "Good_" Supplements? Supplement_Time "_" Number_FP_Supplements Number_P_Supplements)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="Number_FP_Juveniles">
      <value value="13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age1">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age2">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Adults">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_juveniles">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age1">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age2">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Adults">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Juveniles">
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age1">
      <value value="0.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age2">
      <value value="0.32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Adults">
      <value value="0.28"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_juveniles">
      <value value="0.53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age1">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age2">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Adults">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Fecundity">
      <value value="1.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="5"/>
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Supplements">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Supplements">
      <value value="14"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MVP_conservative" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word "Conservative_" Supplements? Supplement_Time "_" Number_FP_Supplements Number_P_Supplements)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="Number_FP_Juveniles">
      <value value="13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age1">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age2">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Adults">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_juveniles">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age1">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age2">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Adults">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Juveniles">
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age1">
      <value value="0.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age2">
      <value value="0.32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Adults">
      <value value="0.28"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_juveniles">
      <value value="0.53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age1">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age2">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Adults">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Fecundity">
      <value value="1.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="5"/>
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Supplements">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Supplements">
      <value value="10"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MVP_good_SD" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word "Good_" Supplements? Supplement_Time "_" Number_FP_Supplements Number_P_Supplements)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <metric>step_mortality_FP_juveniles</metric>
    <metric>step_mortality_FP_oneyear</metric>
    <metric>step_mortality_FP_twoyear</metric>
    <metric>step_mortality_FP_adults</metric>
    <metric>step_mortality_P_juveniles</metric>
    <metric>step_mortality_P_oneyear</metric>
    <metric>step_mortality_P_twoyear</metric>
    <metric>step_mortality_P_adults</metric>
    <enumeratedValueSet variable="Number_FP_Juveniles">
      <value value="13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age1">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age2">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Adults">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_juveniles">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age1">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age2">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Adults">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Juveniles">
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age1">
      <value value="0.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age2">
      <value value="0.32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Adults">
      <value value="0.28"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_juveniles">
      <value value="0.53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age1">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age2">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Adults">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Fecundity">
      <value value="1.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="5"/>
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Supplements">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Supplements">
      <value value="14"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MVP_conservative_SD" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word "Conservative_" Supplements? Supplement_Time "_" Number_FP_Supplements Number_P_Supplements)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <metric>step_mortality_FP_juveniles</metric>
    <metric>step_mortality_FP_oneyear</metric>
    <metric>step_mortality_FP_twoyear</metric>
    <metric>step_mortality_FP_adults</metric>
    <metric>step_mortality_P_juveniles</metric>
    <metric>step_mortality_P_oneyear</metric>
    <metric>step_mortality_P_twoyear</metric>
    <metric>step_mortality_P_adults</metric>
    <enumeratedValueSet variable="Number_FP_Juveniles">
      <value value="13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age1">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age2">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Adults">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_juveniles">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age1">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age2">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Adults">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Juveniles">
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age1">
      <value value="0.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age2">
      <value value="0.32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Adults">
      <value value="0.28"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_juveniles">
      <value value="0.53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age1">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age2">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Adults">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Fecundity">
      <value value="1.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="5"/>
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Supplements">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Supplements">
      <value value="10"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MVP_good_SD_8y" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word "Good_" Supplements? Supplement_Time "_" Number_FP_Supplements Number_P_Supplements)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <metric>step_mortality_FP_juveniles</metric>
    <metric>step_mortality_FP_oneyear</metric>
    <metric>step_mortality_FP_twoyear</metric>
    <metric>step_mortality_FP_adults</metric>
    <metric>step_mortality_P_juveniles</metric>
    <metric>step_mortality_P_oneyear</metric>
    <metric>step_mortality_P_twoyear</metric>
    <metric>step_mortality_P_adults</metric>
    <enumeratedValueSet variable="Number_FP_Juveniles">
      <value value="13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age1">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age2">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Adults">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_juveniles">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age1">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age2">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Adults">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Juveniles">
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age1">
      <value value="0.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age2">
      <value value="0.32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Adults">
      <value value="0.28"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_juveniles">
      <value value="0.53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age1">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age2">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Adults">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Fecundity">
      <value value="1.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Supplements">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Supplements">
      <value value="14"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="MVP_conservative_SD_8y" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word "Conservative_" Supplements? Supplement_Time "_" Number_FP_Supplements Number_P_Supplements)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <metric>step_mortality_FP_juveniles</metric>
    <metric>step_mortality_FP_oneyear</metric>
    <metric>step_mortality_FP_twoyear</metric>
    <metric>step_mortality_FP_adults</metric>
    <metric>step_mortality_P_juveniles</metric>
    <metric>step_mortality_P_oneyear</metric>
    <metric>step_mortality_P_twoyear</metric>
    <metric>step_mortality_P_adults</metric>
    <enumeratedValueSet variable="Number_FP_Juveniles">
      <value value="13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age1">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Subadults_Age2">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Adults">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_juveniles">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age1">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Subadults_Age2">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Adults">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Juveniles">
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age1">
      <value value="0.29"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Subadults_Age2">
      <value value="0.32"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_FP_Adults">
      <value value="0.28"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_juveniles">
      <value value="0.53"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age1">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Subadults_Age2">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_P_Adults">
      <value value="0.16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Fecundity">
      <value value="1.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_FP_Supplements">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_P_Supplements">
      <value value="10"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
