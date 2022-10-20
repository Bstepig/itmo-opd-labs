# 1 Black        0;30     9 Dark Gray     1;30
# 2 Red          0;31     10 Light Red     1;31
# 3 Green        0;32     11 Light Green   1;32
# 4 Brown/Orange 0;33     12 Yellow        1;33
# 5 Blue         0;34     13 Light Blue    1;34
# 6 Purple       0;35     14 Light Purple  1;35
# 7 Cyan         0;36     15 Light Cyan    1;36
# 8 Light Gray   0;37     16 White         1;37

colors=(
	'0;30' '0;31' '0;32' '0;33' '0;34' '0;35' '0;36' '0;37'
	'1;30' '1;31' '1;32' '1;33' '1;34' '1;35' '1;36' '1;37'
)

IFS=' ' read -r size_x size_y < image01.bmp

matrix=$( tail -n +2 image01.bmp )
while IFS=' ' read -ra demi; do
	for ((i=0;i<$size_y;i++)) do
		if ((${demi[i]} == 0)); then printf " "
		else
			k=$((${demi[$i]}+1))
			t=${colors[$k]}
			line="\e[${t}m█\e[0m";
			printf $line
		fi
	done
	printf "\n"
done <<< $matrix
