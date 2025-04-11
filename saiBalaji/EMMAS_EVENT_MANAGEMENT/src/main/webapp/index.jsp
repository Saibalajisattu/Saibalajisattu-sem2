<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to Emma's Event Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            background: url('https://theroyalreception.com/assets/img/gallery/events/8.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            color: black;
            overflow: hidden;
        }

        .hero {
            text-align: center;
            backdrop-filter: blur(12px) saturate(180%);
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 60px 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            animation: fadeIn 1.5s ease-in-out;
        }

        h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #fff;
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.6);
        }

        p {
            font-size: 1.2rem;
            margin-bottom: 10px;
            color: #f0f0f0;
        }

        .tagline {
            font-size: 1rem;
            font-style: italic;
            margin-bottom: 30px;
            color: #fcead7;
        }

        .button {
            display: inline-block;
            margin: 12px;
            padding: 14px 32px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 30px;
            text-decoration: none;
            background: linear-gradient(135deg, #00C9FF, #92FE9D);
            color: #111;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease-in-out;
        }

        .button:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
        }

        .footer-note {
            position: absolute;
            bottom: 25px;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.8);
            text-shadow: 0 1px 2px rgba(0,0,0,0.3);
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(40px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.4rem;
            }
            .hero {
                padding: 40px 20px;
            }
            .button {
                padding: 12px 24px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <div class="hero">
        <h1>Welcome to Emma’s Events</h1>
        <p><I>Crafting unforgettable experiences with elegance and ease.</I></p>
        <div class="tagline">Where every event becomes a story to remember.</div>

        <a href="login.jsp" class="button">Login</a>
        <a href="Admin Registration.jsp" class="button">Register as Admin</a>
        <a href="Customer Registration.jsp"class="button">Register</a>
    </div>

    <div class="footer-note">
        &copy; 2025 Emma's Event Management. Crafted with care.
    </div>

</body>
</html>
