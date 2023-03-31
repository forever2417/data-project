<?php include_once('header.php');?>

<?php
// Connect to database and retrieve the product information

    if(isset($_GET['id'])) {
        $id = $_GET['id'];
        $sql = "SELECT * FROM products WHERE product_id = {$id}";
        $result = mysqli_query($dbConnection, $sql);
        $product = mysqli_fetch_assoc($result);
    }
?>

<form method="POST" action="functions.php?op=updateProduct" enctype="multipart/form-data">
    <br/><br/>
    <div class="formInput">
    
        <label for="product_name">Name :</label>
        <input type="text" id="product_name" name="product_name" class="adidas-textbox" value="<?php echo $product['product_name']; ?>"><br>
        
        <label for="price">Price :</label>
        <input type="number" id="price" name="price" class="adidas-textbox" value="<?php echo $product['price']; ?>"><br>

        <label for="category">Category :</label>
        <input type="text" id="category" name="category" class="adidas-textbox" value="<?php echo $product['category']; ?>"><br>

        <label for="quantity">Quantity :</label>
        <input type="number" id="quantity" name="quantity" class="adidas-textbox" value="<?php echo $product['remaining']; ?>"><br>

        <br/><br/>
    </div>

    <div class="upload-btn-wrapper">
        <label for="file-upload" class="btn" style="text-align:center;">Upload image </label> <br/>
        <input type="file" name="file-upload" onchange="previewFile()" accept="image/*">
        <img id="imageUpload">
    </div>
    <br/>

    <input type="hidden" name="id" value="<?php echo $product['product_id']; ?>">
    <input type="hidden" name="old_image" value="<?php echo $product['image']; ?>">
    <br/><br/>
    <input type="submit" value="submit" class="adidas-submit-btn">
    
</form>

<?php include_once('footer.php'); ?>