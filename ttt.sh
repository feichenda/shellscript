now_path=$(cd `dirname $0`;pwd)
work_name="work"
file_name="log.txt"
work_path="$now_path/$work_name"
file_path="$work_path/$file_name"
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
while(true)
do
	filesize=`ls -l $file_path | awk '{ print $5 }'`
	#最大2M
	maxsize=$((1024*1024*2))
	if [ $filesize -gt $maxsize ]
	then
		echo "文件大于$(($maxsize/1024/1024))M,将被清空"
		echo > "$file_path"
	else
		rand_num=$(date +%s%N)
		#echo "$rand_num"
		echo "$rand_num" >> "$file_path"
	fi
done

#echo "work_path is $work_path"

#cd "$path_name/"
#sleep 1
#echo "work_path is $now_path"
