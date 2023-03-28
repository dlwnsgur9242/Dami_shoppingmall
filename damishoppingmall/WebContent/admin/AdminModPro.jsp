<!-- /* AdminUserList.jsp */  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
    
    <%
	  request.setCharacterEncoding("utf-8");
	  // id passwd name가져오기
	  String id = request.getParameter("id");
	  String pwd = request.getParameter("passwd");
	  String username = request.getParameter("name");
	  String email = request.getParameter("email");
	  String phone = request.getParameter("phone");
	  String address = request.getParameter("address");
	  
	    //객체참조변수 선언    
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	  
	   // 1단계 드라이버로더
	    Class.forName("org.mariadb.jdbc.Driver");
	   
	// 2단계 디비연결
	   String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
		String DB_name="root";
		String DB_pw="2230";;
	   conn = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
	   
	   pstmt = conn.prepareStatement("UPDATE member SET passwd=?, name=?, email=?, phone=?, address=? WHERE id=?");
	   pstmt.setString(1, pwd);
	   pstmt.setString(2, username);
	   pstmt.setString(3, email);
	   pstmt.setString(4, phone);
	   pstmt.setString(5, address);
	   pstmt.setString(6, id);
	
		int result = pstmt.executeUpdate();
		System.out.println(result + "<-- result");
 
		pstmt.close();
		conn.close(); 
		
 		response.sendRedirect("AdminUserList.jsp");
%>