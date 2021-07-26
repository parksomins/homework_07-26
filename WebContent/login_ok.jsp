<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn" %>
<%
   String userid = request.getParameter("userid");
   String userpw = request.getParameter("userpw");
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String sql = "";


   try{
      conn = Dbconn.getConnection();
      if(conn != null){
         sql = "select * from tb_member where mem_userid=? and mem_userpw=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, userid);
         pstmt.setString(2, userpw);
         rs = pstmt.executeQuery();
         
         if(rs.next()){
            //로그인 성공
            session.setAttribute("userid", userid);
            session.setAttribute("idx", rs.getString("mem_idx"));
            session.setAttribute("name", rs.getString("mem_name"));
        	session.setAttribute("hp", rs.getString("mem_hp"));
        	session.setAttribute("hobby", rs.getString("mem_hobby"));
        	session.setAttribute("email", rs.getString("mem_email"));
        	session.setAttribute("ssn1", rs.getString("mem_ssn1"));
        	session.setAttribute("ssn2", rs.getString("mem_ssn2"));
        	session.setAttribute("zipcode", rs.getString("mem_zipcode"));
        	session.setAttribute("address1", rs.getString("mem_address1"));
        	session.setAttribute("address2", rs.getString("mem_address2"));
        	session.setAttribute("address3", rs.getString("mem_address3"));
%>
                  <script>
                     alert('로그인 되었습니다');
                     location.href='login.jsp';   // 새로고침
                  </script>
<%
         }else{
            //로그인 실패
%>
            <script>
               alert('아이디 또는 비밀번호를 확인하세요');
               history.back();   // 히스토리, 캐시
            </script>
<%
         }
      }
   }catch(Exception e){
      e.printStackTrace();
   }      
%>