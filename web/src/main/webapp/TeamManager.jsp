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
                <th>Mô Tả</th>
                <th>Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Kết nối CSDL và lấy thông tin đội bóng
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM Teams");

                    while (rs.next()) {
                        int teamId = rs.getInt("team_id");
                        String teamName = rs.getString("team_name");
                        String homeStadium = rs.getString("home_stadium");
                        String description = rs.getString("description");
            %>
            <tr>
                <td><%= teamId %></td>
                <td><%= teamName %></td>
                <td><%= homeStadium %></td>
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
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
