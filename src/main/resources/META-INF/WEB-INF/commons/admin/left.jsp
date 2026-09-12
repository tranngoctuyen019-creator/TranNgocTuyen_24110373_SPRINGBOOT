<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value="${pageContext.request.requestURI}" />
<div class="admin-sidebar">
	<div class="admin-brand">Ngọc Tuyên <span>Admin</span></div>

	<ul class="admin-nav">
		<li><a href="<c:url value='/admin/home'/>" class="${fn:contains(uri, '/admin/home') ? 'active' : ''}">Trang chủ</a></li>
		<li><a href="<c:url value='/admin/categories/list'/>" class="${fn:contains(uri, '/admin/categories') ? 'active' : ''}">Quản lý danh mục</a></li>
		<li><a href="<c:url value='/admin/user/list'/>" class="${fn:contains(uri, '/admin/user') ? 'active' : ''}">Quản lý user</a></li>
	</ul>
	
	<div class="admin-sidebar-bottom">
		<a href="<c:url value='/home'/>">Xem trang bán hàng</a>
		<a href="<c:url value='/logout'/>">Đăng xuất</a>
	</div>
</div>
