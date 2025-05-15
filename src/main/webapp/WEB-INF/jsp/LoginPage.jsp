<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
        :root {
  --back: #ccccff;
  --light: #a3a3cc;
  --before-click: #5c5c99;
  --onclick: #292966;
}
*{
    margin: 0%;
    padding: 0%;
    box-sizing: border-box;
}
header{
    height: 20%;
    width: 100%;
    background-color: var(--light);
    padding: 70px;
}
form{
    border: 1px solid;
   
    margin:100px 35% 0px 35%;
    padding: 50px;
    background-color: var(--light);
}
label{
    display: block;
    margin-top: 10px;
    font-size: 18px;
}
input{
    background-color: var(--back);

    font-size: 18px;
    padding: 10px;
}
button{
    display: block;
    margin-top: 20px;
   margin-left: 50%;
   transform: translateX(-50%);
   font-size: 16px;
   padding: 10px;
   background-color: var(--light);
   transition:all 300ms ease-in-out;
}
button:hover{
    background-color: var(--before-click);
    transform: scale3d();
}
    </style>
</head>
<body>
    <header> 
        <nav> </nav>
    </header>
    <main>
        <section>
            <form action="/user/login" method="Post">
                <label for="username">User name</label>
                <input type="text" name="username" required>
               
                <label for="password">Password</label>
                <input type="password" name="password">
                
                <button>Register</button>
            </form>
        </section>
    </main>

    <script>
        
    </script>

</body>
</html>