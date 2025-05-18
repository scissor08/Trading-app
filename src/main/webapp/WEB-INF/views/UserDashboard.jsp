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
 div{
        display: grid;
        grid-template-columns: 1fr 4fr;
        grid-template-rows: 1fr 4fr 1fr;
        grid-template-areas: 
        "header header"
        "aside main"
        "footer footer"; 
       }
       
header{
    height: 200px;
    grid-area: header;
    background-color: var(--onclick);
    width: 100%;
    color: var(--back);
}
header input{
    width: 200px;
    position: absolute;
    margin-left: 50%;
    transform: translateX(-50%);
    padding: 5px;
    border-radius: 5px;
}
header h2{
    width: 200px;
    font-size: 24px;
    margin-top: 80px;
    margin-left: 50%;
    transform: translateX(-50%);
    display:inline-block;
}
header div{
    border: 1px solid black;
    padding: 40px;
    width: 250px;
    height: 150px;
    display:inline-block;
    position: absolute;
  margin-top: 40px;
  margin-left: 100px;
}
header div h3{
    margin-bottom: 20px;
    text-align: center;
}
header div p{
    text-align: center;
    margin-bottom: 10px;
}
header div a{
    text-align: center;
    color: var(--back);
    margin-left: 25%;
    text-decoration: none;
    border: 1px solid black;
    padding: 2px;
}
aside{
    grid-area: aside;
    background-color: var(--light);
    display: flex;
    flex-direction: column;
    height: 100%;
}
main{
   grid-area: main;
    width: 100%;
    padding: 100px;
    background-color: var(--back);
}
footer{
    grid-area: footer;
    background-color: var(--onclick);
}
li{
  padding: 20px;
  font-size: 20px;
  text-align: center;
  box-shadow: 1px 1px ;
}
li:hover{
    background-color: var(--before-click);
}
a{
    padding: 20px 100px;
    text-decoration: none;
    text-transform:capitalize;
}

</style>
</head>
<body>
    <div>
   <header>
    <input type="text" placeholder="search"> 
    <h2>WELCOME ${username}</h2>
    <div>
        <h3>Wallet Balance</h3>
        <p>${balance}</p>
        <a href="">Add Balance</a>
        
    </div>    
   </header>
   <aside>
        <ul>
           <li><a href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/user/dashBoard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}">Portfolio</a></li>
            <li><a href="${pageContext.request.contextPath}/api/stocks/view">Stocks</a></li>
            <li><a href="${pageContext.request.contextPath}">Buy/Sell</a></li>
            <li><a href="${pageContext.request.contextPath}">Trasaction</a></li>
            <li><a href="${pageContext.request.contextPath}">Wallet</a></li>
            <li><a href="${pageContext.request.contextPath}/user/logout">Log Out</a></li>
            
        </ul>
   </aside>
   <main>
   </main>
   <footer>
   </footer>
</div>
</body>
</html>