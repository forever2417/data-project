<?php include_once('header.php'); ?>


<form action="functions.php?op=checkLogin" method="post">
  <img src="images/others/staff.png" alt="staff" class="staffImage" style="margin-bottom:20px;"> 
  <br>
  
  <label for="email" style="margin-top:10px; margin-right:45px;margin-bottom:45px;">Email:</label>
  <input type="email" id="email" name="email" require style =" height:20px;"><br>
  
  <label for="password" class="login">Password:</label>
  <input type="password" id="password" name="password" style =" height:20px;">
  
  <br>
  <input type="submit" value="Login"style="height:30px; width:100px; font-size: 20px;">

  <p style="text-align: center;">For demo use: <br> 
    email:Tom@gmail.com <br> 
    password: abcabc <br>
  </p>
</form> 

<?php include_once('footer.php'); ?>