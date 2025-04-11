<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection" %>

<%
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("user_id");

    if (role == null || !"organizer".equals(role) || userId == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Events | Emma's Events</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Times New Roman', sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #007BFF;
            color: white;
            padding: 20px 40px;
            text-align: center;
            font-size: 1.8rem;
            font-weight: bold;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
        }

        th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
        }

        tr:nth-child(even) {
            background-color: #f1f3f5;
        }

        tr:hover {
            background-color: #e9ecef;
            transition: background-color 0.2s ease-in-out;
        }

        a.action-btn {
            padding: 8px 14px;
            background: #17a2b8;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.95rem;
            margin-right: 6px;
            transition: background 0.3s;
        }

        a.action-btn:hover {
            background: #138496;
        }

        .delete-btn {
            background-color: #dc3545 !important;
        }

        .delete-btn:hover {
            background-color: #b52a38 !important;
        }

        .status-msg {
            text-align: center;
            margin-top: 20px;
            color: red;
            font-weight: 500;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .top-bar .add-btn {
            background-color: #28a745;
            color: white;
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.95rem;
            transition: background 0.3s;
        }

        .top-bar .add-btn:hover {
            background-color: #218838;
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 14px;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .top-bar .add-btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<header>Emma's Event Management - Organizer Panel</header>

<div class="container">
    <div class="top-bar">
        <h2>Manage Your Events</h2>
        <a href="addevent.jsp" class="add-btn">+ Create New Event</a>
    </div>

    <table>
        <tr>
            <th>Name</th>
            <th>Date</th>
            <th>Location</th>
            <th>Type</th>
            <th>Actions</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT e.event_id, e.event_name, e.event_date, e.location, t.type_name " +
                             "FROM events e " +
                             "LEFT JOIN event_types t ON e.type_id = t.type_id " +
                             "WHERE e.organizer_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);

                ResultSet rs = ps.executeQuery();

                boolean hasEvents = false;

                while (rs.next()) {
                    hasEvents = true;
        %>
        <tr>
            <td><%= rs.getString("event_name") %></td>
            <td><%= rs.getDate("event_date") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("type_name") != null ? rs.getString("type_name") : "N/A" %></td>
            <td>
                <a class="action-btn" href="editEvent.jsp?id=<%= rs.getInt("event_id") %>">Edit</a>
                <a class="action-btn delete-btn" href="DeleteEventServlet?id=<%= rs.getInt("event_id") %>" onclick="return confirm('Are you sure you want to delete this event?');">Delete</a>
            </td>
        </tr>
        <%
                }

                if (!hasEvents) {
                    out.println("<tr><td colspan='5' style='text-align:center; color:gray;'>No events found. Click 'Create New Event' to start organizing.</td></tr>");
                }

            } catch (Exception e) {
                out.println("<div class='status-msg'>Error loading events: " + e.getMessage() + "</div>");
            }
        %>
    </table>
</div>

</body>
</html>
