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

if($op == 'addProduct') 
{
    // Prepare some variables for storing the product image into the folder
        $target_dir = "images/products/";
        $target_file = $target_dir.basename($_FILES["file-upload"]["name"]);
        $uploadOk = 1;
        $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

        $product_name = $_POST["product_name"];
        $price = $_POST["price"];
        $category = $_POST["category"];
        $quantity = $_POST["quantity"];

    // check all product information whether they are valid
    if (empty($_POST["product_name"]) || empty($_POST["price"]) || empty($_POST["category"]) || empty($_POST["quantity"])) {
        $productInfoOK = 0;
        echo '<script>alert("Some product information is missing!");history.go(-1);</script>';
    }
    else {
        // The new product text and number are ok and then check the image afterwards.
        $productInfoOK = 1;

                // Check if the user uploaded the image
                if(empty($_FILES["file-upload"]["tmp_name"])) {

                echo '<script>alert("Please upload the image!");history.go(-1);</script>';
                $uploadOk = 0;
                } else {    
                $check = getimagesize($_FILES["file-upload"]["tmp_name"]);

                if($check !== false) {
                    $uploadOk = 1;
                } else {
                    echo '<script>alert("The file is not an image!");history.go(-1);</script>';
                    $uploadOk = 0;
                    } 
                
                
                  // Check if the file exists
                  if (file_exists($target_file)) {
                    echo '<script>alert("The file is already exist!");history.go(-1);</script>';
                    $uploadOk = 0;
                  }
              
                  // Check if the file exceed the size
                  if ($_FILES["file-upload"]["size"] > 500000) {
                    echo '<script>alert("The file size is too large!");history.go(-1);</script>';
                    $uploadOk = 0;
                  }
              
                  // Check if the file is in the suitable format
                  if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
                  && $imageFileType != "gif" ) {
                    echo '<script>alert("Only JPG, JPEG, PNG and GIF format available!");history.go(-1);</script>';
                    $uploadOk = 0;
                  }
                }
    }
    if (($uploadOk == 1) && ($productInfoOK == 1)){
    
        $sql = "INSERT INTO `php_gem`.`products` (`product_name`, `price`,`image`,`category`, `remaining`) 
        VALUES ('{$product_name}', '{$price}', '{$_FILES["file-upload"]["name"]}', '{$category}','{$quantity}')";
    
//        move_uploaded_file($_FILES["file-upload"]["tmp_name"], $target_file);

        

        if(mysqli_query($dbConnection,$sql) && move_uploaded_file($_FILES["file-upload"]["tmp_name"], $target_file)){
            echo '<script>alert("New product is added!");
                 window.location.href = "/addProduct.php";</script>';
        }else{
            echo '<script>alert("Failed to add the product!");
                 window.location.href = "/addProduct.php";</script>';
    }
    }
}
if ($op == 'editProduct') {
    $id = $_POST["id"];
    $product_name = $_POST["product_name"];
    $price = $_POST["price"];
    $category = $_POST["category"];
    $quantity = $_POST["quantity"];

    $sql = "UPDATE products SET product_name='{$product_name}', price='{$price}', category='{$category}', remaining='{$quantity}' WHERE id='{$id}'";
    $result = mysqli_query($dbConnection, $sql);

    if ($result) {
        echo '<script>alert("Product updated successfully!");
             window.location.href = "/products.php";</script>';
    } else {
        echo '<script>alert("Failed to update the product!");
             window.location.href = "/products.php";</script>';
    }
}

if ($op == 'deleteProduct') {
    $product_id = $_GET['id'];
    // Delete product from database
    $sql = "DELETE FROM products WHERE product_id='{$product_id}'";
    
    if (mysqli_query($dbConnection, $sql)) {
    echo '<script>alert("Product deleted successfully!");
    window.location.href = "/manageProduct.php";</script>';
    } else {
    echo '<script>alert("Failed to delete product!");
    window.location.href = "/manageProduct.php";</script>';
    }
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

}
?>