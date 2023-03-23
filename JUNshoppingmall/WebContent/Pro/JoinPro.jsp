<!-- /* JoinPro.jsp */-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
	<!-- 회원가입 처리, mysql 연동 -->
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%
	String ID = request.getParameter("id"); // Join.jsp에서 입력받은 값들을 받아옵니다.
	String PWD = request.getParameter("passwd");
	String UserName = request.getParameter("name");
	String Email = request.getParameter("email");
	String Phone = request.getParameter("phone");
	String Address = request.getParameter("address");
	//String userType = request.getParameter"costomer";
	try {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/createtable";
		String DB_name="dami";
		String DB_pw="dami123";
		
		Connection con = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
		String sql = "INSERT INTO member( id, passwd, name, email, phone, address) VALUES (?,?,?,?,?,?)"; // sql문 작성(입력받은 값들을 보내기 위한 작업)

		PreparedStatement pstmt = con.prepareStatement(sql);
		
		//pstmt.setString(0, userType);
		pstmt.setString(1, ID); // values에 들어갈 각각의 ID, PWD, UserName, Email, Contact, Address 설정
		pstmt.setString(2, PWD);
		pstmt.setString(3, UserName);
		pstmt.setString(4, Email);
		pstmt.setString(5, Phone);
		pstmt.setString(6, Address);

		pstmt.executeUpdate();

		pstmt.close();
		con.close();
	}

	catch(ClassNotFoundException e) {
		out.println(e);
	}
	catch(SQLException e) {
		out.println(e);
	}
%>


<script>
	alert("회원가입을 축하합니다!");
	location.href='../UserMain.jsp'; 
</script>