<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Event Management Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Times New Roman', serif;
            background: url('https://st4.depositphotos.com/1003697/29426/i/600/depositphotos_294267928-stock-photo-interior-of-big-modern-conference.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .overlay {
            background: rgba(255, 255, 255, 0.1);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px 35px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            width: 350px;
            text-align: center;
        }

        .login-box h2 {
            font-size: 26px;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            display: block;
            margin-top: 15px;
            text-align: left;
            font-weight: bold;
            color: #222;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'Times New Roman', serif;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #4CAF50;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .register-links {
            margin-top: 20px;
            font-size: 14px;
        }

        .register-links a {
            color: #1a73e8;
            text-decoration: none;
            font-weight: bold;
        }

        .register-links a:hover {
            text-decoration: underline;
        }

        .error {
            color: red;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="overlay">
    <div class="login-box">
        <h2><i class="fas fa-sign-in-alt"></i> Login</h2>
        <form action="LoginServlet" method="post">
            <label><i class="fas fa-user"></i> Username:</label>
            <input type="text" name="username" required>

            <label><i class="fas fa-lock"></i> Password:</label>
            <input type="password" name="password" required>

            <input type="submit" value="Login">
        </form>

        <div class="register-links">
            <p>Don't have an account? <a href="Admin Registration.jsp">Register as Admin</a></p>
            <p>New Customer? <a href="Customer Registration.jsp">Register here</a></p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
    </div>
</div>
</body>
</html>
