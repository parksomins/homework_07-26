<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.koreait.db.Dbconn"%>
<%@page import="java.sql.*"%>
<%
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('�α��� �� ����ϼ���');
		location.href="../login.jsp";
		
	</script>
<%
	}else{
		String b_idx = request.getParameter("b_idx");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql ="";
		
		try{
			  
			conn = Dbconn.getConnection();
			if(conn != null){
				sql = "delete from tb_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>
	<script>
		alert('�����Ǿ����ϴ�.');
		location.href="list.jsp";
	</script>
<%
	}
%>