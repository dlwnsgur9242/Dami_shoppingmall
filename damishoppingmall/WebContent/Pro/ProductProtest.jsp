<!-- /* JoinPro.jsp */-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.io.*" %>
<%@	page import="java.util.List" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
	<!-- 상품등록 처리, mariadb 연동 -->
	
	request.setCharacterEncoding("UTF-8");
	
<%
	String savePath = "C:/Users/JUNHYUK/git/Dami_shoppingmall/damishoppingmall/WebContent/img"; // 파일을 저장할 경로
	int maxFileSize = 10 * 1024 * 1024; // 최대 파일 크기 (10MB)
	int maxMemSize = 4 * 1024; // 최대 메모리 크기 (4KB)

	// 파일 업로드를 처리하기 위한 DiskFileItemFactory 객체 생성
	DiskFileItemFactory factory = new DiskFileItemFactory();
	factory.setSizeThreshold(maxMemSize);

	// 업로드된 파일을 임시 디렉토리에 저장하기 위한 FileItem 업로드 핸들러 생성
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setSizeMax(maxFileSize);
	
	// 클라이언트로부터 전송된 파일들을 파싱하여 List<FileItem> 객체로 반환
	List<FileItem> fileItems = upload.parseRequest(request);
	
	String name = "";
	String price = "";
	String img = "";

	for (FileItem item : fileItems) {
	  if (item.isFormField()) { // 일반 필드면
	    if (item.getFieldName().equals("name")) {
	      name = item.getString("UTF-8"); // name 값 저장
	    } else if (item.getFieldName().equals("price")) {
	      price = item.getString("UTF-8"); // price 값 저장
	    }
	  } else { // 파일이면
	    String fileName = new File(item.getName()).getName(); // 파일명 추출
	    String filePath = savePath + File.separator + fileName; // 파일 저장 경로 생성
	    item.write(new File(filePath)); // 파일 저장
	    out.println("File " + fileName + " uploaded successfully.");
	    
	    img = fileName; // 파일 이름만 추출하여 DB에 저장할 img 변수에 저장
	  }
	}
	
	try {
	  Class.forName("org.mariadb.jdbc.Driver");
	  String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable";
	  String DB_name="root";
	  String DB_pw="2230";
	
	  Connection con = DriverManager.getConnection(DB_URL, DB_name, DB_pw);
	  String sql = "INSERT INTO shop_product( name, price, img) VALUES (?,?,?)"; // sql문 작성(입력받은 값들을 보내기 위한 작업)
	
	  PreparedStatement pstmt = con.prepareStatement(sql);
	
	  pstmt.setString(1, name); // values에 들어갈 각각의 name, price, img 설정
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
  location.href='../admin/ProductList.jsp'; 
</script>