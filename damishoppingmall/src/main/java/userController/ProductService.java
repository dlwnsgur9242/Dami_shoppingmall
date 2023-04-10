package userController;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class ProductService extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "img"; // 업로드된 파일들이 저장될 디렉토리 이름

    // 업로드 설정
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
    /**
     * 업로드 데이터를 추출하고 파일을 목적지 디렉토리에 저장
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        // 요청이 실제 업로드 파일을 포함하는지 확인
        if (!ServletFileUpload.isMultipartContent(request)) {
            PrintWriter writer = response.getWriter();
            writer.println("Request does not contain upload data");
            writer.flush();
            return;
        }

        // 업로드 설정 구성
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // 업로드 파일을 저장할 디렉토리 경로 생성
        String uploadPath = getServletContext().getRealPath("")
                + File.separator + UPLOAD_DIRECTORY;

        // 디렉토리가 존재하지 않으면 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        try {
            // 요청 내용을 파싱하여 파일 데이터 추출
            List<FileItem> formItems = upload.parseRequest(request);
            Iterator<FileItem> iter = formItems.iterator();

            while (iter.hasNext()) {
                FileItem item = iter.next();

                // 폼 필드가 아닌 필드만 처리
                if (!item.isFormField()) {
                    String fileName = new File(item.getName()).getName(); // 파일 이름 추출
                    String filePath = uploadPath + File.separator + fileName; // 파일 경로 생성
                    File storeFile = new File(filePath);

                    // 이름 충돌 및 기존 파일 덮어쓰기 방지를 위해 무작위 고유 파일 이름 생성
                    while(storeFile.exists()) {
                        fileName = UUID.randomUUID().toString() + "_" + new File(item.getName()).getName();
                        filePath = uploadPath + File.separator + fileName;
                        storeFile = new File(filePath);
                    }
                    // 디스크에 파일 저장
                    item.write(storeFile);
                    request.setAttribute("message", "File " + fileName + " has uploaded successfully!");// 업로드 성공 메시지
                }
            }
            // 파일 업로드 성공 메시지 출력
            request.setAttribute("message", "File(s) uploaded successfully.");
        } catch (Exception ex) {
            request.setAttribute("message", "There was an error: " + ex.getMessage());
        }
    }
}