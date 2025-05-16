<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Page</title>
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
            <form action="/user/register" method="post">
                <label for="username">User name</label>
                <input type="text" name="username" required>
                <label for="email">E-mail</label>
                <input type="email" name="email" required>
                <label for="mobile">Mobile No</label>
                <input type="number" name="mobile" required>
                <label for="password">Create Password</label>
                <input type="password" name="password" required>
                <label for="cpass">Confirm Password</label>
                <input type="password" name="cpass" required>
                <label for="pan">PAN Number</label>
                <input type="text" name="pan" required>
                <label for="dateOfBirth">Enter DOB</label>
                <input type="date" name="dateOfBirth" required>
                
                <button>Register</button>
            </form>
        </section>
    </main>

    <script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const username = document.querySelector('input[name="username"]').value.trim();
        const email = document.querySelector('input[name="email"]').value.trim();
        const mobile = document.querySelector('input[name="mobile"]').value.trim();
        const password = document.querySelector('input[name="password"]').value;
        const cpass = document.querySelector('input[name="cpass"]').value;
        const pan = document.querySelector('input[name="pan"]').value.trim();
        const dob = document.querySelector('input[name="dateOfBirth"]').value;

       
        if (username === "") {
            alert("Username cannot be blank.");
            e.preventDefault();
            return;
        }

        
        if (!email.endsWith(".com")) {
            alert("Email must end with .com");
            e.preventDefault();
            return;
        }

        
        const mobileRegex = /^[6-9]\d{9}$/;
        if (!mobileRegex.test(mobile)) {
            alert("Mobile number must be 10 digits, start with 6-9 and contain only numbers.");
            e.preventDefault();
            return;
        }

        
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@.,*&$/])[A-Za-z\d@.,*&$/]{8,}$/;
        if (!passwordRegex.test(password)) {
            alert("Password must be at least 8 characters long and include uppercase, lowercase, number, and symbol.");
            e.preventDefault();
            return;
        }

       
        if (password !== cpass) {
            alert("Confirm password must match the password.");
            e.preventDefault();
            return;
        }

       
        const panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
        if (!panRegex.test(pan)) {
            alert("PAN must be 10 characters: first 5 letters, next 4 digits, and last letter in uppercase.");
            e.preventDefault();
            return;
        }

      
        const dobDate = new Date(dob);
        const today = new Date();
        const minDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());

        if (dobDate > minDate) {
            alert("You must be at least 18 years old.");
            e.preventDefault();
            return;
        }
    });
    
   </script>

</body>
</html>