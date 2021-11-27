#!/bin/bash
echo "Choose the way to change the version number, enter other characters unchanged"
echo "0.Reset"
echo "1.Self-increasing"
read -p "please input your choose >" choose
if [ $choose -eq 0 ]
then
	var=`sed -n '314,314P' Makefile`
	echo $var
	sed -i '314s/'"echo $var"'/build_desc := BSJ$(shell date +%g%m%d)A/g' Makefile
elif [ $choose -eq 1 ]
then
	var=`sed -n '314,314P' Makefile`
	#echo $var
	ch=${var: -1}
	num=`printf "%d" "'$ch"`
	#echo $num
	num=$(($num+1))
	#echo $ch
	#echo $num
	newvar=${var%?}
	#echo $newvar
	newch=`echo $num | awk '{printf("%c", $1)}'`
	final=$newvar$newch
	echo $final
	echo $var
	#sed -i '314s/'"echo $var"'/'"echo $final"'/' Makefile
	sed -i 'build_desc := BSJ$(shell date +%g%m%d)/s/'"echo $var"'/'"echo $final"'/' Makefile
else
	echo "aaa"
fi
