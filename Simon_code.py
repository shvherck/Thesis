#################################################
## Simon taak masterproef Shauni Van Herck     ##
## 12 oefentrials, 200 trials                  ##
## fixation 500 ms, 500 ms blank interval      ##
## before next trial, feedback if too slow     ##
## (> 900 ms), 2 blocks of 100 trials          ##
## Woumans, Ceuleers, Van Der Linden, ..       ##
##                                             ##
## 1: variabelen aanmaken (kleuren, posities:  ##
## zien dat alle combinaties mogelijk zijn,    ##
## tekst, ...) + zorgen voor contrabalancering ##
## 2: randomisering                            ##
## 3: experiment aanmaken                      ##
#################################################

## subject even
    ## congruent = rood rechts & groen links
    ## incongruent = rood links & groen rechts
## subject oneven
    ## congruent = rood links & groen rechts
    ## incongruent = rood rechts & groen links

## mogelijke combinaties subject even:
    ## rood  - rechts
    ## groen - links
    ## rood  - links
    ## groen - rechts
## -> 2x colour + (1x pos congruent + 1x pos incongruent)

## mogelijke combinaties subject oneven:
    ## rood  - links
    ## groen - rechts
    ## rood  - rechts
    ## groen - links
## -> 2x colour + (1x pos congruent omgekeerd + 1c pos incongruent omgekeerd)


############
## Import ##
############

from psychopy import core, visual, event
import random
import csv

import os
import platform 
import time

import pandas as pd

#########################
## Identification data ##
#########################

subject_id = 1

##############################
## Configuration parameters ##
##############################

my_window = visual.Window(fullscr = True, units = 'height', color = "white")

COLORS =["red","green"]
COLORSPR =["red","green"]

# zorgen voor contrabalancering
if subject_id%2 == 0: 
    POS_CONGR = ["right","left"]
    POS_INCONGR = ["left","right"]
    POS_CONGRPR = ["right","left"]
    POS_INCONGRPR = ["left","right"]
else:
    POS_CONGR = ["left", "right"]
    POS_INCONGR = ["right", "left"]
    POS_CONGRPR = ["left", "right"]
    POS_INCONGRPR = ["right", "left"]

