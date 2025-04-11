<%@ page import="java.sql.*, util.DBConnection" %>
<%
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("user_id");
    if (!"attendee".equals(role) || userId == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My RSVP History</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: url('https://res.cloudinary.com/mergernetwork/image/upload/pg_1,w_490,ar_16:9,c_fill,f_auto/posts/40A53FAE-AD55-4A8F-983A3E4B30C3D90F.jpg') no-repeat center center fixed;
            background-size: cover;
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            padding-top: 60px;
            color: #fff;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }

        h2 {
            position: relative;
            z-index: 1;
            font-size: 2.5em;
            margin-bottom: 30px;
            color: #fff;
            text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5);
        }

        table {
            width: 90%;
            max-width: 1000px;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
        }

        th, td {
            padding: 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            text-align: left;
            color: #fff;
        }

        th {
            background-color: rgba(255, 255, 255, 0.1);
            font-weight: 600;
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.08);
            transition: 0.3s;
        }

        @media (max-width: 768px) {
            table, tr, td, th {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <h2>My RSVP History</h2>
    <table>
        <tr>
            <th>Event</th>
            <th>Date</th>
            <th>Location</th>
            <th>Attendees</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT e.event_name, e.event_date, e.location, r.num_attendees " +
                             "FROM rsvps r " +
                             "JOIN events e ON r.event_id = e.event_id " +
                             "WHERE r.user_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("event_name") %></td>
            <td><%= rs.getDate("event_date") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getInt("num_attendees") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error loading your RSVPs: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
