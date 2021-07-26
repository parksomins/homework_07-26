<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.db.Dbconn" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('로그인 후 사용하세요');
		location.href="../login.jsp";
		
	</script>
<%
	}else{
		
		   String b_idx = request.getParameter("b_idx");
		   Connection conn = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   String sql = "";
		   
	      String b_title = "";
	      String b_content = "";
	      String b_regdate = "";
	      int b_like = 0;
	      int b_hit = 0;
	      
	      try{
		      conn = Dbconn.getConnection();
		      if(conn != null){
		    	sql = "select * from tb_board where b_idx=?";
		    	pstmt = conn.prepareStatement(sql);
		    	pstmt.setString(1, b_idx);
		    	rs = pstmt.executeQuery();
		    	  if(rs.next()){
						b_title = rs.getString("b_title");
						b_content = rs.getString("b_content");
						b_regdate = rs.getString("b_regdate");		
		    	  }
		      }
	   }catch(Exception e){
		   e.printStackTrace();
	   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>글 수정</h2>
	<form method="post" action="edit_ok.jsp?b_idx=<%=b_idx%>">
		<p>작성자 : <%=session.getAttribute("userid") %></p>
		<p><label>제목 : <input type="text" name="b_title" value="<%=b_title %>"></label></p>
		<p>내용</p>
		<p><textarea rows="5" cols="40" name="b_content"><%=b_content %></textarea></p>
		<p><input type="submit" value="수정완료"> <input type="reset" value="다시작성">
	</form>
</body>
</html>
<%
	}
%>