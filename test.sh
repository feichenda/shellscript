while(true)
do
	echo "please input your choose!"
	read choose
	if [ $choose = 1 ]
	then
		echo "your choose $choose"
	elif [ $choose = 0 ]
	then
		echo "your choose $choose"
		echo "exit"
		exit
	else
		pwd
		ls -la
	fi
done