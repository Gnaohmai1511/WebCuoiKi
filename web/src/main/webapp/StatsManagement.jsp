<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thống Kê Cầu Thủ</title>
</head>
<body>
    <h2>Quản lý Thống Kê Cầu Thủ</h2>

    <!-- Form Thêm Thống Kê Cầu Thủ -->
    <form action="AddStats" method="post">
        <label for="player">Cầu Thủ:</label>
        <select id="player" name="player_id" required>
            <% 
                // Kết nối CSDL để lấy danh sách cầu thủ
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT player_id, player_name FROM Players");

                    while (rs.next()) {
                        int playerId = rs.getInt("player_id");
                        String playerName = rs.getString("player_name");
            %>
            <option value="<%= playerId %>"><%= playerName %></option>
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

        <label for="goals">Số Bàn Thắng:</label>
        <input type="number" id="goals" name="goals" value="0" required><br><br>

        <label for="yellow_cards">Thẻ Vàng:</label>
        <input type="number" id="yellow_cards" name="yellow_cards" value="0" required><br><br>

        <label for="red_cards">Thẻ Đỏ:</label>
        <input type="number" id="red_cards" name="red_cards" value="0" required><br><br>

        <input type="submit" value="Thêm Thống Kê">
    </form>

    <h3>Danh Sách Thống Kê Cầu Thủ</h3>

    <!-- Bảng Hiển Thị Danh Sách Thống Kê Cầu Thủ -->
    <table border="1">
        <thead>
            <tr>
                <th>ID Cầu Thủ</th>
                <th>Tên Cầu Thủ</th>
                <th>Số Bàn Thắng</th>
                <th>Thẻ Vàng</th>
                <th>Thẻ Đỏ</th>
                <th>Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Kết nối CSDL và lấy thông tin thống kê cầu thủ
                Connection conn2 = null;
                Statement stmt2 = null;
                ResultSet rs2 = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    stmt2 = conn2.createStatement();
                    rs2 = stmt2.executeQuery("SELECT ps.stat_id, p.player_name, ps.goals, ps.yellow_cards, ps.red_cards FROM PlayerStats ps INNER JOIN Players p ON ps.player_id = p.player_id");

                    while (rs2.next()) {
                        int statId = rs2.getInt("stat_id");
                        String playerName = rs2.getString("player_name");
                        int goals = rs2.getInt("goals");
                        int yellowCards = rs2.getInt("yellow_cards");
                        int redCards = rs2.getInt("red_cards");
            %>
            <tr>
                <td><%= statId %></td>
                <td><%= playerName %></td>
                <td><%= goals %></td>
                <td><%= yellowCards %></td>
                <td><%= redCards %></td>
                <td>
                    <!-- Nút Sửa và Xóa -->
                    <a href="EditStats?stat_id=<%= statId %>">Sửa</a> |
                    <a href="DeleteStats?stat_id=<%= statId %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
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
