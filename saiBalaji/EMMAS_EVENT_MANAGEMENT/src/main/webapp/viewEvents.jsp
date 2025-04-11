<%@ page import="java.sql.*, util.DBConnection" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"attendee".equals(role)) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Browse Events</title>
    <style>
        body {
            font-family: 'Times New Roman', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9fb;
            color: #333;
        }

        header {
            background: #4B79A1;
            background: linear-gradient(to right, #283E51, #4B79A1);
            padding: 20px;
            color: white;
            text-align: center;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        header h1 {
            margin: 0;
            font-size: 2.2rem;
            letter-spacing: 1px;
        }

        .container {
            padding: 40px;
            max-width: 1100px;
            margin: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        th, td {
            padding: 16px;
            text-align: left;
        }

        th {
            background: #eef1f5;
            font-weight: 600;
            color: #333;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background-color: #f0f7ff;
            transition: 0.3s ease;
        }

        input[type="number"] {
            width: 60px;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        input[type="submit"] {
            background-color: #4B79A1;
            border: none;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #35506c;
        }

        .note {
            font-size: 0.95rem;
            color: #666;
            margin-top: 10px;
        }

        .event-desc {
            max-width: 350px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>
    <header>
        <h1>Explore Upcoming Events</h1>
        <p class="note"><B>Browse and RSVP to events you're interested in. You must specify the number of attendees.</B></p>
    </header>

    <div class="container">
        <table>
            <tr>
                <th>Event Name</th>
                <th>Date</th>
                <th>Location</th>
                <th>Type</th>
                <th>Description</th>
                <th>RSVP</th>
            </tr>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT e.event_id, e.event_name, e.event_date, e.location, e.description, t.type_name " +
                                 "FROM events e " +
                                 "JOIN event_types t ON e.type_id = t.type_id";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("event_name") %></td>
                <td><%= rs.getDate("event_date") %></td>
                <td><%= rs.getString("location") %></td>
                <td><%= rs.getString("type_name") %></td>
                <td class="event-desc" title="<%= rs.getString("description") %>"><%= rs.getString("description") %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/RSVPServlet" method="post">
                        <input type="hidden" name="event_id" value="<%= rs.getInt("event_id") %>">
                        <input type="number" name="num_attendees" min="1" required>
                        <input type="submit" value="RSVP">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>Error loading events: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>
</body>
</html>
