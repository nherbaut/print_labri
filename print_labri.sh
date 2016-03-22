#!/bin/bash
LABRI_SERVER=ssh.labri.fr
prompt="Please select a printer:"
options=( $(ssh -o "BatchMode yes" ssh.labri.fr 'lpstat -p -d|sed -rn "s/printer ([^ ]*) .*$/\1/p"|uniq') )

PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $opt which is file $REPLY"
        break

    else
        echo "Invalid option. Try another one."
    fi
done    

prompt="Please select a file:"
options=( $(find -maxdepth 1 -type f -name "*.pdf"  -print0| xargs -0|grep "\.pdf") )
PS3="$prompt "
select file in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $file which is file $REPLY"
        scp $file $LABRI_SERVER:.
        ssh -o "BatchMode yes" ssh.labri.fr "lpr -P $opt $file"
        break

    else
        echo "Invalid option. Try another one."
    fi
done    
