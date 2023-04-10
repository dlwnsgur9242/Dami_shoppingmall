package userController;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.http.Part;

@WebServlet("/ProductService")
public class ProductService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ProductService() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	@WebServlet("/upload") // URL 매핑 주소
	@MultipartConfig // 멀티파트 요청 처리를 위한 어노테이션
	public class UploadServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	    private static final String UPLOAD_DIRECTORY = "\\WebContent\\img"; // 업로드할 디렉터리 경로
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY; // 업로드할 디렉터리 경로
	        File uploadDir = new File(uploadPath); 
	        if (!uploadDir.exists()) { // 만약 디렉터리가 없으면 생성
	            uploadDir.mkdir();
	        }
	 
	        Part part = request.getPart("img"); // 파일을 전송받아서 파트 객체로 저장
	        String fileName = part.getSubmittedFileName(); // 파일 이름 저장
	        String filePath = uploadPath + File.separator + fileName; // 저장될 파일 경로
	 
	        part.write(filePath); // 업로드한 파일을 저장
	 
	        try {
	            String DB_URL = "jdbc:mariadb://127.0.0.1:3307/createtable"; // 데이터베이스 URL
	            String DB_name="root"; // 데이터베이스 사용자 이름
	            String DB_pw="2230"; // 데이터베이스 사용자 비밀번호
	            Class.forName("org.mariadb.jdbc.Driver"); // MariaDB JDBC 드라이버 클래스 로드
	            Connection conn = DriverManager.getConnection(DB_URL, DB_name, DB_pw); // 데이터베이스 연결
	            File file = new File(filePath); // 업로드한 파일 객체 생성
	            FileInputStream fis = new FileInputStream(file); // 파일을 바이트 스트림으로 읽어옴
	            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO shop_product(img) VALUES(?)"); // SQL 쿼리문을 생성
	            pstmt.setBinaryStream(1, fis, (int) file.length()); // 쿼리문에 파일 데이터를 바이너리 형식으로 저장
	            pstmt.executeUpdate(); // 쿼리 실행
	 
	            fis.close();
	            pstmt.close();
	            conn.close();
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	 
	        response.sendRedirect("index.jsp"); // 성공적으로 파일 업로드가 완료되면 index.jsp 페이지로 이동
	    }
	}
}
