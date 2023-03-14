<?php include_once('header.php');?>
<script>
function previewFile() {
  var preview = document.querySelector('#imageUpload');
  var file = document.querySelector('input[type=file]').files[0];
  var reader = new FileReader();

  reader.addEventListener("load", function () {
    preview.src = reader.result;
    preview.width = 200;
    preview.height = 200;
  }, false);

  if (file) {
    reader.readAsDataURL(file);
  }
}

</script>
<h2>Add product</h2>


<div style="margin-left: auto;">
<form method="POST" action="functions.php?op=addProduct" enctype="multipart/form-data">
    <br/><br/>
    <div class="formInput">
        <label for="product_name">Name :</label>
        <input type="text" id="product_name" name="product_name" class="adidas-textbox"><br>

        <label for="price">Price :</label>
        <input type="number" id="price" name="price" class="adidas-textbox"><br>

        <label for="category">Category :</label>
        <input type="text" id="category" name="category" class="adidas-textbox"><br>

        <label for="quantity">Quantity :</label>
        <input type="number" id="quantity" name="quantity" class="adidas-textbox"><br>
        <br/><br/>
    </div>
  <div class="upload-btn-wrapper">

    <label for="file-upload" class="btn" style="text-align:center;">Upload image </label> <br/>
    <input type="file" name="file-upload" onchange="previewFile()" accept="image/*">
    <img id="imageUpload">
  </div>

  <br/>
  

<!-- <input id="file-upload" type="file" name="file-upload"> -->
<br/><br/>
<input type="submit" value="submit" class="adidas-submit-btn">

</form>
</div>


<?php include_once('footer.php'); ?>