<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Cầu Thủ</title>
</head>
<body>
    <h2>Quản Lý Cầu Thủ</h2>

    <!-- Form Thêm Cầu Thủ -->
    <form action="AddPlayer" method="post">
        <label for="player_name">Tên Cầu Thủ:</label>
        <input type="text" id="player_name" name="player_name" required><br><br>

        <label for="position">Vị Trí:</label>
        <input type="text" id="position" name="position"><br><br>

        <label for="jersey_number">Số Áo:</label>
        <input type="number" id="jersey_number" name="jersey_number"><br><br>

        <label for="nationality">Quốc Tịch:</label>
        <input type="text" id="nationality" name="nationality"><br><br>

        <label for="team_id">Đội Bóng:</label>
        <select id="team_id" name="team_id">
            <% 
                // Kết nối CSDL để lấy danh sách đội bóng
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT team_id, team_name FROM Teams");

                    while (rs.next()) {
                        int teamId = rs.getInt("team_id");
                        String teamName = rs.getString("team_name");
            %>
            <option value="<%= teamId %>"><%= teamName %></option>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select><br><br>

        <input type="submit" value="Thêm Cầu Thủ">
    </form>

    <h3>Danh Sách Cầu Thủ</h3>

    <!-- Bảng Hiển Thị Danh Sách Cầu Thủ -->
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên Cầu Thủ</th>
                <th>Vị Trí</th>
                <th>Số Áo</th>
                <th>Quốc Tịch</th>
                <th>Đội Bóng</th>
                <th>Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Kết nối CSDL và lấy thông tin cầu thủ
                Connection conn2 = null;
                Statement stmt2 = null;
                ResultSet rs2 = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    stmt2 = conn2.createStatement();
                    rs2 = stmt2.executeQuery("SELECT p.player_id, p.player_name, p.position, p.jersey_number, p.nationality, t.team_name " +
                                             "FROM Players p INNER JOIN Teams t ON p.team_id = t.team_id");

                    while (rs2.next()) {
                        int playerId = rs2.getInt("player_id");
                        String playerName = rs2.getString("player_name");
                        String position = rs2.getString("position");
                        int jerseyNumber = rs2.getInt("jersey_number");
                        String nationality = rs2.getString("nationality");
                        String teamName = rs2.getString("team_name");
            %>
            <tr>
                <td><%= playerId %></td>
                <td><%= playerName %></td>
                <td><%= position %></td>
                <td><%= jerseyNumber %></td>
                <td><%= nationality %></td>
                <td><%= teamName != null ? teamName : "Không có đội" %></td>
                <td>
                    <!-- Nút Sửa và Xóa -->
                    <a href="EditPlayer?player_id=<%= playerId %>">Sửa</a> |
                    <a href="DeletePlayer?player_id=<%= playerId %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                </td>
            </tr>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs2 != null) rs2.close();
                        if (stmt2 != null) stmt2.close();
                        if (conn2 != null) conn2.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
