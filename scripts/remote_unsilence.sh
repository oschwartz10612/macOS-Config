#!/bin/bash

wait_running() {
IP=$(gcloud compute instances describe remote --zone us-east4-c --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
if nc -w 1 -z $IP 22; then
    echo "OK! Ready for heavy metal"
    : Do your heavy metal work
else
    printf "."
    wait_running
fi
}

if gcloud compute instances describe 'remote' --zone 'us-east4-c' | grep -q "status: RUNNING" ; 
then
    echo "Instance running..."
else
    echo "Instance not started"
    read -p "Would you like to start the instance? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        gcloud compute instances start remote --zone=us-east4-c
        wait_running
    else
        exit 0
    fi
fi

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "options:"
      echo "-h, --help                              show brief help"
      echo "-u, --unsilence file                    unsilence file"
      echo "-c, --copy file_1 OR file_1 local_dest  copy files"
      echo "--ssh                                   ssh into the instance"
      echo "--stop                                  stop the instance"

      exit 0
      ;;
    -u|--unsilence)
      shift
      if test $# -gt 0; then
        
        gcloud compute scp --ssh-key-file=~/.ssh/remote_unsilence $1 remote:~ --zone=us-east4-c
        gcloud compute ssh --ssh-key-file=~/.ssh/remote_unsilence remote --zone=us-east4-c -- "/home/owenschwartz/.local/bin/unsilence $1 unsilenced_$1 -t 16 -y"
        gcloud compute scp --ssh-key-file=~/.ssh/remote_unsilence remote:~/unsilenced_$1 ./ --zone=us-east4-c

        exit 0
      else
        echo "no file specified"
        exit 1
      fi
      shift
      ;;
    -c|--copy)
        if test $# -gt 0; then
            if [[ -n "$2" ]]
            then
                echo "Transfering $1 from instance to $2..."
                gcloud compute scp remote:~/$1 $2 --zone=us-east4-c
            else
                if [[ -n "$1" ]]
                then
                    echo "Transfering $1 to instance..."
                    gcloud compute scp $1 remote:~ --zone=us-east4-c
                fi
            fi

            exit 0
        else
            echo "no file specified"
            exit 1
        fi
        shift
        ;;
    --ssh)
      shift
        gcloud compute ssh --ssh-key-file=~/.ssh/remote_unsilence remote --zone=us-east4-c
      shift
      ;;
    --stop)
        shift
            gcloud compute instances stop remote --zone=us-east4-c
        shift
      ;;
    *)
      break
      ;;
  esac
done

