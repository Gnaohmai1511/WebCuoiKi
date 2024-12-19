<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Trận Đấu</title>
</head>
<body>
    <h2>Quản Lý Trận Đấu</h2>

    <%
        // Lấy `season_id` từ request
        String seasonIdStr = request.getParameter("season_id");
        int seasonId = (seasonIdStr != null && !seasonIdStr.isEmpty()) ? Integer.parseInt(seasonIdStr) : -1;

        if (seasonId == -1) {
    %>
        <p style="color:red;">Vui lòng chọn một mùa giải từ trang trước!</p>
    <% } else { %>

    <!-- Form Thêm Trận Đấu -->
    <form action="AddMatch" method="post">
        <input type="hidden" name="season_id" value="<%= seasonId %>">
        <label for="home_team_id">Đội Chủ Nhà:</label>
        <select id="home_team_id" name="home_team_id" required>
            <option value="" disabled selected>-- Chọn Đội Chủ Nhà --</option>
            <% 
                // Lấy danh sách các đội thuộc mùa giải
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT t.team_id, t.team_name " +
                         "FROM Teams t INNER JOIN TeamSeason ts ON t.team_id = ts.team_id " +
                         "WHERE ts.season_id = ?")) {
                    
                    stmt.setInt(1, seasonId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            int teamId = rs.getInt("team_id");
                            String teamName = rs.getString("team_name");
            %>
            <option value="<%= teamId %>"><%= teamName %></option>
            <% 
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select><br><br>

        <label for="away_team_id">Đội Khách:</label>
        <select id="away_team_id" name="away_team_id" required>
            <option value="" disabled selected>-- Chọn Đội Khách --</option>
            <% 
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT t.team_id, t.team_name " +
                         "FROM Teams t INNER JOIN TeamSeason ts ON t.team_id = ts.team_id " +
                         "WHERE ts.season_id = ?")) {
                    
                    stmt.setInt(1, seasonId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            int teamId = rs.getInt("team_id");
                            String teamName = rs.getString("team_name");
            %>
            <option value="<%= teamId %>"><%= teamName %></option>
            <% 
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select><br><br>

        <label for="match_date">Ngày Trận Đấu:</label>
        <input type="datetime-local" id="match_date" name="match_date" required><br><br>

        <label for="stadium">Sân Vận Động:</label>
        <input type="text" id="stadium" name="stadium" required><br><br>

        <label for="home_score">Tỷ Số Đội Chủ Nhà:</label>
        <input type="number" id="home_score" name="home_score" min="0"><br><br>

        <label for="away_score">Tỷ Số Đội Khách:</label>
        <input type="number" id="away_score" name="away_score" min="0"><br><br>

        <button type="submit">Thêm Trận Đấu</button>
    </form>

    <!-- Danh sách các trận đấu -->
    <h3>Danh Sách Trận Đấu</h3>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Đội Chủ Nhà</th>
                <th>Đội Khách</th>
                <th>Ngày</th>
                <th>Sân Vận Động</th>
                <th>Tỷ Số</th>
                <th>Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <% 
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "HuyHo@ng15112004");
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT m.match_id, t1.team_name AS home_team, t2.team_name AS away_team, " +
                         "m.match_date, m.stadium, m.home_score, m.away_score " +
                         "FROM Matches m " +
                         "JOIN Teams t1 ON m.home_team_id = t1.team_id " +
                         "JOIN Teams t2 ON m.away_team_id = t2.team_id " +
                         "WHERE m.season_id = ?")) {

                    stmt.setInt(1, seasonId);

                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            int matchId = rs.getInt("match_id");
                            String homeTeam = rs.getString("home_team");
                            String awayTeam = rs.getString("away_team");
                            String matchDate = rs.getString("match_date");
                            String stadium = rs.getString("stadium");
                            int homeScore = rs.getInt("home_score");
                            int awayScore = rs.getInt("away_score");
            %>
            <tr>
                <td><%= matchId %></td>
                <td><%= homeTeam %></td>
                <td><%= awayTeam %></td>
                <td><%= matchDate %></td>
                <td><%= stadium %></td>
                <td><%= homeScore %> - <%= awayScore %></td>
                <td>
                    <a href="EditMatch?match_id=<%= matchId %>&season_id=<%= seasonId %>">Sửa</a> | 
                    <a href="DeleteMatch?match_id=<%= matchId %>&season_id=<%= seasonId %>" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                </td>
            </tr>
            <% 
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>

    <% } %>
</body>
</html>