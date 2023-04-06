<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>상품 등록 페이지</title>
    <style>
        #wrap{
            width:530px;
            margin-left:auto; 
            margin-right:auto;
            text-align:center;
        }
        
        table{
            border:3px solid red
        }
        
        td{
            border:1px solid pink
        }
        
        #title{
            background-color:pink
        }
    </style>

    <script type="text/javascript">
	
		// 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
		function checkValue() {
			if(!document.userInfo.name.value){
				alert("상품명을 입력하세요.");
				return false;
			}
			
			if(!document.userInfo.price.value){
				alert("가격을 입력하세요.");
				return false;
			}
			
			// 이미지 파일 등록 확인
			if(!document.userInfo.img.value){
				alert("이미지 파일을 입력하세요.");
				return false;
			}
			
		}
		
		// 취소 버튼 클릭시 로그인 화면으로 이동
		function goProductList() {
			location.href="../admin/ProductList.jsp";
		}
	</script>
</head>
<body>
   <!-- div 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
	<div id="wrap">
		<br><br>
		<b><font size="6" color="gray">상 품 등 록</font></b>
		<br><br><br>

		<!-- 입력한 값을 전송하기 위해 form 태그를 사용한다 -->
		<!-- 값(파라미터) 전송은 POST 방식, 전송할 페이지는 JoinPro.jsp -->
		<form method="post" action="pro/JoinPro.jsp" name="userInfo"
			onsubmit="return checkValue()" enctype="multipart/form-data">
            <table>
                <tr>
                    <td id="title">상 품 명</td>
                    <td>
                        <input type="text" name="name" maxlength="20">  
                        <input type="button" value=" 중복확인 ">
                    </td>
                </tr>

                <tr>
                    <td id="title">가 격</td>
                    <td>
                        <input type="text" name="price" maxlength="30">
                    </td>
                </tr>

                <tr>
                    <td id="title">이미지 파일명</td>
                    <td>
                        <input type="file" name="img" maxlength="150">
                    </td>
                </tr>

            </table>
            <br>
            <input type="submit" value=" 가 입 ">  <input type="button" value=" 취 소 " onclick="goProductList()">
        </form>
    </div>
</body>
</html>