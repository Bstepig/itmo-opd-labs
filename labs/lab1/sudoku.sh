#!/bin/bash
declare -A matrix
declare -A temp_matrix
declare -A task_matrix
AREAS=2
SIZE=$(($AREAS * $AREAS))
shuffles=200
total_kills=8
kills=0

init_matrix() {	
	for ((i=1;i<=SIZE;i++)) do
	    for ((j=1;j<=SIZE;j++)) do
	        matrix[$i,$j]=$((($i+($j-1)/ $AREAS+($j-1)* $AREAS-1)%($SIZE)+1))
	    done
	done
}

copy_temp_matrix() {	
	for ((i=1;i<=SIZE;i++)) do
	    for ((j=1;j<=SIZE;j++)) do
	        temp_matrix[$i,$j]=${task_matrix[$i,$j]}
	    done
	done
}

copy_task_matrix() {	
	for ((i=1;i<=SIZE;i++)) do
	    for ((j=1;j<=SIZE;j++)) do
	        task_matrix[$i,$j]=${matrix[$i,$j]}
	    done
	done
}

dashes_in_output=''
for ((i=1;i<=${#SIZE};i++)) do
    dashes_in_output=$dashes_in_output'—'
done

print_border_line() {
	printf "—"
	for ((i=1;i<=SIZE;i++)) do
	    printf "—%s——" $dashes_in_output
	done
	echo
}

print_delimeter_line() {
	printf "+"
	for ((i=1;i<=SIZE;i++)) do
	    printf "—%s—+" $dashes_in_output
	done
	echo
}

print_empty_line() {
	printf "|"
	for ((i=1;i<=SIZE;i++)) do
	    printf " %*s |" ${#SIZE} ''
	done
	echo
}

print_grid() {

	print_border_line

	for ((j=1;j<=SIZE;j++)) do
		print_empty_line
	    printf '|'
	    for ((i=1;i<=SIZE;i++)) do
	        printf " %*s |" ${#SIZE} ${matrix[$i,$j]}
	    done
	    echo
	    print_empty_line
	    print_delimeter_line
	done
}

print_temp_grid() {

	print_border_line

	for ((j=1;j<=SIZE;j++)) do
		print_empty_line
	    printf '|'
	    for ((i=1;i<=SIZE;i++)) do
	        printf " %*s |" ${#SIZE} ${temp_matrix[$i,$j]}
	    done
	    echo
	    print_empty_line
	    print_delimeter_line
	done
}


print_task_grid() {

	print_border_line

	for ((j=1;j<=SIZE;j++)) do
		print_empty_line
	    printf '|'
	    for ((i=1;i<=SIZE;i++)) do
	    	if ((${task_matrix[$i,$j]}==0)); then
		    	out_char=' '
		    else
		    	out_char=${task_matrix[$i,$j]}
		    fi
	        printf " %*s |" ${#SIZE} $out_char
	    done
	    echo
	    print_empty_line
	    print_delimeter_line
	done
}

transpose() {
	local i
	local j
	for ((i=1;i<=SIZE;i++)) do
	    for ((j=$i+1;j<=SIZE;j++)) do
	        local temp=${matrix[$j,$i]}
	        matrix[$j,$i]=${matrix[$i,$j]}
	        matrix[$i,$j]=$temp
	    done
	done
}

swap_rows_small() {
	local area=$(($RANDOM % $AREAS))
	local line1=$(($RANDOM % $AREAS))
	local line2=$((($line1 + 1 + ($RANDOM % ($AREAS-1))) % $AREAS))

	local n1=$(($area*$AREAS+$line1+1))
	local n2=$(($area*$AREAS+$line2+1))

	local i
	for ((i=1;i<=SIZE;i++)) do
	    local temp=${matrix[$i,$n1]}
	    matrix[$i,$n1]=${matrix[$i,$n2]}
	    matrix[$i,$n2]=$temp
	done
}

swap_columns_small() {
	local area=$(($RANDOM % $AREAS))
	local line1=$(($RANDOM % $AREAS))
	local line2=$((($line1 + 1 + ($RANDOM % ($AREAS-1))) % $AREAS))

	local n1=$(($area*$AREAS+$line1+1))
	local n2=$(($area*$AREAS+$line2+1))

	local i
	for ((i=1;i<=SIZE;i++)) do
	    local temp=${matrix[$n1,$i]}
	    matrix[$n1,$i]=${matrix[$n2,$i]}
	    matrix[$n2,$i]=$temp
	done
}

swap_rows_area() {
	local area1=$RANDOM
	local area2=$((($area1 + 1 + ($RANDOM % ($AREAS-1)))))

	area1=$((($area1 % $AREAS) * $AREAS))
	area2=$((($area2 % $AREAS) * $AREAS))

	local i
	local j
	for ((j=1;j<=AREAS;j++)) do
		for ((i=1;i<=SIZE;i++)) do
		    local temp=${matrix[$i,$(($area1 + $j))]}
		    matrix[$i,$(($area1 + $j))]=${matrix[$i,$(($area2 + $j))]}
		    matrix[$i,$(($area2 + $j))]=$temp
		done
	done
}

swap_colums_area() {
	local area1=$RANDOM
	local area2=$((($area1 + 1 + ($RANDOM % ($AREAS-1)))))

	area1=$((($area1 % $AREAS) * $AREAS))
	area2=$((($area2 % $AREAS) * $AREAS))

	local j
	local i
	for ((j=1;j<=AREAS;j++)) do
		for ((i=1;i<=SIZE;i++)) do
		    local temp=${matrix[$(($area1 + $j)),$i]}
		    matrix[$(($area1 + $j)),$i]=${matrix[$(($area2 + $j)),$i]}
		    matrix[$(($area2 + $j)),$i]=$temp
		done
	done
}

execute_random_shuffle() {
	local cmds=( "transpose" "swap_rows_small" "swap_columns_small" "swap_rows_area" "swap_colums_area" )
	local i=$(( RANDOM % ${#cmds[@]} ))
	${cmds[$i]}
}

check_temp_matrix_any_row_is_solution() {
	for ((i=1; i<=$SIZE; i++)) do
		local num=$(((1<<$SIZE)-1))
		for ((j=1; j<=$SIZE; j++)) do
			num=$((num-(1<<${temp_matrix[$i,$j]}-1)))
		done
		if (( $num != 0 )); then
				return 1
		fi
	done
	return 0
}

check_temp_matrix_any_column_is_solution() {
	for ((i=1; i<=$SIZE; i++)) do
		local num=$(((1<<$SIZE)-1))
		for ((j=1; j<=$SIZE; j++)) do
			num=$((num-(1<<${temp_matrix[$j,$i]}-1)))
		done
		if (( $num != 0 )); then
			return 1
		fi
	done
	return 0
}

check_temp_matrix_any_sqaure_is_solution() {
	for ((i=0; i<$SIZE; i++)) do
		local num=$(((1<<$SIZE)-1))
		for ((j=0; j<$SIZE; j++)) do
			offset_x=$(($i % $AREAS))
			offset_y=$(($i / $AREAS))
			x=$(($offset_x * $AREAS + $j % $AREAS + 1))
			y=$(($offset_y * $AREAS + $j / $AREAS + 1))
			num=$((num-(1<<${temp_matrix[$x,$y]}-1)))
		done
		if (( $num != 0 )); then
			return 1
		fi
	done
	return 0
}

check_temp_matrix_is_solution() {
	if ! check_temp_matrix_any_row_is_solution; then
		return 1
	elif ! check_temp_matrix_any_column_is_solution; then
		return 1
	elif ! check_temp_matrix_any_sqaure_is_solution; then
		return 1
	fi
	return 0
}

kill_somebody() {
	while ! try_to_kill_somebody; do :; done
}

try_to_kill_somebody() {
	local i=$((($RANDOM % $SIZE) + 1))
	local j=$((($RANDOM % $SIZE) + 1))
	if [[ ${task_matrix[$i,$j]} == 0 ]]; then
		return 1
	fi
	local lost_value=${task_matrix[$i,$j]}
	task_matrix[$i,$j]=0
	if is_only_one_solution; then
		(( kills++ ))
		return 0
	else
		task_matrix[$i,$j]=lost_value
		return 1
	fi
}

is_only_one_solution() {
	local k
	local i
	local j
	local counter=0
	local max_number=1
	copy_temp_matrix
	for ((k=1;k<=$SIZE;k++)) do
		(( max_number*=$kills ))
	done
	for ((k=1;k<=$max_number;k++)) do
		local num=$k
		for ((i=1;i<=$SIZE;i++)) do
			for ((j=1;j<=$SIZE;j++)) do
				if ((${task_matrix[$i,$j]} != 0)); then continue; fi
				temp_matrix[$i,$j]=$((($num % 9) + 1))
				(( num/= 9))
			done
		done
		if check_temp_matrix_is_solution; then
			(( counter++ ))
			echo $counter
			if (( counter>=2 )); then
				echo 'aaaa'
				return 1
			fi
		fi
	done
	return 0
}

init_matrix


for ((i=1; i<=$shuffles; i++)); do
	execute_random_shuffle
done

echo "Solution: "
print_grid

copy_task_matrix

while (($kills < $total_kills)); do
	kill_somebody
done

if check_temp_matrix_is_solution; then
	echo "wow"
fi

echo "Task: "
print_task_grid
