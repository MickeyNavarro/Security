# Almicke Navarro
# CST-221
# December 15, 2019

# Counter variable.
x=0

# Read password.
read -p "Please enter a password to test: " password;

passwordLength=${#password}
if (("$passwordLength" < "8")); then
	echo 'Your password must be at least 8 characters long.'
else
	let "x++"
fi

if [[ $password =~ [0-9] ]]; then
	let "x++"
else
	echo 'Your password should have at least one number.'
fi

if [ $password | grep -c -E "[@#$%&*+-=]+" -eq 0 ]; then
	echo 'Your password should contain at least one special character.'
fi

if [ "$x" -eq "3" ]; then
	echo 'Your password is secure!'
fi