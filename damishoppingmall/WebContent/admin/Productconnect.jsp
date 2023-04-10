<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.io.*" %>
<%@	page import="java.util.List" %>
<%@ page import="org.apache.commons.io.IOUtils" %>

<%
  String savePath = "C:/Users/JUNHYUK/git/Dami_shoppingmall/damishoppingmall/WebContent/admin/123"; // 파일을 저장할 경로
  int maxFileSize = 500 * 1024 * 1024; // 최대 파일 크기 (10MB)
  int maxMemSize = 500 * 1024; // 최대 메모리 크기 (4KB)

  // 파일 업로드를 처리하기 위한 DiskFileItemFactory 객체 생성
  DiskFileItemFactory factory = new DiskFileItemFactory();
  factory.setSizeThreshold(maxMemSize);

  // 업로드된 파일을 임시 디렉토리에 저장하기 위한 FileItem 업로드 핸들러 생성
  ServletFileUpload upload = new ServletFileUpload(factory);
  upload.setSizeMax(maxFileSize);

  // 클라이언트로부터 전송된 파일들을 파싱하여 List<FileItem>객체로 반환
  List<FileItem> fileItems = upload.parseRequest(request);

  // 업로드된 파일들을 반복문으로 처리
  for (FileItem item : fileItems) {
    if (!item.isFormField()) { // 파일이면
      String fileName = new File(item.getName()).getName(); // 파일명 추출
      String filePath = savePath + File.separator + fileName; // 파일 저장 경로 생성
      item.write(new File(filePath)); // 파일 저장
      out.println("File " + fileName + " uploaded successfully.");
    }
  }
%>