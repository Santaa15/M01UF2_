#!/bin/bash

# Posem la ip.
CLIENT="MI IP"
TIMEOUT=1


echo $IP

echo "Servidor de EFTP"

echo "(0) Listen"

DATA=`nc -l -p 3333 -w $TIMEOUT`

echo $DATA

echo "(3) Test & Send"

if [ "$DATA" != "EFTP 1.0" ] 
then
	echo "ERROR 1: BAD HEADER1"
	sleep 1
	echo "KO_HEADER" | nc $CLIENT 3333
	exit 1
fi 

echo "OK_HEADER"
echo "OK_HEADER" | nc $CLIENT 3333
sleep 1

echo "(4) Listen"

DATA=`nc -l -p 3333 -w $TIMEOUT`
echo $DATA

echo "(7) Test & Send"

if [ "$DATA" != "BOOOM" ]

then 
	echo "ERROR 2: BAD_HANDSHAKE2"

	sleep 1
	echo "KO_HANDSHAKE" | nc $CLIENT 3333
	exit 2
fi

sleep 1
echo "OK_HANDSHAKE" | nc $CLIENT 3333


echo "(7a) Listen NUM_FILES"

DATA=`nc -l -p 3333 -w $TIMEOUT`

echo $DATA


ehco "(7b) Send OK/KO_NUM_FILES"

PREFIX=`echo $DATA | cut -d " " -f 1`

if [ "$PREFIX" != "NUM_FILES" ]
then
	echo "ERROR 3a: WRONG NUM_FILES PREFIX"

	echo "KO_FILE_NUM" | nc $CLIENT 3333

	exit 3
fi

echo "OK_FILE_NUM" | nc $CLIENT 3333

FILE_NUM=`echo $DATA | cut -d " " -f 2`


for N in `seq $FILE_NUM` 
do

echo "Archivo numero $N"

echo "(8b) Listen"

DATA=`nc -l -p 3333 -w $TIMEOUT`
echo $DATA

echo "(12) Test & Store & Send "

PREFIX= `echo "$DATA" | cut -d " " -f 1 `

if [ "$PREFIX" != "FILE_NAME" ]

then
	echo "Error 3: Prefix Error3"
	sleep 1
	echo "KO_HANDSHAKE" | nc $CLIENT 3333
	exit 3
fi

FILENAME= `echo "$DATA" | cut -d " " -f 2`
echo "OK_HANDSHAKE" | nc $CLIENT 3333

echo "(13) Listen"

FILENAME= `echo "$DATA" | cut -d " " -f 2`
DATA=`nc -l -p 3333 -w $TIMEOUT`

echo "(16) Store & Send"

if [ "$DATA" == "" ]
then
	echo "Error 4: Pal Lobby y sin lloros4"
	sleep 1
	echo "KO_HANDSHAKE" | nc $CLIENT 3333
	exit 4
fi

echo $DATA > inbox/$FILE_NAME

sleep 1
echo "OK_ADEU" | nc $CLIENT 3333

echo "(17) Listen"

DATA=`nc -l -p 3333 -w $TIMEOUT`

echo "(20) Test & Send"

echo "JA ESTARIA"
exit 0