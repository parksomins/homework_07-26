<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   ResultSet rs_reply = null;
   String sql = "";
   int totalCount = 0;
   int pagePerCount = 10; // 페이지당 글갯수
   int start = 0;  //시작 글번호
   
   //http://localhost:8080/Day4/board/list.jsp?pageNum=2
   String pageNum = request.getParameter("pageNum");
   if(pageNum != null && !pageNum.equals("")){
	   start = (Integer.parseInt(pageNum) - 1) * pagePerCount;
   }else{
	   pageNum = "1";
	   start = 0;
   }
   
   try{
      conn = Dbconn.getConnection();
      sql = "select count(b_idx) as total from tb_board";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      if(rs.next()){
         totalCount = rs.getInt("total");
      }
      
      sql = "select b_idx, b_userid, b_title, b_regdate, b_hit, b_like from tb_board order by b_idx desc limit ?, ?";
      /* 
      	select * from tb_board order by b_idx desc limit 0, 10;  -- 0부터 10개
      	select * from tb_board order by b_idx desc limit 10, 10;  -- 10부터 10개
      	select * from tb_board order by b_idx desc limit 20, 10;  -- 20부터 10개
      */
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, start);
      pstmt.setInt(2, pagePerCount);
      rs = pstmt.executeQuery();
   }catch(Exception e){
      e.printStackTrace();
   }
%>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String nowDate = sf.format(nowTime);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
   <h2>리스트</h2>
   <p>게시글 : <%=totalCount%>개</p>
   
   <table border="1" width="800">
      <tr>
         <th width="50">번호</th>
         <th width="300">제목</th>
         <th width="100">글쓴이</th>
         <th width="75">조회수</th>
         <th width="200">날짜</th>
         <th width="75">좋아요</th>
      </tr>
<%
   while(rs.next()){
      String b_idx = rs.getString("b_idx");
      String b_userid = rs.getString("b_userid");
      String b_title = rs.getString("b_title");
      String b_regdate = rs.getString("b_regdate").substring(0, 10);
      String b_hit = rs.getString("b_hit");
      String b_like = rs.getString("b_like");
      
      sql = "select count(re_idx) as replycnt from tb_reply where re_boardidx=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, b_idx);
      rs_reply = pstmt.executeQuery();
      
      int replycnt = 0;
      String replycnt_str = "";
      if(rs_reply.next()){
    	  replycnt = rs_reply.getInt("replycnt");
    	  if(replycnt > 0){
    		  replycnt_str = "["+replycnt+"]";
    	  }
      }
      
      
%>
      <tr>
         <td><%=b_idx%></td>
         <!-- 게시물 idx (글번호) 를 가져옴 -->
         <td><a href="./view.jsp?b_idx=<%=b_idx%>"><%=b_title%></a> <%=replycnt_str %>
<%
	if(b_regdate.equals(nowDate)){
		
%>
		<img src="new.png">
<%
	}
%>
		</td>
         <td><%=b_userid%></td>
         <td><%=b_hit%></td>
         <td><%=b_regdate%></td>
         <td><%=b_like%></td>
      </tr>

<%
   }

	int pageNums = 0;
	if(totalCount % pagePerCount == 0){
		pageNums = (totalCount / pagePerCount);  // 23 / 10
	}else{
		pageNums = (totalCount / pagePerCount) + 1;
	}
%>
	<tr>
		<td colspan="6" align="center">
			<%
				for(int i=1; i<=pageNums; i++){
					out.print("<a href='list.jsp?pageNum="+i+"'>["+i+"]</a> ");
				}
			%>

		</td>
	</tr>
   </table>
   
   
   <p><input type="button" value="글쓰기" onclick="location.href='write.jsp'">
   <input type="button" value="메인" onclick="location.href='../login.jsp'">
   </p>
</body>
</html>
