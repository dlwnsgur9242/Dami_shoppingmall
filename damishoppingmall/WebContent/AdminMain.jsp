<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@include file="AdminTop.jsp" %>
<!-- 관리자 메인 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dami_snackmall</title>
<script type="text/javascript">
function ProductModify(name, price) {
	location.href = "admin/ProductList.jsp";
}
</script>
</head>
<body>
<%
	Connection conn= null;
	Statement stmt = null;
	ResultSet rs   = null;

	try {
		Class.forName("org.mariadb.jdbc.Driver"); // JDBC 드라이버 로드
		String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
		String DB_name="root";
		String DB_pw="2230";
	    conn = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
	    stmt = conn.createStatement();
	    String query = "SELECT name, price, img, imgpath FROM shop_product";
	    rs = stmt.executeQuery(query);
%>	    
		<div align="center">
	<h3>[오늘의 특가]</h3>
	    <table border="1">
		<%
		int i=0;
		while(rs.next()) {
		    String name = rs.getString("name");
		    int price = rs.getInt("price");
		    String img = rs.getString("img");
		    String imgpath = rs.getString("img").replace("\\", "/"); // 백슬래시를 슬래시로 변경
		    i++;
		    if(i % 3 == 1) { 
		        out.println("<tr align='center'>");
		    }
		    out.println("<td>");
		        out.println("<table>");
		            out.println("<tr align='center'>");
		                out.println("<td>");
		                    out.println("<img src = 'img/" + imgpath + "' width='150' height='150' />");
		                out.println("</td>");
		            out.println("</tr>");
		            
		            out.println("<tr align='center'>");
		                out.println("<td>");
		                    out.println("<b>" + name + "</b>");
		                out.println("</td>");
		            out.println("</tr>");
		            
		            out.println("<tr align='center'>");
		                out.println("<td>");
		                    out.println("<b>￦" + price + "원</b>");
		                out.println("</td>");
		            out.println("</tr>");
		            
		            out.println("<tr align='center'>");
		                out.println("<td>");
		                    out.println("<input type='button' value='상품정보수정' ");
		                    out.println("onclick='ProductModify(\"" + name + "\", \"" + price + "\")' />");
		                out.println("</td>");
		            out.println("</tr>");
		        out.println("</table>");
		    out.println("</td>");	
		}
		%>	
	</table>
	</div>
<%
	} catch (SQLException e) {
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
</body>
</html>