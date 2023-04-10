<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.io.*" %>
<%@	page import="java.util.List" %>
<%@ page import="org.apache.commons.io.IOUtils" %>

<%
  String savePath = "C:/Users/JUNHYUK/git/Dami_shoppingmall/damishoppingmall/WebContent/admin/123"; // ������ ������ ���
  int maxFileSize = 500 * 1024 * 1024; // �ִ� ���� ũ�� (10MB)
  int maxMemSize = 500 * 1024; // �ִ� �޸� ũ�� (4KB)

  // ���� ���ε带 ó���ϱ� ���� DiskFileItemFactory ��ü ����
  DiskFileItemFactory factory = new DiskFileItemFactory();
  factory.setSizeThreshold(maxMemSize);

  // ���ε�� ������ �ӽ� ���丮�� �����ϱ� ���� FileItem ���ε� �ڵ鷯 ����
  ServletFileUpload upload = new ServletFileUpload(factory);
  upload.setSizeMax(maxFileSize);

  // Ŭ���̾�Ʈ�κ��� ���۵� ���ϵ��� �Ľ��Ͽ� List<FileItem>��ü�� ��ȯ
  List<FileItem> fileItems = upload.parseRequest(request);

  // ���ε�� ���ϵ��� �ݺ������� ó��
  for (FileItem item : fileItems) {
    if (!item.isFormField()) { // �����̸�
      String fileName = new File(item.getName()).getName(); // ���ϸ� ����
      String filePath = savePath + File.separator + fileName; // ���� ���� ��� ����
      item.write(new File(filePath)); // ���� ����
      out.println("File " + fileName + " uploaded successfully.");
    }
  }
%>