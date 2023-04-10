<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@include file="UserTop.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dami_snackmall</title>
<script type="text/javascript">

function fnCart(name, price) {
	//alert("Name : " + name + "\nPrice : " + price);
	if(confirm("장바구니에 담으시겠습니까?")) {
		location.href = "Pro/CartPro.jsp?name=" + name + "&price=" + price;
	}
}

function fnView() {
	if(confirm("장바구니를 보시겠습니까?")){
		location.href = "view/CartView.jsp";
	}
}
function fndetail() {
	
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
		<tr align="right">
			<td colspan="3">
				<input type="button" value="장바구니 보기" onclick="fnView()" />
			</td>
		</tr>
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
		                  //한 줄로 쓰기
							//out.println("<input type='button' value='장바구니 담기' onclick='fnCart(\"" + name[i] + "\", \"" + price[i] + "\")' />");
							//두 줄로 쓰기, 닫는 큰 따옴표와 괄호 옆의 띄어쓰기 필수
							out.println("<input type='button' value='장바구니 담기' ");
							out.println("onclick='fnCart(\"" + name + "\", \"" + price + "\")' />");
							out.println("<input type='button' value='상세 페이지'");
							out.println("onclick='000000(\"" + name + "\", \"" + price + "\")' />");
		
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