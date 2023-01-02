<?php include_once 'header.php';?>

<form action="functions.php?op=createOrder" method="post">

    <?php
    $sel_prod = mysqli_query($dbConnection, "SELECT * FROM `products` WHERE `product_id`=". $_GET["p_id"]);
    $product = mysqli_fetch_assoc($sel_prod);
    ?>
    <input type="hidden" id="product_id" name="product_id" 
    value="<?php echo $product['product_id'];?>">

     <h2>Please place your order!</h2>
    <h3><?php echo $product['name'];?></h3>  

    <!-- product image -->
    <?php echo
    "<img src=\"images/products/".$product["image"]."\" style=\"box-shadow: 2px 2px 2px grey;margin-top:10px;margin-bottom:10px;\"; alt=\"product-image\">";
    ?>

    <!-- customer info -->
    </br></br>
    <label for="name">Your name:</label>
    <input type="text" id="name" name="name" require><br/>

    <label for="email">Your email:</label>
    <input type="email" id="email" name="email" require><br/>
    <div style="margin-right: 120px;">
    <label for="phone">Your phone number:</label>
    <input type="tel" id="phone" name="phone" pattern="[0-9]{8}"  require><br/>
    </div>


    <!-- order info -->
    <div style="padding-right: 85px;">
    <label for="quantity">Quantity <?php echo "(".$product['remaining']." in-stock now):";?></label>
    <input type="number" id="quantity" name="quantity" min="1"
    max="<?php echo $product['remaining'];?>" value="1">
    </div>
    <br>
    
    <input class="buyBtn" type="submit" value="Order">
    
</form>

<?php include_once 'footer.php';?>