<?php include_once('header.php'); ?>


<form action="functions.php?op=checkLogin" method="post">
  <img src="images/others/Adidas_Logo.png" alt="logo" class="staffImage" style="margin-bottom:20px;"> 
  <br><br>
  <div class="formInput">
  <label for="email" >Email:</label>
  <input type="email" id="email" name="email" class="adidas-textbox" require style =" height:20px;"><br>
  
  <label for="password" class="login">Password:</label>
  <input type="password" id="password" name="password" class="adidas-textbox" style =" height:20px;">
  </div>
  <br>
  <input type="submit" value="Login" class="adidas-btn">

  <p style="text-align: center;">For demo use: <br> 
    email:Tom@gmail.com <br> 
    password: abcabc <br>
  </p>

  
</form> 

<?php include_once('footer.php'); ?>