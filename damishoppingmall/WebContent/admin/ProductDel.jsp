<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>

<!-- 상품목록에서 해당 상품 삭제. 데이터베이스에서 상품 정보를 삭제 -->

<%
	request.setCharacterEncoding("UTF-8");
	String img = request.getParameter("img");
	
	try {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
		String DB_name="root";
		String DB_pw="2230";
		
		Connection con = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
		String sql = "DELETE FROM shop_product WHERE img=?";
		
		PreparedStatement pstmt = con.prepareStatement(sql); 
		pstmt.setString(1, img);
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
	response.sendRedirect("ProductList.jsp");
%>