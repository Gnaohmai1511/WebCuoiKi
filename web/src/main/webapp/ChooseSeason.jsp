<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Season</title>
</head>
<body>
    <h1>Select a Season</h1>
    <form action="MatchManagement.jsp" method="POST"> <!-- Đổi method từ GET thành POST -->
        <label for="season">Choose a season:</label>
        <select name="season_id" id="season" required> <!-- Đảm bảo tên tham số đúng là "season_id" -->
            <option value="" disabled selected>-- Select a season --</option>
            <%
                // Kết nối cơ sở dữ liệu để lấy danh sách các season
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    java.sql.Statement stmt = conn.createStatement();
                    java.sql.ResultSet rs = stmt.executeQuery("SELECT season_id, season_name FROM Season");

                    while (rs.next()) {
                        int seasonId = rs.getInt("season_id");
                        String seasonName = rs.getString("season_name");
            %>
            <option value="<%= seasonId %>"><%= seasonName %></option>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <option disabled>Error loading seasons</option>
            <%
                }
            %>
        </select>
        <br><br>
        <button type="submit">Next</button>
    </form>
</body>
</html>
