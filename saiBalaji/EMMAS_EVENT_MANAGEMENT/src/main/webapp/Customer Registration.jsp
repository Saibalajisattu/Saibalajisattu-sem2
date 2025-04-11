<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register as Customer - Event Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            margin: 0;
            font-family: 'Times New Roman', serif;
            background: url('https://st.depositphotos.com/2371073/2707/i/450/depositphotos_27071049-stock-photo-colourful-conference-room.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .overlay {
           background: rgba(255, 255, 255, 0.1);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-box {
            background: linear-gradient(to bottom right, #4b0082, #6a5acd); /* stylish purple gradient */
            padding: 40px;
            border-radius: 15px;
            max-width: 450px;
            width: 100%;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.3);
            color: white;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 26px;
            font-weight: bold;
            color: #fff;
        }

        label {
            font-weight: bold;
            font-size: 15px;
            display: block;
            margin-top: 15px;
            color: #eee;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-top: 5px;
            margin-bottom: 18px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-family: 'Times New Roman', serif;
            background: #f2f2f2;
            color: #333;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #ffd700;
            color: #000;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-family: 'Times New Roman', serif;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #ffc107;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }

        .footer a {
            color: #ffd700;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .error {
            color: #ffdddd;
            text-align: center;
            margin-top: 15px;
        }

        .icon {
            color: #ffd700;
            margin-right: 7px;
        }
    </style>
</head>
<body>
<div class="overlay">
    <div class="form-box">
        <h2><i class="fas fa-user icon"></i>Customer Registration</h2>
        <form action="RegisterServlet" method="post">
            <input type="hidden" name="role" value="attendee">

            <label><i class="fas fa-user"></i> Username</label>
            <input type="text" name="username" required>

            <label><i class="fas fa-envelope"></i> Email</label>
            <input type="email" name="email" required>

            <label><i class="fas fa-lock"></i> Password</label>
            <input type="password" name="password" required>

            <input type="submit" value="Register">
        </form>

        <div class="footer">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
    </div>
</div>
</body>
</html>
