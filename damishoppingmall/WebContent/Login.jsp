<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
 			<!-- 로그인 페이지 입니다. -->
<head>
    <%
    	request.setCharacterEncoding("UTF-8");  
    %>
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
                inputForm.id.focus();
                return false;
            }
            if(!inputForm.passwd.value) {
                alert("비밀번호를 입력하세요");    
                inputForm.passwd.focus();
                return false;
            }
        } 
        
     // 회원가입 버튼 클릭시 회원가입 화면으로 이동
		function goJoin() {
			location.href="Join.jsp";
		}	
		
		function goAdminLoginPro() {
			location.href="../admin/AdminLoginPro()";
		}
    </script>
 
</head>

<body>
    <div id="wrap">
    	<b><font size="600" color="gray"> <i class="fas fa-sign-in-alt"></i>Login</font></b>
        <br><br>
        <form name="loginInfo" method="post" onsubmit="return checkValue()" action="Pro/LoginPro.jsp">
       		
       		<!-- 이미지 추가 -->
			<img src="img/dog1.jpg" width= "200" height="180">
			<br>
 
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
            <input type="submit" value=" 로그인 "> 
            <input type="button" value=" 회원가입 " onClick="goJoin()">
            <br><br>
            <input type="button" value=" 아이디 / 비밀번호 찾기 ">
        </form>
    </div>    
</body>
</html>