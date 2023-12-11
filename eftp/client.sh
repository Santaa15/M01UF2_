#!/bin/bash

IP=`ip address | grep inet | head -n 3 | tail -n 1 | cut -d " " -f 6 | cut -d "/" -f 1`
echo $IP
SERVER="localhost"
TIMEOUT=1

echo "(1) Send"

echo "Cliente de EFTP"
echo "EFTP 1.0" | nc $SERVER 3333

echo "(2) Listen"
DATA=`nc -l -p 3333 -w $TIMEOUT`
echo $DATA

echo "(5) Test & Send"

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: BAD_HEADER1"
	exit 1
fi

echo "BOOOM"
sleep 1
echo "BOOOM" | nc $SERVER 3333

echo "(6) Listen"

DATA=`nc -l -p 3333 -w $TIMEOUT`
echo $DATA

echo "(9) Test"

if [ "$DATA" != "OK_HANDSHAKE" ]
then 
	echo "Error 2: BAD_HANDSHAKE2"
	exit 2
fi


echo "(9a) SEND NUM_FILES"

NUM_FILES=`ls imgs/ | wc -l`

sleep 1

echo "NUM_FILES $NUM_FILES" | nc $SERVER $PORT


echo "(9b) LISTEN OK/KO_NUM_FILES"

DATA=`nc -l -p 3333 -w $TIMEOUT`


if [ "$DATA" != "OK_FILE_NUM" ]
then
	echo "ERROR 3a: WRONG FILE_NUM"
	exit 3
fi

for FILE_NAME in `ls imgs/`
do


echo "(10b) Send"

sleep 1

FILE_MD5=`echo $FILE_NAME | md5sum | cut -d " " -f 1`

echo "FILE_NAME $FILE_NAME $FILE_MD5 | nc $SERVER 3333


echo "(11) Listen"
DATA= `nc -l -p 3333 -w $TIMEOUT`

echo "(14) Test & Send"

if [ "$DATA" != "OK_HANDSHAKE" ]

then
	echo "Error 3: BAD_HANDSHAKE3"
	echo " BAD_HANDSHAKE" | nc $SERVER 3333
	exit 3
fi

sleep 1
cat imgs/fary1.txt | nc $SERVER 3333

echo "(15) Listen"
DATA= `nc -l -p 3333 -w $TIMEOUT`

if [ "$DATA" != "OK_DADES" ]
then
	echo "Error 4: ERROR DE DADES4"
	exit 4
fi

DATA=`nc -l -p 3333 -w $TIMEOUT`

echo "(18) Send"

FILE_MD5=`cat imgs/$FILE_NAME | md5sum | cut -d " " -f 1`

echo "FILE_MD5 $FILE_MD5" | nc $SERVER 3333

echo "(19) Listen"
DATA=`nc -l -p 3333 -w $TIMEOUT`


echo "(21) Test"

if [ "$DATA != "OK_FILE_MD5"]
then 

echo "JA ESTARIA"
exit 0