#!/bin/bash
LABRI_SERVER=ssh.labri.fr
USER=dbourass
prompt="Please select a printer:"
options=( $(ssh -o "BatchMode yes" $USER@$LABRI_SERVER 'lpstat -p -d|sed -rn "s/printer ([^ ]*) .*$/\1/p"|uniq') )

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


-o sides=two-sided-long-edge

prompt="Please select a file:"
options=( $(find -maxdepth 1 -type f -name "*.pdf"  -print0| xargs -0|grep "\.pdf") )
PS3="$prompt "
select file in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $file which is file $REPLY"
        break

    else
        echo "Invalid option. Try another one."
    fi
done    


prompt="Two sided?"
options=( $(echo "Y N"|xargs -0) )
PS3="$prompt "
select twosided in "${options[@]}" "Quit" ; do 
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
		echo "file is beeing copied to remote server"
        scp -q $file $USER@$LABRI_SERVER:. 
        echo "file copied"
        echo "printing launched"
        if [ "$twosided" = "Y" ]; then
			ssh -o "BatchMode yes" $USER@$LABRI_SERVER "lpr -P $opt '$file' -o media=A4 -o sides=two-sided-long-edge"
		else
			ssh -o "BatchMode yes" $USER@$LABRI_SERVER "lpr -P $opt '$file' -o media=A4"
		fi
			echo "File removed from remote server. Now go get your dead trees."
			ssh -o "BatchMode yes" $USER@$LABRI_SERVER "rm '$file'"
        break

    else
        echo "Invalid option. Try another one."
    fi
done   