fixation_cross = "+"
fixation = visual.TextStim(my_window, text=fixation_cross,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

welcome_1_text = "Welkom bij dit experiment."
welcome1 = visual.TextStim(my_window, text=welcome_1_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

welcome_2_text = "Jullie zullen rode en groene cirkels zien die aan de linkse of rechtse kant van het scherm verschijnen."
welcome2 = visual.TextStim(my_window, text=welcome_2_text,units='norm',height=0.07, color= 'Black',pos=[0,-0.2], alignHoriz='center',flipHoriz=False)

if subject_id%2 == 0:
    part_1_text = "Druk op de RECHTSTE pijl wanneer de cirkel ROOD is"
    instructions1 = visual.TextStim(my_window, text=part_1_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
    
    part_2_text = "Druk op de LINKSE pijl wanneer de cirkel GROEN is"
    instructions2 = visual.TextStim(my_window, text=part_2_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
else:
    part_1_text = "Druk op de LINKSE pijl wanneer de cirkel ROOD is"
    instructions1 = visual.TextStim(my_window, text=part_1_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
    
    part_2_text = "Druk op de RECHTSE pijl wanneer de cirkel GROEN is"
    instructions2 = visual.TextStim(my_window, text=part_2_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

part_3_text = "Het oefenblok is gedaan. Nu begint het testblok"
instructions3 = visual.TextStim(my_window, text=part_3_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

pause_text = "Pauze. Druk op spatie om verder te gaan met het experiment."
pause1 = visual.TextStim(my_window, text=pause_text,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

tooslow_text = "Te traag"
tooslow = visual.TextStim(my_window, text=tooslow_text,units='norm',height=0.07, color='Red',pos=[0,0], alignHoriz='center',flipHoriz=False)

EndInstr1 = 'Dit experiment is afgelopen is afgelopen. \n \nBedankt voor je deelname. \n \nDruk op spatie om af te sluiten.'
EndInstruction1 = visual.TextStim(my_window, text=EndInstr1,units='norm',height=0.12, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

time1 = '1'
time2 = '2'
time3 = '3'

timing1 = visual.TextStim(my_window, text=time1,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing2 = visual.TextStim(my_window, text=time2,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing3 = visual.TextStim(my_window, text=time3,units='norm',height=0.07, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

######################################
## Generate experimental conditions ##
######################################

## randomisering oefenblok
practice_parameters = []

COLORSPR = COLORSPR*6

POS_CONGRPR = POS_CONGRPR*3
POS_INCONGRPR = POS_INCONGRPR*3
POSPR = POS_CONGRPR+POS_INCONGRPR

for i in range(len(COLORSPR)):
    needed_practice = (COLORSPR[i],POSPR[i])
    practice_parameters.append(needed_practice)

print type(practice_parameters), practice_parameters

practice_order = range(len(practice_parameters))
random.shuffle(practice_order)


## randomisering testblok
trial_parameters = []

COLORS = COLORS*100

POS_CONGR = POS_CONGR*50
POS_INCONGR = POS_INCONGR*50
POS = POS_CONGR+POS_INCONGR

for i in range(len(COLORS)):
    needed = (COLORS[i],POS[i])
    trial_parameters.append(needed)

print type(trial_parameters), trial_parameters

trial_order = range(len(trial_parameters))
random.shuffle(trial_order)

##########################
## Experiment execution ##
##########################

welcome1.draw()
welcome2.draw()
my_window.flip()
event.waitKeys()

instructions1.draw()
my_window.flip()
event.waitKeys()

instructions2.draw()
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


## oefenblok
for practice_index in practice_order:

        color_word = practice_parameters[practice_index][0]
        position_word = practice_parameters[practice_index][1]

        color = []
        if color_word == "red":
            color.append("red")
        else:
            color.append("green")

        position = []
        pos_number = []
        if position_word == "right":
            position.append("right")
            pos_number.append(.5)
        else:
            position.append("left")
            pos_number.append(-.5)

        circle = visual.Circle(my_window, radius = .10, pos=(pos_number[0],0), fillColor = color[0])

        fixation.draw()
        my_window.flip()
        time.sleep(.5)

        circle.draw()
        my_window.flip()
        t1 = int(round(time.time() * 1000))

        answer = event.waitKeys()
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            break

        if reactiontime > 900:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        my_window.flip(clearBuffer = True)
        time.sleep(.5)


instructions3.draw()
my_window.flip()
event.waitKeys()


## testblok

trial_nr = 1

experiment_data = []

with open("Simon_Exp_Subject_%02d_FailSave.txt" %subject_id, 'w') as f:
    for trial_index in trial_order:

        color_word = trial_parameters[trial_index][0]
        position_word = trial_parameters[trial_index][1]

        color = []
        if color_word == "red":
            color.append("red")
        else:
            color.append("green")

        position = []
        pos_number = []
        if position_word == "right":
            position.append("right")
            pos_number.append(.5)
        else:
            position.append("left")
            pos_number.append(-.5)

        congruency = -1
        
        if subject_id%2 == 0:
            if (color_word == "red" and position_word == "right") or (color_word == "green" and position_word == "left"):
                congruency = 1
            else:
                congruency = 0
        else:
            if (color_word == "green" and position_word == "right") or (color_word == "red" and position_word == "left"):
                congruency = 1
            else:
                congruency = 0

        circle = visual.Circle(my_window, radius = .10, pos=(pos_number[0],0), fillColor = color[0])

        fixation.draw()
        my_window.flip()
        time.sleep(.5)

        circle.draw()
        my_window.flip()
        t1 = int(round(time.time() * 1000))

        answer = event.waitKeys()
        t2 = int(round(time.time() * 1000))

        reactiontime= int(t2 - t1)

        if answer[0] in ['Escape','escape', 'esc']:
            break

        if reactiontime > 900:
            tooslow.draw()
            my_window.flip()
            time.sleep(.8)

        if(trial_nr % 100 == 0 and trial_nr != 200 and trial_nr != 0):
            pause1.draw()
            my_window.flip()
            event.waitKeys()

        correct = -1

        if subject_id%2 == 0: 
            if (color_word == 'red' and answer[0] == 'right') or (color_word == 'green' and answer[0] == 'left'):
                correct = 1
            else:
                correct = 0
        else:
            if (color_word == 'red' and answer[0] == 'left') or (color_word == 'green' and answer[0] == 'right'):
                correct = 1
            else:
                correct = 0

        my_window.flip(clearBuffer = True)
        time.sleep(.5)

        writer = csv.writer(f, delimiter='\t')
        writer.writerow([trial_nr, color[0], position[0], congruency, answer, reactiontime, correct])
        experiment_data.append([trial_nr, color[0], position[0], congruency, answer, reactiontime, correct])
        
        trial_nr += 1


#######################
## Data wegschrijven ##
#######################

expData = pd.DataFrame(experiment_data, columns = ['Trial', 'Colour','Position','Congruency', 'Answer','Reactiontime','Correct'])
print expData

expData.to_csv("Simon_Exp_Subject_%02d.txt" %subject_id, sep = '\t')

while not event.getKeys():
    EndInstruction1.draw()
    my_window.flip()

my_window.close()
core.quit()

#########
## END ##
#########