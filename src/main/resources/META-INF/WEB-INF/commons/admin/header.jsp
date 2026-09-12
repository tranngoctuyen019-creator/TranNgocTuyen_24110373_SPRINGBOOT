<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="admin-topbar">
    <div class="admin-topbar-title">Trang quản trị</div>

    <c:if test="${not empty sessionScope.account}">
        <span class="admin-topbar-user">
            Xin chào, ${sessionScope.account.fullName}
        </span>
    </c:if>
</div>