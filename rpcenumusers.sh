#/bin/bash
#
# Usage: ./rpcenumusers.sh ip_dc domain users_file
#

dc="$1"
user="$3"
domain="$2"
date=`date`


function test(){
  echo""

  for user in `cat $user`
  do
    echo "[                 $date                 ]"
    echo "$dc $user $domain" 
    rpcclient $dc -U "%" -c "dsr_getdcnameex2 $user 512 $domain" 
  done

  echo ""
}

test >> users-$domain.dump
echo ""
echo " [    $domain - $date    ] "
echo ""
cat users-$domain.dump | grep -i1 DsRGetDCNameEx2 | grep $domain | cut -d" "  -f 2 | sort -u
echo ""


