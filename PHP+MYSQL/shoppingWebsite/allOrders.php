<?php include_once('header.php'); 
include_once('functions.php');
if(!isStaff()) header("Location: ");
?>


<?php
  // Retrieve order data from database
  $orderQ = mysqli_query($dbConnection,"SELECT * FROM `order`");

  // Retrieve product data from database
  $productQ = mysqli_query($dbConnection, 'SELECT * FROM `products`');

  // Create an array of product names and IDs
  $products = array();
  while ($product = mysqli_fetch_assoc($productQ)) {
    $products[$product['product_id']] = $product['product_name'];
  }

  // Process filter and sort parameters
  $filter = isset($_GET['filter']) ? $_GET['filter'] : '';
  $sort = isset($_GET['sort']) ? $_GET['sort'] : '';

  // Create a new array of orders with product name included
  $orders = array();
  while ($order = mysqli_fetch_assoc($orderQ)){
    $order['product_name'] = $products[$order['product_id']];
    $orders[] = $order;
  }

  // Filter the orders based on filter parameter
  if ($filter != '') {
    $filtered_orders = array();
    foreach ($orders as $order) {
      if ($order['client_name'] == $filter || $order['client_email'] == $filter || $order['product_name'] == $filter) {
        $filtered_orders[] = $order;
      }
    }
    $orders = $filtered_orders;
  }

  // Sort the orders based on sort parameter
  if ($sort != '') {
    usort($orders, function($a, $b) use ($sort) {
      if ($a[$sort] < $b[$sort]) {
        return -1;
      } else if ($a[$sort] > $b[$sort]) {
        return 1;
      } else {
        return 0;
      }
    });
  }
?>

<h1>Order list</h1>

<form method="get">
  <label for="filter">Keywords search:</label>
  <input type="text" name="filter" id="filter" class="adidas-textbox" style="text-transform:none;" value="<?php echo $filter; ?>">
  <button type="submit" class="adidas-btn" style="padding: 8px 17px; font-size:15px;">Go</button>

  <label for="sort">Sort by:</label>
  <select name="sort" id="sort">
    <option value="">-- Select --</option>
    <option value="client_name" <?php echo $sort == 'client_name' ? 'selected' : ''; ?>>Client name</option>
    <option value="client_email" <?php echo $sort == 'client_email' ? 'selected' : ''; ?>>Client email</option>
    <option value="product_name" <?php echo $sort == 'product_name' ? 'selected' : ''; ?>>Product name</option>
    <option value="quantity" <?php echo $sort == 'quantity' ? 'selected' : ''; ?>>Quantity</option>
    <option value="order_time" <?php echo $sort == 'order_time' ? 'selected' : ''; ?>>Order time</option>
  </select>
  <button type="submit" class="adidas-btn" style="margin:10px;padding: 8px 17px; font-size:15px;">Sort</button>
</form>

<table>

  <thead>
    <tr>
      <th>Client's name</th>
      <th>Client's email</th>
      <th>Ordered item</th>
      <th>Quantity</th>
      <th>Order time</th>
    </tr>
  </thead>

  <tbody>
    <?php
      foreach ($orders as $order) {
        echo '<tr>';
        echo '<td>'.$order['client_name'].'</td>';
        echo '<td>'.$order['client_email'].'</td>';
        echo '<td>'.$order['product_name'].'</td>';
        echo '<td>'.$order['quantity'].'</td>';
        echo '<td>'.$order['order_time'].'</td>';
        echo '</tr>';
        }
        ?>    
  </tbody>
  
</table>
    

<?php include_once('footer.php'); ?>