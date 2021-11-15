count=0
echo "1 for while"
echo "0 for exit"
while(((count<3)&&(true)))
do
	echo "please input your choose!"
	read choose
	if [ $choose = 1 ]
	then
		echo "your choose $choose"
		ls -la
	elif [ $choose = 0 ]
	then
		echo "your choose $choose"
		echo "exit"
		exit
	else
		count=$(($count+1))
	fi
done
