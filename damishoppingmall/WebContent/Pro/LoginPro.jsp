<!-- /* LoginPro.jsp */-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
	<!-- 로그인 처리 페이지 입니다. -->
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%
		//로그인 화면에 입력된 아이디와 비밀번호를 가져온다
		String id= request.getParameter("id");
		String pw = request.getParameter("passwd");
 		String admin = "Admin";
		String costomer = "costomer";

	try {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//mysql 경로 및 계정정보
		Class.forName("org.mariadb.jdbc.Driver");
		String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
		String DB_name="root";
		String DB_pw="2230";
		
		conn = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
		//id에 해당하는 passwd 가져오기
		String sql = "SELECT passwd, userType FROM member WHERE id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		//실행  rs에 저장
		rs = pstmt.executeQuery();

		//rs에 데이터(행)가 있으면 아이디 있음
		//패스워드비교 맞으면 로그인 인증(세션값 생성 "ID")
		//패스워드비교 틀리면 "패스워드틀림" 로그인페이지로 이동
		//rs에 데이터(행)가 없으면 "아이디없음" 로그인페이지로 이동
		if (rs.next()) { // 아이디있음
			if (pw.equals(rs.getString("passwd"))) {
				session.setAttribute("id", id);
				
				if(admin.equals(rs.getString("userType"))){ //관리자
					response.sendRedirect("../AdminMain.jsp");	
				}
				else if (costomer.equals(rs.getString("userType"))) { //일반 고객
					response.sendRedirect("../UserMain.jsp");
				}

			} 
			else {
%>
				<script>
					alert("비밀번호를 확인해주세요.");
					history.back();
				</script>		
<%	
			}
		} else {
			// 아이디없음
%>
			<script>
				alert("아이디를 확인해주세요.");
				//location.href = "login.jsp";  // 서버가 요청을 받는다.
				history.back(); // history.go(-1);  // 서버에 요청없이 브라우저에서 자체적으로 처리
			</script>
<%

		}
		
		pstmt.executeQuery(); // sql문 실행
		pstmt.close();
		conn.close();
	}

	catch(ClassNotFoundException e) {
		out.println(e);
	}
	catch(SQLException e) {
		out.println(e);
	}
%>