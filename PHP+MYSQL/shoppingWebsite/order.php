<?php include_once 'header.php';?>

<form action="functions.php?op=createOrder" method="post">

    <?php
    $sel_prod = mysqli_query($dbConnection, "SELECT * FROM `products` WHERE `product_id`=". $_GET["p_id"]);
    $product = mysqli_fetch_assoc($sel_prod);
    ?>

    <input type="hidden" id="product_id" name="product_id" 
    value="<?php echo $product['product_id'];?>">

     <h2>Please place your order!</h2>

    <h3><?php echo $product['product_name'];?></h3>  

    <!-- product image -->
    <?php echo "<img src=\"images/products/".$product["image"]."\" alt=\"product-image\">";?>

    <!-- customer info -->
    </br></br>
    <div class="formInput">
        <label for="name">Name :</label>
        <input type="text" id="name" name="name" class = "adidas-textbox" require><br/>

        <label for="email">Email :</label>
        <input type="email" id="email" name="email" class = "adidas-textbox" require><br/>
        <!-- <div style="margin-right: 120px;"> -->
        <label for="phone">Phone NO. :</label>
        <input type="tel" id="phone" name="phone" class = "adidas-textbox" pattern="[0-9]{8}"  require><br/>


        <!-- order info -->
        <label for="quantity">Quantity<br> <?php echo "(".$product['remaining']." in-stock):";?></label>
        <input type="number" id="quantity" name="quantity" min="1"
        max="<?php echo $product['remaining'];?>" value="1" class = "adidas-textbox">
    </div>
    <br/>
    
    <input class="adidas-btn" type="submit" value="Order">
    
</form>

<?php include_once 'footer.php';?>