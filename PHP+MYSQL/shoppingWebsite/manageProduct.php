<?php include_once('header.php');?>

<!-- display all products -->
<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Price</th>
            <th>Category</th>
            <th>Quantity</th>
            <th>Image</th>
            <th>Action</th>
        </tr>
    </thead>
    
    <tbody>
        <?php
        $result = mysqli_query($dbConnection, "SELECT * FROM products");

        while ($row = mysqli_fetch_assoc($result)) {
            $id = $row['product_id'];
            $name = $row['product_name'];
            $price = $row['price'];
            $category = $row['category'];
            $quantity = $row['remaining'];
            $image = $row['image'];
        ?>
        
        <tr>
            <td><?php echo $name; ?></td>
            <td><?php echo $price; ?></td>
            <td><?php echo $category; ?></td>
            <td><?php echo $quantity; ?></td>
            <td><img src="images/products/<?php echo $image; ?>" alt="<?php echo $name; ?>" width="200"></td>
            <td>
                <a href="editProduct.php?id=<?php echo $id; ?>">Edit</a> |
                <a href="functions.php?op=deleteProduct&id=<?php echo $id; ?>" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
            </td>
        </tr>
        <?php } ?>
    </tbody>
</table>

<?php include_once('footer.php'); ?>