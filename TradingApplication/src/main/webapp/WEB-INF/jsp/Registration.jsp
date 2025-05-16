<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Registration</title>
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
            <form action="/registration" method="post">
                <label for="username">User name</label>
                <input type="text" name="username" required>
                <label for="email">E-mail</label>
                <input type="email" name="email" required>
                <label for="mobile">Mobile No</label>
                <input type="number" name="mobile">
                <label for="password">Create Password</label>
                <input type="password" name="password">
                <label for="cpass">Confirm Password</label>
                <input type="password" name="cpass">
                <button>Register</button>
            </form>
        </section>
    </main>

    <script>

    </script>

</body>
</html>
