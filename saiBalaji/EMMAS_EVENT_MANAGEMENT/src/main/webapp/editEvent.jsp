<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String eventId = request.getParameter("id");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    PreparedStatement typeStmt = null;
    ResultSet typeRs = null;

    int selectedTypeId = -1;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "root");

        String sql = "SELECT * FROM events WHERE event_id=?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(eventId));
        rs = ps.executeQuery();

        if (rs.next()) {
            selectedTypeId = rs.getInt("type_id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Event - Organizer Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        * {
            box-sizing: border-box;
        }

         body {
            margin: 0;
            padding: 0;
            font-family: 'Times new Roman', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('https://cdn.earlytorise.com/wp-content/uploads/2008/02/event-promotion.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

         .card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            padding: 35px 45px;
            width: 100%;
            max-width: 550px;
            animation: slideFade 0.6s ease-in-out;
        }



        @keyframes slideFade {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2c3e50;
        }

        label {
            font-weight: 600;
            margin-top: 15px;
            display: block;
            color: #34495e;
        }

        input[type="text"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 10px 14px;
            margin-top: 8px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            background: #fdfdfd;
            transition: border 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        textarea:focus,
        select:focus {
            border: 1px solid #2980b9;
            outline: none;
        }

        textarea {
            resize: vertical;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-top: 25px;
        }

        input[type="submit"],
        .cancel-btn {
            flex: 1;
            padding: 12px;
            border-radius: 25px;
            font-weight: bold;
            border: none;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #3498db, #2ecc71);
            color: white;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #2980b9, #27ae60);
        }

        .cancel-btn {
            background: #ecf0f1;
            color: #2c3e50;
        }

        .cancel-btn:hover {
            background: #d0d7de;
        }

        .form-icon {
            text-align: center;
            margin-bottom: 10px;
            color: #3498db;
            font-size: 35px;
        }

        @media (max-width: 600px) {
            .card {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>
<div class="card">
    <div class="form-icon">
        <i class="fas fa-edit"></i>
    </div>
    <h2>Edit Event Details</h2>
    <form action="EditEventServlet" method="post">
        <input type="hidden" name="event_id" value="<%= rs.getInt("event_id") %>">

        <label for="event_name">Event Name</label>
        <input type="text" id="event_name" name="event_name" value="<%= rs.getString("event_name") %>" placeholder="Enter the event title" required>

        <label for="event_date">Date</label>
        <input type="date" id="event_date" name="event_date" value="<%= rs.getString("event_date") %>" required>

        <label for="location">Location</label>
        <input type="text" id="location" name="location" value="<%= rs.getString("location") %>" placeholder="City, Venue, etc." required>

        <label for="description">Description</label>
        <textarea id="description" name="description" rows="4" placeholder="Detailed description of the event"><%= rs.getString("description") %></textarea>

        <label for="type_id">Event Type</label>
        <select id="type_id" name="type_id" required>
            <%
                String typeSql = "SELECT * FROM event_types";
                typeStmt = conn.prepareStatement(typeSql);
                typeRs = typeStmt.executeQuery();

                while (typeRs.next()) {
                    int typeId = typeRs.getInt("type_id");
                    String typeName = typeRs.getString("type_name");
            %>
                <option value="<%= typeId %>" <%= (typeId == selectedTypeId ? "selected" : "") %>><%= typeName %></option>
            <%
                }
            %>
        </select>

        <div class="actions">
            <input type="submit" value="Update Event">
            <a href="organizer_events.jsp" class="cancel-btn">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
<%
        }
    } catch (Exception e) {
        out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (typeRs != null) try { typeRs.close(); } catch (Exception ignore) {}
        if (typeStmt != null) try { typeStmt.close(); } catch (Exception ignore) {}
        if (rs != null) try { rs.close(); } catch (Exception ignore) {}
        if (ps != null) try { ps.close(); } catch (Exception ignore) {}
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>
