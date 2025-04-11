package servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
import util.DBConnection;

@WebServlet("/AddEventServlet")
public class AddEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the form
        String name = request.getParameter("event_name");
        String date = request.getParameter("event_date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String typeId = request.getParameter("type_id");

        // Get the logged-in user's user_id from session
        Integer organizerId = (Integer) request.getSession().getAttribute("user_id");

        if (organizerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO events (event_name, event_date, location, description, type_id, organizer_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDate(2, Date.valueOf(date)); // Ensure it's java.sql.Date
            ps.setString(3, location);
            ps.setString(4, description);
            ps.setInt(5, Integer.parseInt(typeId));
            ps.setInt(6, organizerId);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("error", "Failed to add event.");
                request.getRequestDispatcher("addEvent.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("addEvent.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("addEvent.jsp");
    }
}
