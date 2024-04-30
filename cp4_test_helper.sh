#!/usr/bin/env bash

# HOW TO RUN:
# 
# 1. Copy the bash file (cp4_test_helper.sh) and the expect file (interaction.exp) to the same directory as your executable (e.g., bin directory).
# 2. cd to the directory of your executable (e.g., bin directory).
# 3. Execute the following command: 
#    "bash cp4_test_helper.sh ./<executable> <testcase-number>"
# 4. Check if your program's output align with the 'EXPECTED OUTPUTS' output.

if [ $# -ne 2 ]; then
	echo "bash cp4_test_helper.sh ./<executable> <testcase-number>"
	exit 1
fi


# ================================================================================================
# Following are simple test cases for testing your program's overall functionality.

declare -A tests

# Test-case 1 : Remove the added songs and then call favorite
tests[1]="
song 1 james 330 alpha
song 2 charlie 440 beta
remove alpha
song 3 michael 310 nick
remove beta
remove nick
favorite
quit
"

# Test-case 2 : Listen, favorite, and show listen time
tests[2]="
song 1 Taylor 330 Ruby
song 2 Test 440 Emarald
song 3 Treat 310 Sapphire
listen Ruby 100
listen Emarald 50
favorite
favorite
favorite
show_listen_time
quit
"

# Test-case 3 : Try listening to a favorited song, which will be ignored
tests[3]="
song 1 Taylor 330 Ruby
listen Ruby 100
favorite
listen Ruby 100
listen Ruby 100
quit
"

# Test-case 4 : Remove a favorited and non-favorited song
tests[4]="
song 1 Taylor 330 Ruby
song 2 Test 440 Emarald
listen Ruby 100
favorite
remove Ruby
remove Emarald
quit
"



# ================================================================================================
# Expected outputs of above test-commands
declare -A expected_outputs

expected_outputs[1]="
[ Test-case 1 : Remove the added songs and then call favorite ]

new song 1 alpha by james 5:30
new song 2 beta by charlie 7:20
Removed alpha from your songs
new song 3 nick by michael 5:10
Removed beta from your songs
Removed nick from your songs
No song to award
"


expected_outputs[2]="
[ Test-case 2 : Listen, favorite, and show listen time ]

new song 1 Ruby by Taylor 5:30
new song 2 Emarald by Test 7:20
new song 3 Sapphire by Treat 5:10
Listened to Ruby for 100 seconds
Listened to Emarald for 50 seconds
Song Ruby added to list of favorites (Listened for 100 seconds)
Song Emarald added to list of favorites (Listened for 50 seconds)
Song Sapphire added to list of favorites (Listened for 0 seconds)
1 Ruby has been listened for 100 seconds
2 Emarald has been listened for 50 seconds
3 Sapphire has been listened for 0 seconds
"

expected_outputs[3]="
[ Test-case 3 : Try listening to a favorited song, which will be ignored ]

new song 1 Ruby by Taylor 5:30
Listened to Ruby for 100 seconds
Song Ruby added to list of favorites (Listened for 100 seconds)
"


expected_outputs[4]="
[ Test-case 4 : Remove a favorited and non-favorited song ]

new song 1 Ruby by Taylor 5:30
new song 2 Emarald by Test 7:20
Listened to Ruby for 100 seconds
Song Ruby added to list of favorites (Listened for 100 seconds)
Removed Ruby from your favorites
Remove Emarald from your songs
"


# INTERACTION
clear 
expect interaction.exp "$1" "${tests[$2]}" 2>&1
printf "\n\n--------- EXPECTED OUTPUTS (Don't Need to be Exact) --------- \n\n${expected_outputs[$2]}\n\n\n"


exit 0


