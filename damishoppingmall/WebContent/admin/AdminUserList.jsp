<!-- /* AdminUserList.jsp */  -->

<%@ page contentType="text/html;charset=UTF-8" import="java.sql.*" %>
<!-- 회원목록 보기(데이터베이스에서 목록을 가져옴) -->

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
    String query = "SELECT userType, id, passwd, name, email, phone, address FROM member"; // DB에 전송할 쿼리문 생성 목록을 나타내기 위해 SELECT문을 사용했습니다. 
    rs = stmt.executeQuery(query);
%>

<b><font size="5" color="gray">전체 회원 목록</font></b>
<br><br>
<%-- 입력된 값을 추출한다. --%>
<table border="1" cellspacing="0">
	<tr>
		<th>사용자 유형</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>이메일</th>
		<th>연락처</th>
		<th>주소</th>
		
		<th>비고 </th>	
	</tr>
	
<%
    while(rs.next()) {
    	if(rs.getString("userType").equals("Admin")) continue;
%>	<tr>
		<td><%=rs.getString("userType")%></td>
		<td><%=rs.getString("id")%></td>
		<td><%=rs.getString("passwd") %></td>
		<td><%=rs.getString("name") %></td>
		<td><%=rs.getString("email") %></td>
		<td><%=rs.getString("phone") %></td>
		<td><%=rs.getString("address")%></td>
		
		<td> 
		<input type="button" value="삭제" 
		onClick="location.href='AdminUserDel.jsp?id=<%=rs.getString("id")%>'"> <!-- AdminUserDel.jsp링크를 이용하여 해당 테이블의 데이터들을 삭제 -->
		<input type="button" value="수정" 
		onClick="location.href='AdminModForm.jsp?id=<%=rs.getString("id")%>'"> <!-- AdminUserMdfForm.jsp로 이동하여 해당 테이블의 데이터값들을 수정 -->
		</td>
	</tr>
<%
} // end while
%></table>
	<br>
	<input type="button" value=" 확 인 " 
	onClick="location.href='../AdminMain.jsp'">


<%
	rs.close();     // ResultSet 종료
    stmt.close();     // Statement 종료
    conn.close(); 	// Connection 종료
} catch (SQLException e) { // 예외처리
      out.println("err:"+e.toString());
} 
%>