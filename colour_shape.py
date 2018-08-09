## needed:
    ## block name (single / mixed) = 0 / 1
    ## task type (colour / shape)
    ## colour
    ## shape
    ## trial type (switch / non-switch) 1 / 0
    ## answer (left / right)
    ## reaction time
    ## accuracy

## mogelijke combinaties:
    ## shape  - cirkel   - blauw
    ## colour - driehoek - geel 
    ## shape  - cirkel   - geel
    ## colour - driehoek - blauw
    ## shape  - driehoek - geel
    ## colour - cirkel   - blauw
    ## shape  - driehoek - blauw
    ## colour - cirkel   - geel
## -> 4x task + (2x shape 1 + 2x shape 2) + (1x colour 1 + 1x colour 2)

## shape - colour - mixed - colour - shape

############
## Import ##
############

from psychopy import core, visual, event

import random
import numpy as np
import random
import csv

import os
import platform 
import time

import pandas as pd

#########################
## Identification data ##
#########################

subject_id = 36

##############################
## Configuration parameters ##
##############################

my_window = visual.Window(fullscr = True, units = 'height', color = "white")

## set parameters for shape practice-block
TASKSHAPEPR = ["shape"]

SHAPES1SHAPETESTPR = ["circle", "triangle"]
SHAPES2SHAPETESTPR = ["triangle", "circle"]

COLOURS1SHAPETESTPR = ["blue", "yellow", "yellow", "blue"]
COLOURS2SHAPETESTPR = ["yellow", "blue", "blue", "yellow"]

## set parameters for shape test-block
TASKSHAPE = ["shape"]

SHAPES1SHAPETEST = ["circle", "triangle"]
SHAPES2SHAPETEST = ["triangle", "circle"]

COLOURS1SHAPETEST = ["blue", "yellow", "yellow", "blue"]
COLOURS2SHAPETEST = ["yellow", "blue", "blue", "yellow"]

## set parameters for colour practice-block
TASKCOLOURPR = ["colour"]

SHAPES1COLOURTESTPR = ["circle", "triangle"]
SHAPES2COLOURTESTPR = ["triangle", "circle"]

COLOURS1COLOURTESTPR = ["blue", "yellow", "yellow", "blue"]
COLOURS2COLOURTESTPR = ["yellow", "blue", "blue", "yellow"]

## set parameters for colour test-block
TASKCOLOUR = ["colour"]

SHAPES1COLOURTEST = ["circle", "triangle"]
SHAPES2COLOURTEST = ["triangle", "circle"]

COLOURS1COLOURTEST = ["blue", "yellow", "yellow", "blue"]
COLOURS2COLOURTEST = ["yellow", "blue", "blue", "yellow"]

## set parameters for mixed practice-block
TASKSPR = ["shape","colour"]

SHAPES1PR = ["circle", "triangle"]
SHAPES2PR = ["triangle", "circle"]

COLOURS1PR = ["blue", "yellow", "yellow", "blue"]
COLOURS2PR = ["yellow", "blue", "blue", "yellow"]

## set parameters for mixed test-block
TASKS = ["shape","colour"]

SHAPES1 = ["circle", "triangle"]
SHAPES2 = ["triangle", "circle"]

COLOURS1 = ["blue", "yellow", "yellow", "blue"]
COLOURS2 = ["yellow", "blue", "blue", "yellow"]

## set parameters for shape test-block 2
TASKSHAPE2 = ["shape"]

SHAPES1SHAPETEST2 = ["circle", "triangle"]
SHAPES2SHAPETEST2 = ["triangle", "circle"]

COLOURS1SHAPETEST2 = ["blue", "yellow", "yellow", "blue"]
COLOURS2SHAPETEST2 = ["yellow", "blue", "blue", "yellow"]

## set parameters for colour test-block 2
TASKCOLOUR2 = ["colour"]

SHAPES1COLOURTEST2 = ["circle", "triangle"]
SHAPES2COLOURTEST2 = ["triangle", "circle"]

COLOURS1COLOURTEST2 = ["blue", "yellow", "yellow", "blue"]
COLOURS2COLOURTEST2 = ["yellow", "blue", "blue", "yellow"]

