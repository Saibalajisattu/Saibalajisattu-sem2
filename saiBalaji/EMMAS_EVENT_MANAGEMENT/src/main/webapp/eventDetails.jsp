<%
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("user_id");

    if (userId != null && "customer".equals(role)) {
%>
    <h3>RSVP to this Event</h3>
    <form action="RSVPServlet" method="post">
        <input type="hidden" name="event_id" value="<%= request.getParameter("id") %>">
        <label>Number of Attendees:</label>
        <input type="number" name="num_attendees" min="1" required>
        <input type="submit" value="RSVP">
    </form>
<%
    } else {
%>
    <p><i>You must be logged in as a customer to RSVP.</i></p>
<%
    }
%>
