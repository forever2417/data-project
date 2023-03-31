<?php
$dbConnection = mysqli_connect("localhost","root","Aa95849685","php_gem");

//check the connection success or not
if (mysqli_connect_error()){
    echo "Failed to connect to MYSQL: ".mysqli_connect_error();
    exit();
}
