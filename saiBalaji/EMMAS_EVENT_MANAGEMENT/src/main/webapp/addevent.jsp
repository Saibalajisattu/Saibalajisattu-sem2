<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Session validation for organizer role
    String role = (String) session.getAttribute("role");
    if (role == null || !"organizer".equals(role)) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Event - Organizer Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        body {
            margin: 0;
            font-family: 'Times New Roman', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f2f5, #d9e4f5);
            min-height: 100vh;
        }

        header {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            padding: 20px 0;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            letter-spacing: 1px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 25px;
            padding: 40px;
            width: 450px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            margin: 40px auto;
            animation: fadeIn 0.7s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-top: 15px;
            color: #333;
        }

        input[type="text"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
            background-color: rgba(255, 255, 255, 0.9);
            font-size: 15px;
        }

        textarea {
            resize: none;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #3498db, #2ecc71);
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 30px;
            margin-top: 25px;
            cursor: pointer;
            transition: background 0.4s ease;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #2980b9, #27ae60);
        }

        .error {
            color: #e74c3c;
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
        }

        @media(max-width: 550px) {
            .form-container {
                width: 90%;
                padding: 25px;
            }

            header {
                font-size: 22px;
                padding: 15px 0;
            }
        }
    </style>
</head>
<body>

<header>Emma's Event Management - Organizer Panel</header>

<div class="form-container">
    <h2><i class="fas fa-calendar-plus"></i> Add New Event</h2>

    <form action="AddEventServlet" method="post">
        <label for="event_name">Event Name</label>
        <input type="text" id="event_name" name="event_name" placeholder="Enter event name" required>

        <label for="event_date">Event Date</label>
        <input type="date" id="event_date" name="event_date" required>

        <label for="location">Location</label>
        <input type="text" id="location" name="location" placeholder="Venue or City" required>

        <label for="description">Description</label>
        <textarea id="description" name="description" rows="4" placeholder="Provide event details..."></textarea>

        <label for="type_id">Event Type</label>
        <select id="type_id" name="type_id" required>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "root");

                    String sql = "SELECT type_id, type_name FROM event_types";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int typeId = rs.getInt("type_id");
                        String typeName = rs.getString("type_name");
            %>
                        <option value="<%= typeId %>"><%= typeName %></option>
            <%
                    }
                } catch (Exception e) {
            %>
                    <option disabled>Error loading types</option>
                    <p class="error">Error: <%= e.getMessage() %></p>
            <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
                    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
                }
            %>
        </select>

        <input type="submit" value="Add Event">
    </form>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %></p>
    <% } %>
</div>

</body>
</html>
