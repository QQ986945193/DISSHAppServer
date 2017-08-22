<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<html>
<head>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.tabfont01 {	
	font-family: "宋体";
	font-size: 9px;
	color: #555555;
	text-decoration: none;
	text-align: center;
}
.font051 {font-family: "宋体";
	font-size: 12px;
	color: #333333;
	text-decoration: none;
	line-height: 20px;
}
.font201 {font-family: "宋体";
	font-size: 12px;
	color: #FF0000;
	text-decoration: none;
}
.button {
	font-family: "宋体";
	font-size: 14px;
	height: 37px;
}
td {
	max-width:280px;
}
html { overflow-x: auto; overflow-y: auto; border:0;} 
-->
</style>

<link href="resource/admin/css/css.css" rel="stylesheet" type="text/css" />
<link href="resource/admin/css/style.css" rel="stylesheet" type="text/css" />
</head>
<SCRIPT language=JavaScript>
function sousuo(){
	window.open("gaojisousuo.htm","","depended=0,alwaysRaised=1,width=800,height=510,location=0,menubar=0,resizable=0,scrollbars=0,status=0,toolbar=0");
}
function selectAll(){
	var obj = document.fom.elements;
	for (var i=0;i<obj.length;i++){
		if (obj[i].name == "delid"){
			obj[i].checked = true;
		}
	}
}

function unselectAll(){
	var obj = document.fom.elements;
	for (var i=0;i<obj.length;i++){
		if (obj[i].name == "delid"){
			if (obj[i].checked==true) obj[i].checked = false;
			else obj[i].checked = true;
		}
	}
}

function link(){
    document.getElementById("fom").action="addrenwu.htm";
   document.getElementById("fom").submit();
}

</SCRIPT>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30">      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" background="resource/admin/images/nav04.gif">
           <form action="vip!getAllVips.do" method="post" style="margin:0px;">
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
			  <td width="21"><img src="resource/admin/images/ico07.gif" width="20" height="18" /></td>
			  <td width="538">搜索笑话：
			  	状态：<select id="vState" name="vState">
					<option value="不限">不限</option>
					<option value="可用">可用</option>
					<option value="删除">删除</option>
				</select>
				关键字：<input name="vipName" value="${requestScope.map.vipName}" class="login-input" type="text" style="width:150px;height:20px;"/>
			 	<input name="Submit4" type="submit" class="right-button02" value="查 询" />
			  </td>
			   <td width="144" align="left"><a href="#" onclick="sousuo()">
			   </td>	
		    </tr>
          </table></form></td>
        </tr>
    </table></td></tr>
  <tr>
    <td><table id="subtree1" style="DISPLAY: " width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="40" class="font42">
				<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#464646" class="newfont03">
				 <tr class="CTitle" >
                    	<td height="22" colspan="9" align="center" style="font-size:16px">笑话列表</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  	<td>编号</td>
                    <td>内容</td>
					<td>审核状态</td>
					<td>顶数</td>
					<td>踩数</td>
					<td>用户昵称</td>
					<td>创建日期</td>
					<td>操作</td>
                  </tr>
               <c:forEach items="${pageResult.list}" var="joke" varStatus="s">
				  <tr bgcolor="#FFFFFF" align="center" height="20px">
				  	<td >${joke.id }</td>
                    <td >${joke.content }</td>
                    <td>${joke.isPass }</td>
                    <td>${joke.supportsNum } </td>
                    <td>${joke.opposesNum }</td>
                    <td>${joke.userNike }</td>
                    <td>
                    	<%-- <c:if test="${v.vipstate eq '可用'}" var="f2">${v.vipstate }</c:if>
	            		<c:if test="${not f2 }"><span class="font-top1">${v.vipstate }</span></c:if> --%>
	            		<fmt:formatDate value="${joke.createDate}" pattern="yyyy-MM-dd" />
	            	</td>
                    <td>
                    	<img src="resource/admin/images/index1_68.gif"/> <a class="A-hong" href="vip!findVipToUpdateAdmin.do?vipid=${v.vipid }">修改</a>
                    </td>
                  </tr>
               </c:forEach>
            </table></td>
        </tr>
      </table>
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="6"><img src="resource/admin/images/spacer.gif" width="1" height="1" /></td>
        </tr>
        <tr>
          <td height="33"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="right-font08">
              <tr>
                <td width="50%">共<span class="right-text09">${pageResult.pageCount }</span>页 | 第<span class="right-text09">${pageResult.pageIndex }</span>页
                    |总共${pageResult.totalCount }条记录&nbsp;&nbsp;|每页显示${pageResult.pageSize} 个
                </td>
                <td width="49%" align="right">[<a href="javascript:changePage('1')" class="right-font08">首页</a> | <a href="javascript:changePage('-')" class="right-font08">上一页</a> | <a href="javascript:changePage('+')" class="right-font08">下一页</a> | <a href="javascript:changePage('n')" class="right-font08">末页</a>] 转至：</td>
                <td width="1%"><table width="20" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <%--跳转到某个页。传入用户输入的内容和页码

                        vState 状态：分为 可用，删除等
                        page：页码，分页的内容
                        --%>
                      <td width="1%"><input id="page" name="textfield3" type="text" class="right-textfield03" size="1" value="${requestScope.map.page }" maxlength="2" onkeypress="return check(event)" onpaste="return false;" ondragenter="return false" style="ime-mode:disabled"/></td>
                      <td width="87%"><input name="Submit23222" type="button" class="right-button06" onclick="goPage()" value=" " />
                      <input type="hidden" value="${requestScope.map.vState }" name="state">
                      <input type="hidden" value="${requestScope.map.page }" name="pageNo">
                      </td>
                    </tr>
                </table></td>
              </tr>
          </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>

<script type="text/javascript">
	//只能是数字
	function check(event){
		var e = event || window.event;
		var code = e.charCode || e.keyCode;
		if(code >= 48 && code <= 57  || code == 8){
			return true;
		}
		return false;
	}
	//下一页
	function changePage(op){
		if(op=='1'){
			location = "<%=basePath%>admin/joke/list?offset=1";
		}else if(op=='-'){
			location = "<%=basePath%>admin/joke/list?offset=${pageResult.pageIndex-1 }";
		}else if(op=='+'){
			location = "<%=basePath%>admin/joke/list?offset=${pageResult.pageIndex+1 }";
		}else if(op=='n'){
			location = "<%=basePath%>admin/joke/list?offset=${pageResult.pageCount }";
		}
	}
	//直接跳转到某页
	function goPage(){
		var page = document.getElementById("page").value;
		if(page==""){
			alert("请输入要跳转的页码！");
		}else{
			if(!isNaN(page)){
			    /*输入的内容，然后进行跳转到action*/
			   // alert(page);
			    //alert(requestScope.map.vState);
			    //alert(requestScope.map.vipName);
				location = "<%=basePath%>admin/joke/goPage?pageCount="+page+"&vState="+encodeURI("${requestScope.map.vState}")+"&vipName="+encodeURI("${requestScope.map.vipName}");
			}
		}
	}
	
	onload = function(){
		if('${requestScope.map.vState}'!=''){
			document.getElementById("vState").value = "${requestScope.map.vState}";
		}
	}
	
</script>

</html>