# 0.

cd ~
find ~/lab0 -type d -exec chmod 755 {} \;
rm -rf lab0
mkdir lab0
chmod 755 lab0
cd ./lab0
mkdir tmp
tfile="$(mktemp ~/lab0/tmp/XXXXXXXXX)" || exit 1

# 1.

mkdir camerupt3
touch camerupt3/politoed
touch camerupt3/granbull
mkdir camerupt3/ekans
mkdir camerupt3/seismitoad
touch camerupt3/cranidos
touch kirlia6
mkdir lampent8
mkdir lampent8/tirtouga
touch lampent8/chansey
touch lampent8/grotle
touch lampent8/mienshao
mkdir lampent8/wynaut
touch mantyke0
touch shedinja8
mkdir skitty6
touch skitty6/garchomp
mkdir skitty6/zoroark
touch skitty6/victreebel

echo -e "Развитые способности Drizzle" > camerupt3/politoed
echo -e "Развитые способности\nRattled" > camerupt3/granbull
echo -e "satk=3 sdef=3 spd=6" > camerupt3/cranidos
echo -e "weight=44.5 height=31.0\natk=4 def=4" > kirlia6
echo -e "Способности Last Chance Natural Cure Serene\nGrace" > lampent8/chansey
echo -e "Способности Withdraw Absorb Razor Leaf Curse Bite Mega\nDrain Leech Seed Synthesis Crunch Giga Drain Leaf Storm" > lampent8/grotle
echo -e "Тип\nпокемона FIGHTING NONE" > lampent8/mienshao
echo -e "Тип диеты\nHerbivore" > mantyke0
echo -e "weight=2.6 height=31.0 atk=9 def=5" > shedinja8
echo -e "Тип\nдиеты Carnivore" > skitty6/garchomp
echo "Способности Leaf Tornado Left Storm Leaf" > skitty6/victrebel
echo "Blade" >> skitty6/victrebel

# 2.

chmod u=rx,g=rwx,o=rwx camerupt3
chmod u=rw,g=w,o= camerupt3/politoed
chmod u=,g=rw,o= camerupt3/granbull
chmod u=wx,g=x,o=x camerupt3/ekans
chmod u=rwx,g=rwx,o=rwx camerupt3/seismitoad
chmod u=rw,g=r,o= camerupt3/cranidos
chmod u=r,g=r,o= kirlia6
chmod u=rx,g=rwx,o=rw lampent8
chmod u=rwx,g=rx,o=w lampent8/tirtouga
chmod 046 lampent8/chansey
chmod u=r,g=,o= lampent8/grotle
chmod u=r,g=,o= lampent8/mienshao
chmod u=wx,g=wx,o=rx lampent8/wynaut
chmod u=,g=rw,o= mantyke0
chmod u=,g=,o= shedinja8
chmod 755 skitty6
chmod u=r,g=,o= skitty6/garchomp
chmod 355 skitty6/zoroark
chmod 404 skitty6/victreebel

# 3. 

# БЫЛО: cp: skitty6/zoroark: Permission denied
chmod 755 skitty6/zoroark
cp -a skitty6 camerupt3/ekans/
chmod 355 skitty6/zoroark # Вернули chmod

ln -s camerupt3 Copy_28
cd skitty6
ln -s ../mantyke0 garchompmantyke
cd ../

chmod 755 lampent8/wynaut
cp kirlia6 lampent8/wynaut/
chmod u=wx,g=wx,o=rx lampent8/wynaut # Вернули chmod

# БЫЛО: 
# cp: shedinja8: Permission denied
# cp: lampent8/grotleshedinja: Permission denied
chmod 755 shedinja8
chmod 755 lampent8
cp shedinja8 lampent8/grotleshedinja
chmod u=rx,g=rwx,o=rw lampent8
chmod u=,g=,o= shedinja8 # Вернули chmod

ln kirlia6 skitty6/garchompkirlia

# БЫЛО:
chmod 755 lampent8/chansey camerupt3/granbull # Вернули chmod
# cat: lampent8/chansey: Permission denied
# cat: camerupt3/granbull: Permission denied
cat lampent8/chansey camerupt3/granbull > kirlia6_29
chmod 046 lampent8/chansey # Вернули chmod
chmod u=,g=rw,o= camerupt3/granbull # Вернули chmod

echo -e "\nДерево после пункта 3. \n\n"

ls -lR

echo -e "\n\nДалее Пункт 4. \n"

# 4.

chmod u=xwr kirlia6
wc -l < kirlia6 >> kirlia6 2>&1
chmod u=r kirlia6

ls lampent8/ 2>> $tfile | sort -r 2>> $tfile

echo -e '\n######################\n'

grep -hnr --include g* '' ~/lab0 2>>/dev/null | sort -f -t ":" -k 2 2>>/dev/null

echo -e '\n######################\n'

# БЫЛО
# wc: lampent8/chansey: open: Permission denied
# ls: ./camerupt3/ekans: Permission denied
# ls: ./lampent8/wynaut: Permission denied
# ls: ./skitty6/zoroark: Permission denied

chmod 755 lampent8/chansey ./camerupt3/ekans ./lampent8/wynaut ./skitty6/zoroark

wc -l camerupt3/cranidos lampent8/chansey lampent8/grotle lampent8/mienshao skitty6/garchomp 1>> $tfile 2>> $tfile

ls -Rl | grep '.*8$' | sort -k2 2>&1

echo -e '\n######################\n'

ls -Rl | grep '^-' | grep ' m\S*$' | sort -k5n | head -n 4

# ВОЗВРАЩАЮ PERMISSIONS
chmod 046 lampent8/chansey
chmod u=wx,g=x,o=x camerupt3/ekans
chmod u=wx,g=wx,o=rx lampent8/wynaut
chmod 355 skitty6/zoroark

echo -e "\nДерево после пункта 4. \n\n"

ls -lR

echo -e "\n\nДалее Пункт 5. \n"

# 5.

# Чтобы всё удалялось
# БЫЛО:
# rm: camerupt3/granbull: Permission denied
# rm: camerupt3/ekans: Permission denied
# rm: camerupt3/cranidos: Permission denied
# rm: camerupt3/seismitoad: Permission denied
# rm: camerupt3/politoed: Permission denied
# rm: camerupt3: Directory not empty
chmod 777 camerupt3 camerupt3/granbull camerupt3/ekans camerupt3/cranidos camerupt3/seismitoad camerupt3/politoed

rm -rf shedinja8
rm -rf **Copy_*
rm -rf skitty6/garchompkirl*

rm -rf camerupt3

rmdir skitty6/zoroark

echo -e "\nДерево после пункта 5. \n\n"

ls -lR
