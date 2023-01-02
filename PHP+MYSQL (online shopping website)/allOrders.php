<?php include_once('header.php'); 
include_once('functions.php');
if(!isStaff()) header("Location: ");
?>

<h1>Order list</h1>

<?php

    $orderQ = mysqli_query($dbConnection,"SELECT * FROM `order`");
    // $orderData = file_get_contents('data.csv');
    // $orders = str_getcsv($orderData,"\r\n");
    
    while ($order = mysqli_fetch_assoc($orderQ)){
        
        $productQ = mysqli_query($dbConnection, 'SELECT * FROM `products` WHERE product_id='.$order['product_id']);
        $product = mysqli_fetch_assoc($productQ);
        
        echo '<div class="order" style="margin-bottom:10px;"><p>';
        echo 'Client\'s name : '.$order['client_name'].'<br/>';
        echo 'Client\'s email : '.$order['client_email'].'<br/>';
        echo 'Ordered items: '.$product['name'].' <br/>';
        echo 'Quantity : '.$order['quantity'].' <br/>';
        echo 'Placed order of time：'.$order['order_time'].'<br/>';
        echo '</p></div>';
    }
    // foreach($orders as $order)
    // {   
    //     $singleOrder = explode(",",$order);
        
    //     echo '<div class="order"><p>';
    //     echo '客戶稱呼：'.$singleOrder[1].'<br/>';
    //     echo '客戶電郵：'.$singleOrder[2].'<br/>';
    //     echo '想預訂：'.$gems[$singleOrder[0]-1]['name'].$singleOrder[3].'件 <br/>';
    //     echo '下單時間：'.$singleOrder[4].'<br/>';
    //     echo '</p></div>';
    // }

?>
<?php include_once('footer.php'); ?>