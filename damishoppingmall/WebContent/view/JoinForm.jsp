<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <%
    	request.setCharacterEncoding("UTF-8");  
    %>
    <script src="https://kit.fontawesome.com/3edede7444.js" crossorigin="anonymous"></script>
    <title>로그인 페이지</title>
    
    <style>
        #wrap{
            width:270px;
            margin-left:auto; 
            margin-right:auto;
            text-align:center;
        }
        
        table{
            border:3px solid #d49466
        }
        
        td{
            border:1px solid #d49466
        }
        
        #title{
            background-color:#d49466
        }
    </style>
        
    <script>
        function checkValue() {
            inputForm = eval("document.loginInfo");
            if(!inputForm.id.value) {
                alert("아이디를 입력하세요");    
                inputForm.ID.focus();
                return false;
            }
            if(!inputForm.passwd.value) {
                alert("비밀번호를 입력하세요");    
                inputForm.PWD.focus();
                return false;
            }
        } 
        
     // 회원가입 버튼 클릭시 회원가입 화면으로 이동
		function goJoinForm() {
			location.href="JoinForm.jsp";
		}	
		
		function goAdminLoginPro() {
			location.href="../admin/AdminLoginPro()";
		}
    </script>
 
</head>

<body>
    <div id="wrap">
    	<b><font size="6" color="gray"> <i class="fas fa-sign-in-alt"></i> 로그인</font></b>
        <br>
        <form name="loginInfo" method="post" onsubmit="return checkValue()" action="../Pro/LoginPro.jsp">
       		
       		<!-- 이미지 추가 -->
			<img src="../img/welcome.jpg" class="resize-image" width="300" height="300">
			<br><br>
 
       		<table>
               <tr>
	               <td>아이디</td>
	               <td><input type="text" name="id" maxlength="100"></td>
               </tr>
               
               <tr>
	               <td>비밀번호</td>
	               <td><input type="password" name="passwd" maxlength="100"></td>
               </tr>
            </table>
            <br>
            <%-- <% System.out.println("111111111111111111");%> --%>
            <input type="submit" value=" 로그인 "> 
            <input type="button" value=" 회원가입 " onClick="goJoinForm()">
            <br><br>
            <input type="button" value=" 아이디 / 비밀번호 찾기 ">
        </form>
    </div>    
</body>
</html>