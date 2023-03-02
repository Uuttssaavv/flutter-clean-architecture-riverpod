`echo "${2}"`==''
files=`echo "${2}"`
commitmessage=`echo "$1"`

echo "(${files}) ${commitmessage}"
# git add "${files}"
# git commit -m "${commitmessage}"