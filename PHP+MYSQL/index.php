<?php include_once('header.php'); ?>
    
    <div style="background-color:rgb(255, 255, 255);border-radius:12px;">
    <p style="text-align:center;">
    <img src="images/others/Adidas_Logo.png" alt="Adidas_Logo" class="staffImage" style="margin-bottom:20px"> 
    </p>
    <h1>Welcome to adidas online shop!</h1>
    <h2>New open discount!</h2>
    </div>
    <nav class="links" style="--items: 4">
    <a href="?cat=15&product_item=all">All</a>
    <a href="?cat=15&product_item=clothes">Clothes</a>
    <a href="?cat=15&product_item=shoes">Shoes</a>
    <a href="?cat=15&product_item=pants">Pants</a>
    
    </nav>
    
    <?php

        if (isset($_GET['cat'])){
            showProduct($dbConnection,$_GET['product_item']);
        } else {
            $productQ = mysqli_query($dbConnection, "SELECT * FROM `products`");
        }

        function showProduct($dbConnection,$product)
            {   
                GLOBAL $productQ;
  
                if ($product == 'all'){
                    $productQ = mysqli_query($dbConnection, "SELECT * FROM `products`");
                } else {
                    $productQ = mysqli_query($dbConnection, "SELECT * FROM `products` WHERE `category`= '".$product."'");
                }
            }    
    ?>

    <div class="flex-grid">
    <div class = "wrapper">
    <div class = "container">

        <div class = "product">
            <div class = "product-container">
                    <?php

                    while ($product = mysqli_fetch_assoc($productQ)){
                        echo '<div class = "product-item">
                                    <div class = "product-img" alt="product-image">

                                        <img src="images/products/'.$product['image'].'">
                                            <div>
                                                <a href="order.php?p_id='.$product['product_id'].'">
                                                <button type = "button" class = "add-btn">Order now!</button>
                                                </a>
                                                </div>
                                    </div>
                                    <span class = "product-content">
                                        <a href = "#" class = "product-title">'.$product['product_name'].'</a>

                                        <span class = "price">$' .$product['price'].'</span>    
                                    </span>      
                              </div>';
                        }
                    ?>           
            </div>
        </div>
    </div>
</div>
    </div>
<?php include_once('footer.php'); 
exit(); 
?>