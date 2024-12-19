<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đội Bóng</title>
</head>
<body>
    <h2>Quản lý Đội Bóng</h2>

    <!-- Form Thêm Đội Bóng -->
    <form action="AddTeam" method="post">
        <label for="team_name">Tên Đội Bóng:</label>
        <input type="text" id="team_name" name="team_name" required><br><br>

        <label for="home_stadium">Sân Nhà:</label>
        <input type="text" id="home_stadium" name="home_stadium"><br><br>

        <label for="description">Mô Tả:</label><br>
        <textarea id="description" name="description" rows="4" cols="50"></textarea><br><br>

        <!-- Combobox Mùa Giải -->
        <label for="season">Mùa Giải:</label>
        <select id="season" name="season">
            <% 
                // Kết nối CSDL để lấy danh sách mùa giải
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT season_id, season_name FROM Season");

                    while (rs.next()) {
                        int seasonId = rs.getInt("season_id");
                        String seasonName = rs.getString("season_name");
            %>
            <option value="<%= seasonId %>"><%= seasonName %></option>
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

        <input type="submit" value="Thêm Đội Bóng">
    </form>

    <h3>Danh Sách Đội Bóng</h3>

    <!-- Bảng Hiển Thị Danh Sách Đội Bóng -->
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên Đội Bóng</th>
                <th>Sân Nhà</th>
                <th>Mùa giải</th>
                <th>Mô tả</th>
                <th>Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Kết nối CSDL và lấy thông tin đội bóng
                Connection conn2 = null;
                Statement stmt2 = null;
                ResultSet rs2 = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    stmt2 = conn2.createStatement();
                    rs2 = stmt2.executeQuery("SELECT Teams.team_id,team_name,home_stadium,description,season_name FROM Teams INNER JOIN TeamSeason ON Teams.team_id = TeamSeason.team_id INNER JOIN Season ON Season.season_id = TeamSeason.season_id  ");

                    while (rs2.next()) {
                        int teamId = rs2.getInt("team_id");
                        String teamName = rs2.getString("team_name");
                        String homeStadium = rs2.getString("home_stadium");
                        String seasonName = rs2.getString("season_name");
                        String description = rs2.getString("description");
            %>
            <tr>
                <td><%= teamId %></td>
                <td><%= teamName %></td>
                <td><%= homeStadium %></td>
                <td><%= seasonName %></td>
                <td><%= description %></td>
                <td>
                    <!-- Nút Sửa và Xóa -->
                    <a href="EditTeam?team_id=<%= teamId %>">Sửa</a> |
                    <a href="DeleteTeam?team_id=<%= teamId %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
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
