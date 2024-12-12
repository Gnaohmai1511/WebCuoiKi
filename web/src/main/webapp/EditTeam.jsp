<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Đội Bóng</title>
</head>
<body>
    <h2>Sửa Đội Bóng</h2>

    <!-- Form để chỉnh sửa thông tin đội bóng -->
    <form action="EditTeam" method="post">
        <input type="hidden" name="team_id" value="<%= request.getAttribute("teamId") %>">
        
        <label for="team_name">Tên Đội Bóng:</label>
        <input type="text" id="team_name" name="team_name" value="<%= request.getAttribute("teamName") %>" required><br><br>

        <label for="home_stadium">Sân Nhà:</label>
        <input type="text" id="home_stadium" name="home_stadium" value="<%= request.getAttribute("homeStadium") %>"><br><br>

        <label for="description">Mô Tả:</label><br>
        <textarea id="description" name="description" rows="4" cols="50"><%= request.getAttribute("description") %></textarea><br><br>

        <input type="submit" value="Cập Nhật Đội Bóng">
    </form>

    <br>
    <a href="TeamManager.jsp">Trở lại trang quản lý</a>
</body>
</html>