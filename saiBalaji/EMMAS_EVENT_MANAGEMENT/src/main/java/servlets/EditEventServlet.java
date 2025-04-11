package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConnection;

@WebServlet("/EditEventServlet")
public class EditEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("event_id"));
        String eventName = request.getParameter("event_name");
        String eventDate = request.getParameter("event_date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        int typeId = Integer.parseInt(request.getParameter("type_id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE events SET event_name = ?, event_date = ?, location = ?, description = ?, type_id = ? WHERE event_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, eventName);
            ps.setString(2, eventDate);
            ps.setString(3, location);
            ps.setString(4, description);
            ps.setInt(5, typeId);
            ps.setInt(6, eventId);

            ps.executeUpdate();
            response.sendRedirect("manageEvents.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Update failed: " + e.getMessage());
        }
    }
}
