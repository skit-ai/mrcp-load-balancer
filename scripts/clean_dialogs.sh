mapfile -t lines < <(opensipsctl fifo dlg_list | grep "state:: 4" -B 1)

# 189048610703 

for (( c=0; c<=5; c+=3 ))
do
    if [[ ${lines[c]} =~ [0-9] ]]; then
        strresult=${BASH_REMATCH[1]}
    else
        echo "unable to parse string $strname"
fi
done

