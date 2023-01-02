<?php
include_once "dbConnect.php";
$op ='none';
if(isset($_GET['op'])) $op = $_GET['op'];


if($op =='createOrder')
{
    if(empty($_POST['name']) ||empty($_POST['email'])) {
        
        echo '<script>alert("Name or email cannot be empty!");history.go(-1);</script>';
    
    } else {
        createOrder();
    }
}

if($op =='checkLogin')
{
    if(empty($_POST['email']) ||empty($_POST['password']) ) {
        echo '<script>alert("Please type your staff email or password!");history.go(-1);</script>';
    

    } else {
        checkLogin($_POST['email'],$_POST['password']);
    }
}
if($op =='logout')
{
    logout();
}

if($op == 'showcategory')
{
    echo $op.$cat;
    showProduct($dbConnection,$cat);
}

function isStaff()
{
  return isset($_SESSION['email']);
}
function logout()
{
    session_start();
    session_destroy();
    header("Location: /");
}
function checkLogin($email, $password){

    global $dbConnection;
    $staffQ = mysqli_query($dbConnection,"SELECT * FROM `Staff` WHERE `email`='".$email."'");
    $staff = mysqli_fetch_assoc($staffQ);
    // $staffEmail     =   "123@123.com";
    // $staffPassword  =   "123123";
    $hashedpw = password_hash("password123",PASSWORD_BCRYPT);

    if($email == $staff['email'] && password_verify($password,$staff['password']))
    {
        //verify the staff identity
        session_start();
        $_SESSION['email'] = $email;

        header("Location: allOrders.php");
    } else{
        echo '<script>alert("The email or password is invalid!");history.go(-1);</script>';
    }
}

function createOrder(){
    
    global $dbConnection;
    date_default_timezone_set('Asia/Hong_Kong');
    $sql = "INSERT INTO `php_gem`.`order` (
        `client_name`,
        `client_email`,
        `quantity`,
        `order_time`,
        `product_id`
        ) VALUES (
            '{$_POST['name']}',
            '{$_POST['email']}',
            {$_POST['quantity']},
            '".date('Y-m-d H:i:s')."',
            {$_POST['product_id']})";
    
    if(mysqli_query($dbConnection,$sql)){

        header("Location: /order-completed.php");
    }else{
        echo"cannot access the database";
    }
    /* order demo */
    // echo $_POST['gem_id']."<br>";
    // echo $_POST['name']."<br>";
    // echo $_POST['email']."<br>";
    // echo $_POST['quantity']."<br>";
    // echo date('Y-m-d H:i:s')."<br>";

    //order info

    //save the order
    // $myfile = fopen("data.csv","a") or die("未能開啟檔案");
    // $data = $_POST['gem_id'].','.$_POST['name'].','.$_POST['email'].','.$_POST['quantity'].','.date('Y-m-d H:i:s')."\r\n";
    // fwrite($myfile, $data);
    // fclose($myfile);
    // //change to another page
    // header("Location: order-completed.php");
}
