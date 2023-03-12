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
        
        echo '<div class="order" style="margin-bottom:10px;"><ul id="client-list">';
        echo '<li>Client\'s name : '.$order['client_name'].'</li>';
        echo '<li>Client\'s email : '.$order['client_email'].'</li>';
        echo '<li>Ordered items: '.$product['product_name'].' </li>';
        echo '<li>Quantity : '.$order['quantity'].' </li>';
        echo '<li>Placed order of time：'.$order['order_time'].'</li>';
        echo '</ul></div>';
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