## other parameters
fixation_cross = "+"
fixation = visual.TextStim(my_window, text=fixation_cross,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

cueshape = "VORM"
cue_shape = visual.TextStim(my_window, text=cueshape,units='norm',height=0.07, color='Black',pos=[0,0.6], alignHoriz='center',flipHoriz=False)

cuecolour = "KLEUR"
cue_colour = visual.TextStim(my_window, text=cuecolour,units='norm',height=0.07, color='Black',pos=[0,0.6], alignHoriz='center',flipHoriz=False)

welcome_1_text = "Welkom bij dit experiment."
welcome1 = visual.TextStim(my_window, text=welcome_1_text,units='norm',height=0.07, color='Black',pos=[0,0.4], alignHoriz='center',flipHoriz=False)

welcome_2_text = "Jullie zullen gele en blauwe cirkels en driehoeken zien."
welcome2 = visual.TextStim(my_window, text=welcome_2_text,units='norm',height=0.07, color= 'Black',pos=[0,0.2], alignHoriz='center',flipHoriz=False)

welcome_3_text = "Jullie zullen soms moeten reageren op de vorm van de objecten, soms op de kleur ervan."
welcome3 = visual.TextStim(my_window, text=welcome_3_text,units='norm',height=0.07, color= 'Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

welcome_4_text = "Als jullie moeten reageren op VORM wordt dit aangegeven door het woord 'VORM' aan het begin van de trial."
welcome4 = visual.TextStim(my_window, text=welcome_4_text,units='norm',height=0.07, color= 'Black',pos=[0,-0.25], alignHoriz='center',flipHoriz=False)

welcome_5_text = "Als jullie moeten reageren op KLEUR wordt dit aangegeven door het woord 'KLEUR' aan het begin van de trial."
welcome5 = visual.TextStim(my_window, text=welcome_5_text,units='norm',height=0.07, color= 'Black',pos=[0,-0.50], alignHoriz='center',flipHoriz=False)

## reageren met wijsvinger bij cirkel & blauw
## reageren met middelvingen bij driehoek & geel
## even subjecten: rechtse hand voor vorm, linkse hand voor kleur
## oneven subjecten: linkse hand voor vorm, rechtse hand voor kleur
if subject_id%2 == 0:
    part_1_text = "Reageer met de RECHTSE hand voor VORM. Reageer met de LINKSE hand voor KLEUR. "
    instructions1 = visual.TextStim(my_window, text=part_1_text,units='norm',height=0.07, color='Black',pos=[0,0.25], alignHoriz='center',flipHoriz=False)
    
    part_2_text = "Reageer met je WIJSVINGER voor een CIRKEL (rechtse wijsvinger) en voor BLAUW (linkse wijsvinger)."
    instructions2 = visual.TextStim(my_window, text=part_2_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
    
    part_3_text = "Reageer met je MIDDELVINGER voor een DRIEHOEK (rechtse middelvinger) en voor GEEL (linkse middelvinger)."
    instructions3 = visual.TextStim(my_window, text=part_3_text,units='norm',height=0.07, color='Black',pos=[0,-0.25], alignHoriz='center',flipHoriz=False)
else:
    part_1_text = "Reageer met de LINKSE hand voor VORM. Reageer met de RECHTSE hand voor KLEUR. "
    instructions1 = visual.TextStim(my_window, text=part_1_text,units='norm',height=0.07, color='Black',pos=[0,0.35], alignHoriz='center',flipHoriz=False)
    
    part_2_text = "Reageer met je WIJSVINGER voor een CIRKEL (linkse wijsvinger) en voor BLAUW (rechtse wijsvinger)."
    instructions2 = visual.TextStim(my_window, text=part_2_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
    
    part_3_text = "Reageer met je MIDDELVINGER voor een DRIEHOEK (linkse middelvinger) en voor GEEL (rechtse middelvinger)."
    instructions3 = visual.TextStim(my_window, text=part_3_text,units='norm',height=0.07, color='Black',pos=[0,-0.35], alignHoriz='center',flipHoriz=False)    

pause_text = "Pauze. \n \nDruk op spatie om verder te gaan met het experiment."
pause1 = visual.TextStim(my_window, text=pause_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

tooslow_text = "Te traag"
tooslow = visual.TextStim(my_window, text=tooslow_text,units='norm',height=0.07, color='Red',pos=[0,0], alignHoriz='center',flipHoriz=False)

practice_text = "Het oefenblok is gedaan. \n \nNu begint het testblok"
practice = visual.TextStim(my_window, text=practice_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

block_text = 'Dit blok is afgelopen. \n \nDruk op spatie om verder te gaan met het volgende.'
EndBlock = visual.TextStim(my_window, text=block_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

EndInstr1 = 'Dit experiment is afgelopen is afgelopen. \n \nBedankt voor je deelname. \n \nDruk op spatie om af te sluiten.'
EndInstruction1 = visual.TextStim(my_window, text=EndInstr1,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

time1 = '1'
time2 = '2'
time3 = '3'

timing1 = visual.TextStim(my_window, text=time1,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing2 = visual.TextStim(my_window, text=time2,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing3 = visual.TextStim(my_window, text=time3,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

######################################
## Generate experimental conditions ##
######################################

## randomization shape practice-block
single_shapepr_parameters = []

TASKSHAPEPR = TASKSHAPEPR*8

SHAPES1SHAPETESTPR = SHAPES1SHAPETESTPR*2
SHAPES2SHAPETESTPR = SHAPES2SHAPETESTPR*2
SHAPESSHAPETESTPR = SHAPES1SHAPETESTPR + SHAPES2SHAPETESTPR

COLOURSSHAPETESTPR = COLOURS1SHAPETESTPR + COLOURS2SHAPETESTPR

for i in range(len(TASKSHAPEPR)):
    needed = (TASKSHAPEPR[i],SHAPESSHAPETESTPR[i], COLOURSSHAPETESTPR[i])
    single_shapepr_parameters.append(needed)

print type(single_shapepr_parameters), single_shapepr_parameters

single_shapepr_order = range(len(single_shapepr_parameters))
random.shuffle(single_shapepr_order)

## randomization shape test-block
single_shape_parameters = []

TASKSHAPE = TASKSHAPE*40

SHAPES1SHAPETEST = SHAPES1SHAPETEST*10
SHAPES2SHAPETEST = SHAPES2SHAPETEST*10
SHAPESSHAPETEST = SHAPES1SHAPETEST + SHAPES2SHAPETEST

COLOURSSHAPETEST = COLOURS1SHAPETEST*5 + COLOURS2SHAPETEST*5

for i in range(len(TASKSHAPE)):
    needed = (TASKSHAPE[i],SHAPESSHAPETEST[i], COLOURSSHAPETEST[i])
    single_shape_parameters.append(needed)

print type(single_shape_parameters), single_shape_parameters

single_shape_order = range(len(single_shape_parameters))
random.shuffle(single_shape_order)

## randomization colour practice-block
single_colourpr_parameters = []

TASKCOLOURPR = TASKCOLOURPR*8

SHAPES1COLOURTESTPR = SHAPES1COLOURTESTPR*2
SHAPES2COLOURTESTPR = SHAPES2COLOURTESTPR*2
SHAPESCOLOURTESTPR = SHAPES1COLOURTESTPR + SHAPES2COLOURTESTPR

COLOURSCOLOURTESTPR = COLOURS1COLOURTESTPR + COLOURS2COLOURTESTPR

for i in range(len(TASKCOLOURPR)):
    needed = (TASKCOLOURPR[i],SHAPESCOLOURTESTPR[i], COLOURSCOLOURTESTPR[i])
    single_colourpr_parameters.append(needed)

print type(single_colourpr_parameters), single_colourpr_parameters

single_colourpr_order = range(len(single_colourpr_parameters))
random.shuffle(single_colourpr_order)

## randomization colour test-block
single_colour_parameters = []

TASKCOLOUR = TASKCOLOUR*40

SHAPES1COLOURTEST = SHAPES1COLOURTEST*10
SHAPES2COLOURTEST = SHAPES2COLOURTEST*10
SHAPESCOLOURTEST = SHAPES1COLOURTEST + SHAPES2COLOURTEST

COLOURSCOLOURTEST = COLOURS1COLOURTEST*5 + COLOURS2COLOURTEST*5

for i in range(len(TASKCOLOUR)):
    needed = (TASKCOLOUR[i],SHAPESCOLOURTEST[i], COLOURSCOLOURTEST[i])
    single_colour_parameters.append(needed)

print type(single_colour_parameters), single_colour_parameters

single_colour_order = range(len(single_colour_parameters))
random.shuffle(single_colour_order)

## randomization mixed practice-block
mixed_practice_parameters = []

TASKSPR = TASKS*8

SHAPES1PR = SHAPES1PR*4
SHAPES2PR = SHAPES2PR*4
SHAPESPR = SHAPES1PR + SHAPES2PR

COLOURSPR = COLOURS1PR*2 + COLOURS2PR*2

for i in range(len(TASKSPR)):
    needed = (TASKSPR[i],SHAPESPR[i], COLOURSPR[i])
    mixed_practice_parameters.append(needed)

print type(mixed_practice_parameters), mixed_practice_parameters

mixed_practice_order = range(len(mixed_practice_parameters))
random.shuffle(mixed_practice_order)

## randomization mixed test-block
## 3 blocks of 48 trials -> 144 trials
trial_parameters = []

TASKS = TASKS*72

SHAPES1 = SHAPES1*36
SHAPES2 = SHAPES2*36
SHAPES = SHAPES1 + SHAPES2

COLOURS = COLOURS1*18 + COLOURS2*18

for i in range(len(TASKS)):
    if i %2 == 0:
        needed = (0, TASKS[i],SHAPES[i], COLOURS[i])
    else:
        needed = (1, TASKS[i],SHAPES[i], COLOURS[i])
    trial_parameters.append(needed)

print len(trial_parameters), trial_parameters

switchingTaskArray = []
switchingTaskIndex = 0

for i in range(int(len(trial_parameters)/2)):

    number = random.randrange(0, 1000000)

    if number % 2 == 0:
        switchingTask = ('mixed', 'switch', trial_parameters[switchingTaskIndex],trial_parameters[switchingTaskIndex+1])
        switchingTask = switchingTask[::-1]
    else:
        switchingTask = (trial_parameters[switchingTaskIndex],trial_parameters[switchingTaskIndex+1], 'switch', 'mixed')

    switchingTaskArray.append(switchingTask)
    switchingTaskIndex += 2

nonSwitchingTaskArray = []
nonSwitchingTaskIndex = 0

for i in range(int(len(trial_parameters)/2)):

    number = random.randrange(0, 1000000)

    if number % 2 == 0:
        nonSwitchingTask = ('mixed', 'non switch', trial_parameters[71 - nonSwitchingTaskIndex],trial_parameters[71 - (nonSwitchingTaskIndex+2)])
        nonSwitchingTask = nonSwitchingTask[::-1]
    else:
        nonSwitchingTask = (trial_parameters[71 - nonSwitchingTaskIndex],trial_parameters[71 - (nonSwitchingTaskIndex+2)],'non switch', 'mixed')

    nonSwitchingTaskArray.append(nonSwitchingTask)
    nonSwitchingTaskIndex += 1

print('-- switching in pairs --')
print(len(switchingTaskArray)), switchingTaskArray

print('-- no switching in pairs --')
print(len(nonSwitchingTaskArray)), nonSwitchingTaskArray

number = random.randrange(0, 1000000)

if(number % 2 == 0):
    mixedBlock = nonSwitchingTaskArray + switchingTaskArray
else:
    mixedBlock = switchingTaskArray + nonSwitchingTaskArray

print('-- all together --')
print(len(mixedBlock)), mixedBlock
print('++++++')

random.shuffle(mixedBlock)

print('-- all together shuffled--')
print(len(mixedBlock)), mixedBlock
print('------')

## randomization colour test-block 2
single_colour2_parameters = []

TASKCOLOUR2 = TASKCOLOUR2*40

SHAPES1COLOURTEST2 = SHAPES1COLOURTEST2*10
SHAPES2COLOURTEST2 = SHAPES2COLOURTEST2*10
SHAPESCOLOURTEST2 = SHAPES1COLOURTEST2 + SHAPES2COLOURTEST2

COLOURSCOLOURTEST2 = COLOURS1COLOURTEST2*5 + COLOURS2COLOURTEST2*5

for i in range(len(TASKCOLOUR2)):
    needed = (TASKCOLOUR2[i],SHAPESCOLOURTEST2[i], COLOURSCOLOURTEST2[i])
    single_colour2_parameters.append(needed)

print type(single_colour2_parameters), single_colour2_parameters

single_colour2_order = range(len(single_colour2_parameters))
random.shuffle(single_colour2_order)

## randomization shape test-block
single_shape2_parameters = []

TASKSHAPE2 = TASKSHAPE2*40

SHAPES1SHAPETEST2 = SHAPES1SHAPETEST2*10
SHAPES2SHAPETEST2 = SHAPES2SHAPETEST2*10
SHAPESSHAPETEST2 = SHAPES1SHAPETEST2 + SHAPES2SHAPETEST2

COLOURSSHAPETEST2 = COLOURS1SHAPETEST2*5 + COLOURS2SHAPETEST2*5

for i in range(len(TASKSHAPE2)):
    needed = (TASKSHAPE2[i],SHAPESSHAPETEST2[i], COLOURSSHAPETEST2[i])
    single_shape2_parameters.append(needed)

print type(single_shape2_parameters), single_shape2_parameters

single_shape2_order = range(len(single_shape2_parameters))
random.shuffle(single_shape2_order)

## create randomisation ##

while True:
    
    prob1 = 0.5
    prob2 = 0.5
    
    half = []
    
    firstNumber = random.randrange(0, 1000000)
    task = random.randrange(0, 1000000)
    
    if firstNumber % 2 == 0:
        half.append(0)
    else:
        half.append(1)
    
    if task % 2 == 0:
        half.append(half[0])
    else:
        if half[0] == 0:
            half.append(1)
        else:
            half.append(0)
    
    print(half)
    
    switching = 0
    nonSwitching = 1
    
    if half[0] == half[1]:
        nonSwitching += 1
    else:
        switching += 1
    
    print(half)
    
    print('non switching: %d' %(nonSwitching))
    print('switching: %d' %(switching))
    
    numberSwitching = 72 - switching
    numberNonSwitching = 72 - nonSwitching
    
    switchList = ['switch'] * numberSwitching
    nonSwitchList = ['nonSwitch'] * numberNonSwitching
    
    print(len(switchList))
    
    totalList = switchList + nonSwitchList
    random.shuffle(totalList)
    print(len(totalList))
    print(totalList)
    
    for i in range(len(totalList)):
        if totalList[i] == 'nonSwitch':
            half.append(half[-1])
        else:
            if half[-1] == 1:
                half.append(0)
            else:
                half.append(1)
    
    print(len(half))
    print(half)
            
    if half.count(1) == 72 and totalList.count('switch') == 72:
        break

print(half.count(1))
print(half.count(0))
print(totalList.count('switch'))
mixed_trials = []

for i in range(72):
    for j in range(2):
        mixed_trials.append(mixedBlock[i][j])

sorted_mixed = sorted(mixed_trials, key = lambda x: int(x[0]))

shapes = sorted_mixed[0:72]
colors = sorted_mixed[72:145]

random.shuffle(shapes)
print(shapes)

random.shuffle(colors)
print(colors)

shape_index = 0
color_index = 0

trialList = []

for i in range(len(half)):
     if half[i] == 0:
         trialList.append(shapes[shape_index])
         shape_index += 1
     else:
         trialList.append(colors[color_index])
         color_index += 1

print(half)
print(len(trialList))
print(trialList)

SwitchList = []

for i in range(len(trialList)):
    if i == 0:
        SwitchList.append('non switch')
    else:
        if trialList[i][1] == trialList[i-1][1]:
            SwitchList.append('non switch')
        else:
            SwitchList.append('switch')

print(totalList)
print(SwitchList)

## mixedBlock = trialList

##########################
## Experiment execution ##
##########################

welcome1.draw()
welcome2.draw()
welcome3.draw()
welcome4.draw()
welcome5.draw()
my_window.flip()
event.waitKeys()

instructions1.draw()
instructions2.draw()
instructions3.draw()
my_window.flip()
event.waitKeys()


while True:
    timing3.draw()
    my_window.flip()
    time.sleep(1)

    timing2.draw()
    my_window.flip()
    time.sleep(1)

    timing1.draw()
    my_window.flip()
    time.sleep(1)

    break

trial_nr = 1

didWeBreak = 0

experiment_data = []

with open("ColourShapeSwitch_Exp_Subject_%02d_FailSave.txt" %subject_id, 'w') as f:

    didWeBreak = 0
    ## shape practice block
    for single_shapepr_index in single_shapepr_order:

        task_word = single_shapepr_parameters[single_shapepr_index][0]
        shape_word = single_shapepr_parameters[single_shapepr_index][1]
        colour_word = single_shapepr_parameters[single_shapepr_index][2]

        task = []
        task.append("shape")

        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        cue_shape.draw()
        my_window.flip()
        time.sleep(.250)

        ## stimulus
        cue_shape.draw()
        if shape_word == "circle":
            circle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))
        else:
            triangle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))

        event.clearEvents()
        answer = event.waitKeys(keyList = ['Escape', 'escape', 'esc', 'd', 'f', 'j', 'k'])
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            didWeBreak = 1
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

        if didWeBreak == 1:
            break

    practice.draw()
    my_window.flip()
    event.waitKeys()

    didWeBreak = 0
    ## shape block
    for single_shape_index in single_shape_order:

        task_word = single_shape_parameters[single_shape_index][0]
        shape_word = single_shape_parameters[single_shape_index][1]
        colour_word = single_shape_parameters[single_shape_index][2]

        task = []
        task.append("shape")


        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        cue_shape.draw()
        my_window.flip()
        time.sleep(.250)

        ## stimulus
        cue_shape.draw()
        if shape_word == "circle":
            circle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))
        else:
            triangle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))

        event.clearEvents()
        answer = event.waitKeys(keyList = ['Escape', 'escape', 'esc', 'd', 'f', 'j', 'k'])
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            didWeBreak = 1
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        correct = -1

        if subject_id%2 == 0:
            if (shape_word == "circle" and answer[0] == "j") or (shape_word == "triangle" and answer[0] == "k"):
                correct = 1
            else:
                correct = 0
        else:
            if (shape_word == "circle" and answer[0] == "f") or (shape_word == "triangle" and answer[0] == "d"):
                correct = 1
            else:
                correct = 0

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

        writer = csv.writer(f, delimiter='\t')
        writer.writerow(["single", "non switch", task[0], shape[0], colour[0], answer, reactiontime, correct])
        experiment_data.append([0, 0, task[0], shape[0], colour[0], answer, reactiontime, correct])

        if didWeBreak == 1:
            break

    EndBlock.draw()
    my_window.flip()
    event.waitKeys()

    didWeBreak = 0
    ## colour practice block
    for single_colourpr_index in single_colourpr_order:

        task_word = single_colourpr_parameters[single_colourpr_index][0]
        shape_word = single_colourpr_parameters[single_colourpr_index][1]
        colour_word = single_colourpr_parameters[single_colourpr_index][2]

        task = []
        task.append("colour")

        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        cue_colour.draw()
        my_window.flip()
        time.sleep(.250)

        ## stimulus
        cue_colour.draw()
        if shape_word == "circle":
            circle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))
        else:
            triangle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))

        event.clearEvents()
        answer = event.waitKeys(keyList = ['Escape', 'escape', 'esc', 'd', 'f', 'j', 'k'])
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            didWeBreak = 1
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

        if didWeBreak == 1:
            break

    practice.draw()
    my_window.flip()
    event.waitKeys()

    didWeBreak = 0
    ## colour block
    for single_colour_index in single_colour_order:

        task_word = single_colour_parameters[single_colour_index][0]
        shape_word = single_colour_parameters[single_colour_index][1]
        colour_word = single_colour_parameters[single_colour_index][2]

        task = []
        task.append("colour")

        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        cue_colour.draw()
        my_window.flip()
        time.sleep(.250)

        ## stimulus
        cue_colour.draw()
        if shape_word == "circle":
            circle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))
        else:
            triangle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))

        event.clearEvents()
        answer = event.waitKeys(keyList = ['Escape', 'escape', 'esc', 'd', 'f', 'j', 'k'])
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            didWeBreak = 1
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        correct = -1

        if subject_id%2 == 0:
            if (colour_word == "blue" and answer[0] == "f") or (colour_word == "yellow" and answer[0] == "d"):
                correct = 1
            else:
                correct = 0
        else:
            if (colour_word == "blue" and answer[0] == "j") or (colour_word == "yellow" and answer[0] == "k"):
                correct = 1
            else:
                correct = 0

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

        writer = csv.writer(f, delimiter='\t')
        writer.writerow(["single", "non switch", task[0], shape[0], colour[0], answer, reactiontime, correct])
        experiment_data.append([0, 0, task[0], shape[0], colour[0], answer, reactiontime, correct])

        if didWeBreak == 1:
            break

    EndBlock.draw()
    my_window.flip()
    event.waitKeys()

    ## mixed block

    didWeBreak = 0
    ## mixed practice-block
    for mixed_practice_index in mixed_practice_order:

        task_word = mixed_practice_parameters[mixed_practice_index][0]
        shape_word = mixed_practice_parameters[mixed_practice_index][1]
        colour_word = mixed_practice_parameters[mixed_practice_index][2]

        task = []
        if task_word == "shape":
            task.append("shape")
        else:
            task.append("colour")

        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        if task_word == "colour":
            cue_colour.draw()
            my_window.flip()
            time.sleep(.250)
        else:
            cue_shape.draw()
            my_window.flip()
            time.sleep(.250)

        ## stimulus
        if task_word == "colour":
            cue_colour.draw()
            if shape_word == "circle":
                circle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))
            else:
                triangle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))
        else:
            cue_shape.draw()
            if shape_word == "circle":
                circle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))
            else:
                triangle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))

        answer = event.waitKeys()
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

    practice.draw()
    my_window.flip()
    event.waitKeys()

    trial_nr = 1
    didWeBreak = 0
    ## mixed test-block
    for trial_index in range(len(trialList)):
        task_word_now = trialList[trial_index][1]
        shape_word = trialList[trial_index][2]
        colour_word = trialList[trial_index][3]
        type_task = trialList[trial_index][1]
        type_block = 'mixed'
        switch = SwitchList[trial_index]

        print switch
        switch_number = []
        if switch == "switch":
            switch_number = 1
        else:
            switch_number = 0

        task = []
        if task_word_now == "shape":
            task.append("shape")
        else:
            task.append("colour")

        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        if task_word_now == "colour":
            cue_colour.draw()
            my_window.flip()
            time.sleep(.250)
        else:
            cue_shape.draw()
            my_window.flip()
            time.sleep(.250)

        ## stimulus
        if task_word_now == "colour":
            cue_colour.draw()
            if shape_word == "circle":
                circle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))
            else:
                triangle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))
        else:
            cue_shape.draw()
            if shape_word == "circle":
                circle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))
            else:
                triangle.draw()
                my_window.flip()
                t1 = int(round(time.time() * 1000))

        event.clearEvents()
        answer = event.waitKeys(keyList = ['Escape', 'escape', 'esc', 'd', 'f', 'j', 'k'])
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        if(trial_nr % 48 == 0 and trial_nr % 144 != 0 and trial_nr != 0):
            pause1.draw()
            my_window.flip()
            event.waitKeys()

        correct = -1

        if subject_id%2 == 0:
            if task_word_now == "colour":
                if (colour_word == "blue" and answer[0] == "f") or (colour_word == "yellow" and answer[0] == "d"):
                    correct = 1
                else:
                    correct = 0
            else:
                if (shape_word == "circle" and answer[0] == "j") or (shape_word == "triangle" and answer[0] == "k"):
                    correct = 1
                else:
                    correct = 0
        else:
            if task_word_now == "colour":
                if (colour_word == "blue" and answer[0] == "j") or (colour_word == "yellow" and answer[0] == "k"):
                    correct = 1
                else:
                    correct = 0
            else:
                if (shape_word == "circle" and answer[0] == "f") or (shape_word == "triangle" and answer[0] == "d"):
                    correct = 1
                else:
                    correct = 0

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

        trial_nr += 1

        writer = csv.writer(f, delimiter='\t')
        writer.writerow([type_block, switch, task[0], shape[0], colour[0], answer, reactiontime, correct])
        experiment_data.append([1, switch_number, task[0], shape[0], colour[0], answer, reactiontime, correct])

    EndBlock.draw()
    my_window.flip()
    event.waitKeys()

    didWeBreak = 0
    ## colour block 2
    for single_colour2_index in single_colour2_order:

        task_word = single_colour2_parameters[single_colour2_index][0]
        shape_word = single_colour2_parameters[single_colour2_index][1]
        colour_word = single_colour2_parameters[single_colour2_index][2]

        task = []
        if task_word == "shape":
            task.append("shape")
        else:
            task.append("colour")

        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        cue_colour.draw()
        my_window.flip()
        time.sleep(.250)

        ## stimulus
        cue_colour.draw()
        if shape_word == "circle":
            circle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))
        else:
            triangle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))

        event.clearEvents()
        answer = event.waitKeys(keyList = ['Escape', 'escape', 'esc', 'd', 'f', 'j', 'k'])
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            didWeBreak = 1
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        correct = -1

        if subject_id%2 == 0:
            if (colour_word == "blue" and answer[0] == "f") or (colour_word == "yellow" and answer[0] == "d"):
                correct = 1
            else:
                correct = 0
        else:
            if (colour_word == "blue" and answer[0] == "j") or (colour_word == "yellow" and answer[0] == "k"):
                correct = 1
            else:
                correct = 0

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

        writer = csv.writer(f, delimiter='\t')
        writer.writerow(["single", "non switch", task[0], shape[0], colour[0], answer, reactiontime, correct])
        experiment_data.append([0, 0, task[0], shape[0], colour[0], answer, reactiontime, correct])

        if didWeBreak == 1:
            break

    EndBlock.draw()
    my_window.flip()
    event.waitKeys()

    didWeBreak = 0
    ## shape block 2
    for single_shape2_index in single_shape2_order:

        task_word = single_shape2_parameters[single_shape2_index][0]
        shape_word = single_shape2_parameters[single_shape2_index][1]
        colour_word = single_shape2_parameters[single_shape2_index][2]

        task = []
        task.append("shape")

        shape = []
        if shape_word == "circle":
            shape.append("circle")
        else:
            shape.append("triangle")

        colour = []
        if colour_word == "blue":
            colour.append("blue")
        else:
            colour.append("yellow")

        circle = visual.Circle(my_window, radius = .1, pos=(0,0), fillColor = colour[0])
        triangle = visual.Polygon(my_window, edges=3, radius=.1, pos=(0,0), fillColor = colour[0])

        ## fixation cross
        fixation.draw()
        my_window.flip()
        time.sleep(.350)

        ## blank screen
        my_window.flip(clearBuffer = True)
        time.sleep(.150)

        ## task cue
        cue_shape.draw()
        my_window.flip()
        time.sleep(.250)

        ## stimulus
        cue_shape.draw()
        if shape_word == "circle":
            circle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))
        else:
            triangle.draw()
            my_window.flip()
            t1 = int(round(time.time() * 1000))

        event.clearEvents()
        answer = event.waitKeys(keyList = ['Escape', 'escape', 'esc', 'd', 'f', 'j', 'k'])
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            didWeBreak = 1
            break

        if reactiontime > 4000:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        correct = -1

        if subject_id%2 == 0:
            if (shape_word == "circle" and answer[0] == "j") or (shape_word == "triangle" and answer[0] == "k"):
                correct = 1
            else:
                correct = 0
        else:
            if (shape_word == "circle" and answer[0] == "f") or (shape_word == "triangle" and answer[0] == "d"):
                correct = 1
            else:
                correct = 0

        my_window.flip(clearBuffer = True)
        time.sleep(.850)

        writer = csv.writer(f, delimiter='\t')
        writer.writerow(["single", "non switch", task[0], shape[0], colour[0], answer, reactiontime, correct])
        experiment_data.append([0, 0, task[0], shape[0], colour[0], answer, reactiontime, correct])

        if didWeBreak == 1:
            break


#######################
## Data wegschrijven ##
#######################

expData = pd.DataFrame(experiment_data, columns = ['Block Type','Task Type','Task','Shape','Colour','answer','reactiontime','correct'])
print expData 

expData.to_csv("ColourShapeSwitch_Exp_Subject_%02d.txt" %subject_id, sep = '\t')

while not event.getKeys():
    EndInstruction1.draw()
    my_window.flip()

my_window.close()
core.quit()