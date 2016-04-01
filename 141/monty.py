import sys
import random


# read input
line = raw_input("enter number: ")
sw_wins = 0 
first_wins = 0
num = int(line)
for i in range (num):
    doors = [1,2,3]

    # randomly place car
    car = random.choice(doors)
    my_choice = random.choice(doors)

    # randomly open goat door
    host_choice = random.choice([x for x in doors if x != car and x != my_choice])

    # first choice picked door
    if my_choice == car:
        first_wins += 1

    # second choice other door
    remain_choices = [my_choice, host_choice]
    switch_choice = [x for x in doors if x not in remain_choices]
    if switch_choice.pop() == car:
        sw_wins += 1

print "Tactic 1: " + str(first_wins/float(num) * 100) + "%"
print "Tactic 2: " + str(sw_wins/float(num) * 100) + "%"
