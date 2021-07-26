<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.koreait.db.Dbconn"%>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
String b_idx = request.getParameter("b_idx");
	if(session.getAttribute("userid") == null){	
%>
	<script>
		alert('로그인 후 사용하세요');
		location.href="../login.jsp";
		
	</script>
<%
	}else{
		String b_title = request.getParameter("b_title");
		String b_content = request.getParameter("b_content");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		int b_like = 0;
		
		try{
			  
				conn = Dbconn.getConnection();
				if(conn != null){
					sql = "update tb_board set b_like = b_like + 1 where b_idx=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, b_idx);
					pstmt.executeUpdate();
					
					sql = "select b_like from tb_board where b_idx=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, b_idx);
					rs = pstmt.executeQuery();
					
					if(rs.next()){
						b_like = rs.getInt("b_like");
						out.print(b_like);
					}
				}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

%>
