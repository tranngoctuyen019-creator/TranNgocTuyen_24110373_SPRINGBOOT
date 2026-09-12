<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <style>
        :root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; --danger: #a13d3d; }
        * { box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); margin: 0; }
        .page-wrap { max-width: 600px; margin: 60px auto; padding: 0 20px; }
        .page-header { text-align: center; margin-bottom: 22px; }
        .page-header h1 { font-size: 26px; font-weight: 600; margin: 0; }
        .page-header p { color: var(--muted); margin: 6px 0 0; font-size: 15px; }
        .form-card { background: var(--surface); border: 1px solid var(--border); padding: 28px 30px; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-weight: 500; color: var(--ink); font-size: 15px; margin-bottom: 7px; }
        .form-control { display: block; width: 100%; border: 1px solid var(--border); border-radius: 4px; padding: 11px 14px; font-size: 16px; background: #fff; color: var(--ink); }
        .form-control:focus { outline: none; border-color: var(--accent); }
        .btn { border-radius: 4px; font-weight: 500; padding: 12px 24px; border: none; width: 100%; font-size: 16px; cursor: pointer; }
        .btn-success { background: var(--accent); color: #fff; }
        .btn-success:hover { background: var(--accent-dark); color: #fff; }
        .alert { border-radius: 4px; padding: 12px 16px; margin-bottom: 18px; font-size: 14.5px; }
        .alert-danger { background: #fbeaea; color: var(--danger); border: 1px solid #eccaca; }
        .alert-success { background: #eaf4ee; color: var(--accent-dark); border: 1px solid #cfe6d9; }
    </style>
</head>
<body>
    <div class="page-wrap">
        <div class="page-header">
            <h1><%= "Đăng nhập" %></h1>
            <p>Đăng nhập để tiếp tục</p>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <form action="<c:url value='/login'/>" method="post">
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <input type="text" class="form-control" name="username" value="${username}" required autofocus>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <button type="submit" class="btn btn-success">Đăng nhập</button>
            </form>
        </div>
    </div>
</body>
</html>
