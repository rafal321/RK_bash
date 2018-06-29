#!/bin/bash

echo -- if statement ----------

read -p "Enter letter: " word

if [[ "$word" == a ]]; then
        echo "$word equals a"
elif [ "$word" == b ]; then
        echo "$word equals b"
elif [[ "$word" > b && "$word" < z ]]; then
        echo "It can be any letter of alfabet"
else
        echo "$word is indeed z"
fi

echo  --- chech for file exist -----------
#-e if file exist; -f if its a regural file or not
#-d if dir exist; -b block special file (video pictures)
#-c character special file; -s empty file; rwx premissions
read -p "Enter file name: " file_name
if [ -e $file_name ]; then
        echo "File Found"
else
        echo "File Not Found"
fi

echo "--- append text to a file which exist---"

read -p "Enter file name: " file_name

if [ -f $file_name ]; then
        if [ -w $file_name ]; then
                echo "type some text data. ctr+d to exit"
                cat >> $file_name
        else
                echo "File do not have write premission"
        fi
else
        echo "File does not exist"
fi

echo --- logical operators ----
age=44

if [ "$age" -gt 18 -a "$age" -lt 30 ]; then
#if [[ "$age" -gt 18 && "$age" -lt 30 ]]; then
#if [ "$age" -gt 18 ] && [ "$age" -lt 30 ]; then
        echo "Valid age"
else
        echo "Age not valid"
fi
#the same with or || -o

echo --- aritmetic operations ----
num1=20
num2=5
echo $(( num1 + num2 ))
echo $(expr $num1 + $num2)
echo $(expr $num1 \* $num2)
#bc -basic calculator
num3=20.5
echo "$num2+$num3" | bc
echo "20.5+5" | bc
echo "scale=5;20.5/5" | bc
num4=27
echo "scale=3;sqrt($num4)" | bc -l
echo "scale=2;($num1)^2" | bc -l

echo --- case statement ---
#[1:49:00]
vechicle=$1
case $vechicle in
        "car" )
                echo "Rent of $vechicle is 100$" ;;
        [vV][aA][nN])
                echo "Rent of $vechicle is 150$" ;;
        "bike" )
                echo "Rent of $vechicle is 15$" ;;
        * )
                echo "Unknown vechicle" ;;
esac

skonczone 2:02:00

#!/bin/bash
echo --- arrays -------

os=('ubuntu' 'windows' 'kali')

echo "${os[@]}"
echo "${os[1]}"
os[3]="mac" #add/update
unset os[1]
echo "${#os[@]}"

echo --- for loop part 1 + array -----

counter=1
for x in ${os[*]}
do
        echo "$counter) $x."
        #((counter++))  arithmetic expansion
        let "counter++"
done

echo --- while loop -----
n=1
#while (( $n <= 10 ))
while [ "$n" -le 4 ]; do
        echo "$n"
        n=$(( n+1 ))
        sleep 0.5
done

echo --- read file while loop ---

while read var; do
        echo "$var"
done < raf1file.txt
#druga opcja reading a file (cut sort head etc)
#if special caracters this method is causes problems
sort raf1file.txt | while read var2; do
        echo "$var2"
done
#fool prof method is ifs
#here we assigning space, not read albo(=' ')
#-r prevents \ from being interpreted
while IFS= read -r var3; do
        echo "$var3"
done < /etc/passwd

echo --- until loop -------
#if condition is false conmmands are executed
#oposite to while loop
x=1
until [ "$x" -ge 11 ]; do
        echo ">>>> $x"
        (( x++ ))
        sleep 0.2
done

echo --- for loop part 2 -------

#for i in 1 2 3 4 5
#for i in {1...10}
for i in {1..10..2} #increment by 2
do
        echo $i
done

for (( i=0; i<5; i++ )); do
        echo ">> $i"
done
#########################
for command1 in ls pwd date; do
        echo " - - - $command1 - - - - -"
        $command1
done
# to print directories only
#-f all files only
for item in *; do
        if [ -d $item ]; then
                echo $item
        fi
done

echo --- select loop select statement ----
#used when menu is needed
# used with case
select name1 in mark john james; do
        echo ">> $name1 selected"
done
###### [2:56:00]
# here we can implement complex logic based on select loop:
select name2 in bob alex elen; do
        case $name2 in
                bob )
                        echo "mark selected" ;;
                alex )
                        echo "alex selected" ;;
                elen )
                        echo "elen selected" ;;
                *)
                        echo "select btwn 1..4"
        esac
done

echo *[2:58:00]************************
echo --- break continue ---

for (( i=1; i<=10; i++ )); do
        if [ "$i" -gt 8 ]; then
                break
        fi
        echo "$i"
done

for (( i=1; i<=10; i++ )); do
        if [ "$i" -eq 3 -o "$i" -eq 6 ]; then
                continue
        fi
        echo ">> $i"
done

echo "**3:04:00 ***************"
echo --- functions --------
# you can skip function word

function hello(){
echo "hi there"
}
hello
exit #exits script
hello

function print(){
        echo $1 "xx" $2 $3
}
print bobo abab cece
print Hello



echo "**3:25:00 ***************"
echo --- local variables ---
function print(){
        local name=$1
        echo "the name is $name"
}
name="Tom"
echo "The name is $name : Before"
print Max
echo "The name is $name : After"
###########################################
#if file exists or not
function usage(){
        echo "You need to provide an argument : "
        echo "usage : $0 file_name"
}
function is_file_there(){
        local file="$1"

#if file exists it will skip return0 and jump to return1
#if 1st condition is fale it will jump to return0
#no if needed in ternary operators!
        [[ -f "$file" ]] && return 0 || return 1
}
# $# - wil give us number of arguments
[[ $# -eq 0 ]] && usage

if ( is_file_there "$1" ); then
        echo "File Found"
else
        echo "File not Found"
fi

echo "**3:41:30 ***************"
echo --- signals and traps ----

trap "echo Exit signal detected" SIGINT
#SIGKILL SIGSTOP do not apply
# $$ pid of current shel scrip
echo "pid is $$"
while (( COUNT < 10 )); do
        sleep 10
        (( COUNT++ ))
        echo $COUNT
done
exit 0
#exit script with signal 0 success
#man 7 signal
# kill -9 procesID

file=/home/raf/test.file
trap "rm -f $file && echo File deleted; exit" 0 2 15


--- debuging ---
set -x
set +x
or bash -x ./myscript.sh