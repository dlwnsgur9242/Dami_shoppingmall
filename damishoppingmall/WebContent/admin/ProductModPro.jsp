<!-- /* AdminUserList.jsp */  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
    
    <%
	  request.setCharacterEncoding("utf-8");
	  // name price img imgpath 가져오기
	  String name = request.getParameter("name");
	  String price = request.getParameter("price");
	  String img = request.getParameter("img");
	  String imgpath = request.getParameter("imgpath");
	  
	    //객체참조변수 선언    
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    
	   // 1단계 드라이버로더
	    Class.forName("org.mariadb.jdbc.Driver");
	   
	// 2단계 디비연결
		String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
		String DB_name="root";
		String DB_pw="2230";
	  	conn = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
	  	
	   pstmt = conn.prepareStatement("UPDATE shop_product SET name=?, price=?, imgpath=? WHERE img=?"); 
	   pstmt.setString(1, name);
	   pstmt.setString(2, price);
	   pstmt.setString(3, imgpath);
	   pstmt.setString(4, img);
	
	    int result = pstmt.executeUpdate();
		System.out.println(result + "<-- result");

		pstmt.close();
		conn.close();
		
 		response.sendRedirect("ProductList.jsp");
 %>