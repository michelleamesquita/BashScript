#usr/bin/bash
rm line.txt

if [ "$1" == "" ]; 
then
	echo -e '\e[35;1m ========================================================================= \e[m'
	echo ""
	echo  -e '\e[36;1m	[+] Digite URL \e[m'
	echo ""
	echo -e '\e[35;1m ========================================================================= \e[m'
else
	echo -e '\e[35;1m ========================================================================= \e[m'
	echo ""
	echo -e '\e[32;1m	[+] Resolvendo Urls em: \e[m' '\e[36;1m  '$1' \e[m'                        
	echo ""
	echo -e '\e[35;1m ========================================================================= \e[m'
fi

wget -q  $1

grep href index.html| cut -d "/" -f3 | grep "\." | cut -d '"' -f1 | grep -v "<l" > lista

for i in $(cat lista);
	do host $i|grep "has address" >> $1.txt
done
#sed -i '$d' $1.txt


for i in `seq 1 $(cat "$1.txt"| wc -l)`; do
let count=$((count+1)); echo "             "$count"       " >> line.txt;
done 

#sed -i '$d' line.txt

cat "$1.txt"|cut -d " " -f4|sort -u|uniq > ip.txt
cat "$1.txt"|cut -d " " -f1|sort -u|uniq > address.txt

#for i in $(cat ip.txt); do echo $i"      " >> ip.txt; done


echo " "
echo -e '\e[31;1m [+] Concluido: Salvando os resultados em: '$1'.txt \e[m'
echo " "

echo -e '\e[35;1m ========================================================================= \e[m'
echo           "            Line            IP                 Adress      "
echo -e '\e[35;1m ========================================================================= \e[m'

paste line.txt ip.txt address.txt | column -s $'\t' -t 
         
echo -e '\e[35;1m ========================================================================= \e[m'

echo -e '\e[32;1m Nova pesquisa? [y/n] \e[m'
read var

if [ "$var" == "y" ]
then
 echo "[+] Digite URL";read var2;
 ./parsing.sh $var2
 rm index.html.1 
elif [ "$var" == "n" ]
then
 echo "Saindo..."
fi

rm index.html 
 


