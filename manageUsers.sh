# Almicke Navarro
# CST-221
# December 15, 2019

filename=$1
group=$2
operation=$3

#used to add users to a group
if [[ "$3" == "-a" ]]; then

$filename
while read -r username password
do
  name="$username"
	pass="$password"
	echo "Username: $name"
	echo "Password: $pass"

  if [ $(id -u) -eq 0 ]; then
		egrep "^$name" /etc/passwd >/dev/null
		if [ $? -eq 0 ]; then
			echo "$name exists!"
			exit 1
		else
			userad -m -p $pass $name
			[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add user."
		fi
	else
		echo "You must have root access to add users!"
		exit 2
	fi
	usermod -aG $group $name
done < "$filename"
fi

#used to remove user from a group
if [[ "$3" == "-r" ]]; then

$filename
while read -r username password
do
	name="$username"
	pass="$password"
	userdel -r $name
	echo "$name deleted."
done < "$filename"

if grep -q $group /etc/group
then
	groupdel $group
else
     	echo "Group does not exist."
fi

fi