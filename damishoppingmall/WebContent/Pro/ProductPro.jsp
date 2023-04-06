<!-- /* JoinPro.jsp */-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
	<!-- 상품등록 처리, mariadb 연동 -->
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%
	String realFolder = "";
	String saveFolder = "img";	

	String name = request.getParameter("name"); // Join.jsp에서 입력받은 값들을 받아옵니다.
	String price = request.getParameter("price");
	String img = request.getParameter("img");
	//String userType = request.getParameter"costomer";
	try {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
		String DB_name="root";
		String DB_pw="2230";
		
		Connection con = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
		String sql = "INSERT INTO shop_product( name, price, img) VALUES (?,?,?)"; // sql문 작성(입력받은 값들을 보내기 위한 작업)

		PreparedStatement pstmt = con.prepareStatement(sql);
		
		//pstmt.setString(0, userType);
		pstmt.setString(1, name); // values에 들어갈 각각의 ID, PWD, UserName, Email, Contact, Address 설정
		pstmt.setString(2, price);
		pstmt.setString(3, img);
		

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
	alert("상품 등록 완료!");
	location.href='../UserMain.jsp'; 
</script>