<?php 
echo password_hash("abcabc",PASSWORD_BCRYPT);
$hashedpw = password_hash("abcabc",PASSWORD_BCRYPT);

if (password_verify("password123",$hashedpw)){
    echo '<br> password is valid';
} else {
    echo '<br> password is invalid';
}
