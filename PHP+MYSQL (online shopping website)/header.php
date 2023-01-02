<?php 

include 'dbConnect.php';?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="en-US">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product order</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
    /* body{
        background-image: linear-gradient(rgba(255,255,255,0.2), rgba(255,255,255,0.2)), url("images/others/bg.jpeg");
        background-repeat: no-repeat;
        background-size: cover;
    } */
</style>
</head>
<body>
<nav style="background-color:#828282;border-radius:12px;">
    <ul class="clientMenu">
        <li><a href="/">Home</a></li>
        <li><a href="about.php">About</a></li>
    </ul>
    <ul class="staffMenu">
    <?php 
    session_start();
    if(isset($_SESSION['email']))
    {    
        echo 
        '<li><img src="images/others/staff.png" alt="staff" class="staffImage" style="height:30px;width:30px"></li> 
        <li><a href="allOrders.php">All orders</a></li>
        <li><a href="functions.php?op=logout">logout</a></li>';
    } else{
        echo '<li><a href="login.php">Staff login</a></li>';
    }
    ?>
    </ul>
</nav>