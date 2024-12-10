<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Football Management System</title>
    <link rel="stylesheet" href="css/Home.css">
</head>
<body>
    <header>
        <h1>Football Management System</h1>
    </header>
    <nav>
        <ul>
            <li><a href="#teams">Quản lý Đội bóng</a></li>
            <li><a href="#players">Quản lý Cầu thủ</a></li>
            <li><a href="#matches">Lịch Thi đấu</a></li>
            <li><a href="#stats">Thống kê & Báo cáo</a></li>
            <li><a href="#tournaments">Quản lý Giải đấu</a></li>
        </ul>
    </nav>
    <main>
        <!-- Quản lý đội bóng -->
        <section id="teams">
            <h2>Quản lý Đội bóng</h2>
            <button onclick="showTeamForm()">Thêm đội mới</button>
            <div id="teamForm" style="display:none;">
                <h3>Thêm đội bóng</h3>
                <form>
                    <label for="teamName">Tên đội:</label>
                    <input type="text" id="teamName" required>
                    <br>
                    <label for="coach">Huấn luyện viên:</label>
                    <input type="text" id="coach">
                    <br>
                    <button type="button" onclick="addTeam()">Thêm</button>
                </form>
            </div>
            <ul id="teamList">
                <!-- Danh sách đội bóng -->
            </ul>
        </section>

        <!-- Quản lý cầu thủ -->
        <section id="players">
            <h2>Quản lý Cầu thủ</h2>
            <button onclick="showPlayerForm()">Thêm cầu thủ</button>
            <div id="playerForm" style="display:none;">
                <h3>Thêm cầu thủ</h3>
                <form>
                    <label for="playerName">Tên cầu thủ:</label>
                    <input type="text" id="playerName" required>
                    <br>
                    <label for="position">Vị trí:</label>
                    <input type="text" id="position">
                    <br>
                    <label for="team">Đội:</label>
                    <input type="text" id="team">
                    <br>
                    <button type="button" onclick="addPlayer()">Thêm</button>
                </form>
            </div>
            <ul id="playerList">
                <!-- Danh sách cầu thủ -->
            </ul>
        </section>

        <!-- Lịch thi đấu -->
        <section id="matches">
            <h2>Lịch Thi đấu</h2>
            <button onclick="showMatchForm()">Thêm trận đấu</button>
            <div id="matchForm" style="display:none;">
                <h3>Thêm trận đấu</h3>
                <form>
                    <label for="teamA">Đội A:</label>
                    <input type="text" id="teamA" required>
                    <br>
                    <label for="teamB">Đội B:</label>
                    <input type="text" id="teamB" required>
                    <br>
                    <label for="matchDate">Ngày thi đấu:</label>
                    <input type="date" id="matchDate" required>
                    <br>
                    <button type="button" onclick="addMatch()">Thêm</button>
                </form>
            </div>
            <ul id="matchList">
                <!-- Lịch thi đấu -->
            </ul>
        </section>

        <!-- Thống kê & Báo cáo -->
        <section id="stats">
            <h2>Thống kê & Báo cáo</h2>
            <p>Hiển thị số liệu thống kê về các đội bóng, cầu thủ, và kết quả thi đấu.</p>
            <!-- Nội dung thống kê -->
        </section>

        <!-- Quản lý giải đấu -->
        <section id="tournaments">
            <h2>Quản lý Giải đấu</h2>
            <p>Danh sách các giải đấu và kết quả từng vòng đấu.</p>
            <!-- Nội dung quản lý giải đấu -->
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Football Management System</p>
    </footer>
    <script src="scripts.js"></script>
</body>
</html>
