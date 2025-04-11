<%@ page import="java.sql.*, util.DBConnection" %>
<%
    String role = (String) session.getAttribute("role");
    String username = (String) session.getAttribute("username");
    if (!"organizer".equals(role)) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>RSVP List - Event Manager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #8e9eab, #eef2f3);
        }

        .navbar {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .navbar h2 {
            margin: 0;
            color: #333;
        }

        .navbar .logout {
            background-color: #e74c3c;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s ease;
        }

        .navbar .logout:hover {
            background-color: #c0392b;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0,0,0,0.15);
            padding: 30px 40px;
            backdrop-filter: blur(8px);
        }

        h3 {
            text-align: center;
            margin-bottom: 30px;
            color: #222;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 15px;
            overflow: hidden;
            background-color: white;
        }

        th, td {
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #f5f5f5;
            color: #444;
        }

        tr:hover {
            background-color: #f0f8ff;
        }

        .icon {
            margin-right: 6px;
            color: #444;
        }

        @media(max-width: 768px) {
            .container {
                padding: 20px;
            }

            table, th, td {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <h2><i class="fas fa-clipboard-list icon"></i> RSVP List</h2>
    <div>
        Logged in as <strong><%= username %></strong>
        <a href="logout.jsp" class="logout"><i class="fas fa-sign-out-alt icon"></i> Logout</a>
    </div>
</div>

<div class="container">
    <h3><i class="fas fa-users icon"></i> RSVP Details Overview</h3>
    <table>
        <tr>
            <th>RSVP ID</th>
            <th>Event Name</th>
            <th>Username</th>
            <th>Email</th>
            <th>Number of Attendees</th>
            <th>Responded At</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT r.rsvp_id, e.event_name, u.username, u.email, r.num_attendees, r.responded_at " +
                             "FROM rsvps r " +
                             "JOIN users u ON r.user_id = u.user_id " +
                             "JOIN events e ON r.event_id = e.event_id";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("rsvp_id") %></td>
            <td><%= rs.getString("event_name") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getInt("num_attendees") %></td>
            <td><%= rs.getTimestamp("responded_at") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="6" style="color:red; text-align: center;">Error: <%= e.getMessage() %></td>
        </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>
