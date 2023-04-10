<!-- /* AdminUserList.jsp */  -->

<%@ page contentType="text/html;charset=UTF-8" import="java.sql.*" %>
<!-- 상품목록 보기(데이터베이스에서 목록을 가져옴) -->
<html>
<head>
    <title>상품 목록 페이지</title>
</head>
</html>
<%
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
String DB_name="root";
String DB_pw="2230";
Connection conn= null;
Statement stmt = null;
ResultSet rs   = null;
try {
    conn = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
    stmt = conn.createStatement();
    String query = "SELECT name, price, img, imgpath FROM shop_product"; // DB에 전송할 쿼리문 생성 목록을 나타내기 위해 SELECT문을 사용했습니다. 
    rs = stmt.executeQuery(query);
%>

<b><font size="5" color="gray">전체 상품 목록</font></b>
<br><br>
<%-- 입력된 값을 추출한다. --%>
<table border="1" cellspacing="0">
	<tr>
		<th>제품명</th>
		<th>가격</th>
		<th>이미지</th>
		<th>이미지주소</th>	
		
		<th>비고 </th>
	</tr>
	
<%
	while(rs.next()) {
%>	<tr>
	<td><%=rs.getString("name")%></td>
	<td><%=rs.getString("price")%></td>
	<td><%=rs.getString("img") %></td>
	<td><%=rs.getString("imgpath") %></td>
		
		<td> 
		<input type="button" value="삭제" 
		onClick="location.href='ProductDel.jsp?img=<%=rs.getString("img")%>'"> <!-- ProductDel.jsp링크를 이용하여 해당 테이블의 데이터들을 삭제 -->
		<input type="button" value="수정" 
		onClick="location.href='ProductModForm.jsp?img=<%=rs.getString("img")%>'"> <!-- ProductModForm.jsp로 이동하여 해당 테이블의 데이터값들을 수정 -->
		</td>
	</tr>
<%
	} // end while
%>	</table>
	<br>
	<input type="button" value=" 확 인 " 
	onClick="location.href='../AdminMain.jsp'">
	<input type="button" value=" 상 품 등 록 "
	onClick="location.href='../view/ProductForm.jsp'">	 <!-- ProductForm.jsp로 이동하여 DB에 제품의 정보를 등록 -->
<%
	rs.close();     // ResultSet 종료
    stmt.close();     // Statement 종료
    conn.close(); 	// Connection 종료
} catch (SQLException e) { // 예외처리
      out.println("err:"+e.toString());
} 
%>