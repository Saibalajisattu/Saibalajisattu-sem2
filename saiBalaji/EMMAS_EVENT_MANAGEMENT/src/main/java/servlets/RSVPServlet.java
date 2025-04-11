package servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
@WebServlet("/RSVPServlet")
public class RSVPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("dashboard.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("event_id"));
        int numAttendees = Integer.parseInt(request.getParameter("num_attendees"));

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "root")) {
            String sql = "INSERT INTO rsvps (user_id, event_id, num_attendees) VALUES (?, ?, ?) " +
                         "ON DUPLICATE KEY UPDATE num_attendees = VALUES(num_attendees)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            ps.setInt(3, numAttendees);
            ps.executeUpdate();

            response.sendRedirect("dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("RSVP failed: " + e.getMessage());
        }
    }
}
