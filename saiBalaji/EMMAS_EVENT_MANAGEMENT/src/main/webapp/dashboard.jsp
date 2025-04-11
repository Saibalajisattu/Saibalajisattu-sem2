<%@page import="util.DBConnection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String backgroundImage = "https://cdn-ilamnfl.nitrocdn.com/pOlVITbBApoUVKMterFkQHGOShlqtsIa/assets/images/optimized/rev-9a4a9e6/www.jovialevents.com/wp-content/uploads/2025/02/Corporate-event-company-in-Dubai-1.jpg"; // customer
    if ("organizer".equals(role)) {
        backgroundImage = "https://kindful.com/wp-content/uploads/nonprofit-event-management_feature-1.jpg"; // admin
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Event Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Times New Roman', serif;
            background: url('<%= backgroundImage %>') no-repeat center center fixed;
            background-size: cover;
        }

        .overlay {
            background: rgba(255, 255, 255, 0.15);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 20px;
        }

        .dashboard-box {
            background: rgba(255, 255, 255, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.35);
            border-radius: 20px;
            padding: 30px;
            width: 90%;
            max-width: 1000px;
            box-shadow: 0 0 30px rgba(0,0,0,0.3);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            color: #111;
        }

        h2, h3 {
            text-align: center;
            margin-bottom: 20px;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 20px 0;
            text-align: center;
        }

        ul li {
            display: inline-block;
            margin: 0 15px;
        }

        ul li a {
            color: brown;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
        }

        ul li a:hover {
            color: #66ffcc;
            text-decoration: underline;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background-color: rgba(255,255,255,0.6);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: rgba(0,0,0,0.1);
        }

        .logout-link {
            margin-top: 30px;
            display: block;
            width: fit-content;
            margin-left: auto;
            margin-right: auto;
            padding: 10px 25px;
            background-color: #e74c3c;
            color: white;
            border-radius: 25px;
            text-decoration: none;
            font-size: 15px;
            font-weight: bold;
        }

        .logout-link:hover {
            background-color: #c0392b;
        }

        @media (max-width: 768px) {
            .dashboard-box {
                width: 100%;
            }

            table {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
<div class="overlay">
    <div class="dashboard-box">
        <h2><i class="fas fa-user-circle"></i> Welcome, <%= username %>!</h2>
        <p style="text-align:center;">Your role: <strong><%= role %></strong></p>

        <% if ("organizer".equals(role)) { %>
            <h3><i class="fas fa-tools"></i> Admin Panel</h3>
            <ul>
                <li><a href="addevent.jsp"><i class="fas fa-calendar-plus"></i> Add Event</a></li>
                <li><a href="manageEvents.jsp"><i class="fas fa-cogs"></i> Manage Events</a></li>
                <li><a href="viewRSVPs.jsp"><i class="fas fa-users"></i> View RSVPs</a></li>
            </ul>
        <% } else { %>
            <h3><i class="fas fa-user-friends"></i> Customer Panel</h3>
            <ul>
                <li><a href="viewEvents.jsp"><i class="fas fa-eye"></i> Browse Events</a></li>
                <li><a href="myRSVPs.jsp"><i class="fas fa-ticket-alt"></i> My RSVPs</a></li>
            </ul>
        <% } %>

        <h3>Upcoming Events</h3>
        <table>
            <tr>
                <th>Event Name</th>
                <th>Date</th>
                <th>Location</th>
                <th>Type</th>
                <th>Description</th>
            </tr>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT e.event_name, e.event_date, e.location, e.description, t.type_name " +
                                 "FROM events e JOIN event_types t ON e.type_id = t.type_id";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("event_name") %></td>
                <td><%= rs.getDate("event_date") %></td>
                <td><%= rs.getString("location") %></td>
                <td><%= rs.getString("type_name") %></td>
                <td><%= rs.getString("description") %></td>
            </tr>
            <% } } catch(Exception e) { out.println("<tr><td colspan='5'>Error loading events: " + e.getMessage() + "</td></tr>"); } %>
        </table>

        <a class="logout-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>
</body>
</html>
