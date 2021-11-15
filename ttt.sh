now_path=$(cd `dirname $0`;pwd)
work_name="work"
file_name="log.txt"
work_path="$now_path/$work_name"
file_path="$work_path/$file_name"
filesize=0								#当前文件大小
maxsize=$((1024*1024*2))				#最大2M
old=0									#记录上次文件大小
str=''
arr=( "|" "/" "-" "\\" )
if [ ! -d "$work_path" ]
then
	mkdir "$work_name"
	chmod 0777 "$work_path"
	echo "创建文件夹成功"
else
	echo "文件夹已经存在"
fi
sleep 1
if [ ! -x "$file_path" ]
then
	touch $file_path
	#echo > "$file_path"
	chmod 0777 "$file_path"
	echo "文件创建成功"
else
	echo "文件已经存在"
fi
sleep 1
echo "正在随机写入文件"
#先读取原有进度
filesize=`ls -l $file_path | awk '{ print $5 }'`
old=$(($filesize*100/$maxsize))
if [ $old -ne 0 ]
then
	if [ $old -ge 100 ]
	then
		for((i=0;i<=100;i++))
		do
			printf "\r[%-100s][%d%%]" $str $i
			str+='#'
		done
	else
		for((i=0;i<$old;i++))
		do
			printf "\r[%-100s][%d%%]" $str $i
			str+='#'
		done
	fi
fi
#先读取原有进度
i=0
while(true)
do
	filesize=`ls -l $file_path | awk '{ print $5 }'`
	pro=$(($filesize*100/$maxsize))
	if [ $pro -eq 100 ]
	then
		str+='#'
		printf "\r[%-100s][%d%%][\e[43;46;1m%c\e[0m]" "$str" "$pro" "${arr[$i%4]}"
		i=$(($i+1))
	fi
	if [ $filesize -ge $maxsize ]
	then
		str+='#'
		#printf "\r[%-100s][%d%%][\e[43;46;1m%c\e[0m]" "$str" "$pro" "${arr[$i%4]}"
		echo -e "\n文件大于$(($maxsize/1024/1024))M,将被清空"
		echo > "$file_path"
		old=0
		pro=0
		str=''
		i=0
		while ((i<=10))
		do
			printf "\r[%-100s][%d%%]" "$str" "$(($i*10))"
			str+='..........'
			i=$(($i+1))
			sleep 0.8
		done
		echo -e "\n文件清空成功\n正在随机写入文件"
		i=0
		str=''
	else
		rand_num=$(date +%s%N)
		#echo "$rand_num"
		#echo "$rand_num" >> "$file_path"
		#cat /dev/urandom |sed 's/[^a-zA-Z0-9]//g'|strings -n 6 |head -n 1 |grep -i '^[a-z]'|sort > "$file_path"
		#cat /dev/urandom | head -n 1000 | md5sum | head -c 100 >> "$file_path"
		#</dev/urandom  tr -dc   'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~'  |  head -c 15 ; echo 
		date +%s%N | md5sum | head -c 33 >> "$file_path"
		if [ $old -ne $pro ]
		then
			str+='#'
			old=$pro
			i=0
		fi
		#echo -en "\b\b\b\b"`echo $filesize*100/$maxsize | bc `'%'
	fi
	printf "\r[%-100s][%d%%][\e[43;46;1m%c\e[0m]" "$str" "$pro" "${arr[$i%4]}"
	i=$(($i+1))
done

#echo "work_path is $work_path"

#cd "$path_name/"
#sleep 1
#echo "work_path is $now_path"
