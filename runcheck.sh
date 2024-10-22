mkdir ./tmp -p

curl https://${1} -k -v -s -o /dev/null 2> ./tmp/ca.info

cat ./tmp/ca.info | grep 'start date: ' > ./tmp/${1}.info
cat ./tmp/ca.info | grep 'expire date: ' >> ./tmp/${1}.info
cat ./tmp/ca.info | grep 'issuer: ' >> ./tmp/${1}.info
cat ./tmp/ca.info | grep 'SSL certificate verify' >> ./tmp/${1}.info
cat ./tmp/ca.info | grep 'subject: ' >> ./tmp/${1}.info

# Ubuntu 18.04
sed -i 's|\* [\t]* start date: ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* expire date: ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* issuer: ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* SSL certificate verify ||g' ./tmp/${1}.info
sed -i 's|\* [\t]* subject: ||g' ./tmp/${1}.info

# Aliyun CentOS 7
# sed -i 's/\* \tstart date: //g' ./tmp/${1}.info
# sed -i 's/\* \texpire date: //g' ./tmp/${1}.info
# sed -i 's/\* \tissuer: //g' ./tmp/${1}.info
# sed -i 's/\* \tSSL certificate verify //g' ./tmp/${1}.info
# sed -i 's/\* \tsubject: //g' ./tmp/${1}.info

start=$(sed -n '1p' ./tmp/${1}.info)
expire=$(sed -n '2p' ./tmp/${1}.info)
issuer=$(sed -n '3p' ./tmp/${1}.info)

# Ubuntu
status=$(sed -n '4p' ./tmp/${1}.info)
subject=$(sed -n '5p' ./tmp/${1}.info)

# Aliyun CentOS 7
# subject=$(sed -n '4p' ./tmp/${1}.info)


rm -f ./tmp/ca.info
rm -f ./tmp/${1}.info

DATE="$(echo $(date '+%Y-%m-%d %H:%M:%S'))"

nowstamp="$(date -d "$DATE" +%s)"
expirestamp="$(date -d "$expire" +%s)"

expireday=$((expirestamp-nowstamp))
expireday=$((expireday/86400))

# expireday=`expr $[expirestamp-nowstamp] / 86400`

echo '{' > tmp/${1}.json
echo '"domain": "'${1}'",' >> ./tmp/${1}.json
echo '"subject": "'$subject'",' >> ./tmp/${1}.json
echo '"start": "'$start'",' >> ./tmp/${1}.json
echo '"expire": "'$expire'",' >> ./tmp/${1}.json
echo '"issuer": "'$issuer'",' >> ./tmp/${1}.json
echo '"check": "'$DATE'",' >> ./tmp/${1}.json
echo '"remain": "'$expireday'",' >> ./tmp/${1}.json

# Ubuntu
if [ $expirestamp \< $nowstamp ]; then
    echo '"status": "Expired",' >> ./tmp/${1}.json
    echo '"statuscolor": "error"' >> ./tmp/${1}.json
elif [ $expireday \< 10 ]; then
    echo '"status": "Soon Expired",' >> ./tmp/${1}.json
    echo '"statuscolor": "warning"' >> ./tmp/${1}.json
elif [ $status = "ok." ]; then
    echo '"status": "Valid",' >> ./tmp/${1}.json
    echo '"statuscolor": "success"' >> ./tmp/${1}.json
else
    echo '"status": "Invalid",' >> ./tmp/${1}.json
    echo '"statuscolor": "error"' >> ./tmp/${1}.json
fi

# Aliyun CentOS 7
# if [ $expirestamp \< $nowstamp ]; then
#     echo '"status": "Expired",' >> ./tmp/${1}.json
#     echo '"statuscolor": "error"' >> ./tmp/${1}.json
# elif [ $expireday \< 10 ]; then
#     echo '"status": "Soon Expired",' >> ./tmp/${1}.json
#     echo '"statuscolor": "warning"' >> ./tmp/${1}.json
# else
#     echo '"status": "Valid",' >> ./tmp/${1}.json
#     echo '"statuscolor": "success"' >> ./tmp/${1}.json
# fi

echo '}' >> ./tmp/${1}.json

cp -rf ./tmp/${1}.json ./results/${1}.json
rm -rf ./tmp