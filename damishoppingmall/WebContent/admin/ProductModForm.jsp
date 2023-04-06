<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.sql.*" %>
    
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 관리 페이지</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8"); 
    //회원정보페이지에서 수정버튼 클릭시 보내진 img값 받기    
    String img = request.getParameter("img");
    //객체참조변수 선언    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
        
    //DB 드라이버 로딩           
    Class.forName("org.mariadb.jdbc.Driver");       
    //DB 연결, 객체생성           
    conn = DriverManager.getConnection
    ("jdbc:mariadb://127.0.0.1:3307/createtable", "root", "2230");        
    //쿼리문 준비           
    pstmt = conn.prepareStatement("SELECT name, price, img, imgpath FROM shop_product WHERE img=?");        
    pstmt.setString(1, img);    
    //쿼리문 실행          
    rs = pstmt.executeQuery();       
    //결과값 사용            
    rs.next();
%>       
	<h1>상품 정보 수정</h1>
	<form action="ProductModPro.jsp" method="post">
    	상 품 명 변 경 <input type="text" name="name" value="<%=rs.getString("name")%>"><br>
    	가 격  변  경 <input type="text" name="price" value="<%=rs.getString("price")%>"><br>
    	이미지 파일명 <input type="text" name="img" value="<%=rs.getString("img")%>" readonly><br>
    	이미지 파일주소 <input type="text" name="imgpath" value="<%=rs.getString("imgpath")%>" readonly><br>
    
    	<input type="submit" value="수정">
	</form>

</body>
</html>