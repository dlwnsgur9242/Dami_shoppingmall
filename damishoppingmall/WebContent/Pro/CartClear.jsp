<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 장바구니 모두 삭제 기능 -->


<%
session.getAttribute("cart");
session.removeAttribute("cart");
response.sendRedirect("../UserMain.jsp");
%>