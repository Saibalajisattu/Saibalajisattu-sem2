<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Registration - Event Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        body {
            margin: 0;
            font-family: 'Times New Roman', serif;
            background: url('https://st5.depositphotos.com/12985790/67584/i/600/depositphotos_675848570-stock-photo-smiling-blonde-event-manager-clipboard.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .overlay {
            background-color: rgba(0, 0, 0, 0.45); /* subtle dark overlay for readability */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-box {
            background: linear-gradient(to bottom right, #3a3a69, #7a7abb); /* stylish shaded form */
            padding: 40px;
            border-radius: 15px;
            max-width: 400px;
            width: 100%;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4);
            color: #fff;
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
    <div class="register-box">
        <h2><i class="fas fa-user-shield icon"></i>Admin Registration</h2>
        <form action="RegisterServlet" method="post">
            <input type="hidden" name="role" value="organizer">

            <label><i class="fas fa-user"></i> Username:</label>
            <input type="text" name="username" required>

            <label><i class="fas fa-envelope"></i> Email:</label>
            <input type="email" name="email" required>

            <label><i class="fas fa-lock"></i> Password:</label>
            <input type="password" name="password" required>

            <input type="submit" value="Register">
        </form>

        <div class="footer">
            <p>Already registered? <a href="login.jsp">Login here</a></p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
    </div>
</div>
</body>
</html>
