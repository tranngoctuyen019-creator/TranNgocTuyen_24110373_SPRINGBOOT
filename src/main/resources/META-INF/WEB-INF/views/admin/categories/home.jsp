<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ quản trị</title>

    <style>
        :root {
            --ink: #1c1c1c;
            --muted: #6b6b6b;
            --border: #dcdcdc;
            --surface: #ffffff;
            --accent: #2f5d50;
            --accent-dark: #24463c;
        }

        .page-wrap {
            width: 100%;
            max-width: none;
            margin: 0;
            box-sizing: border-box;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            border-bottom: 1px solid var(--border);
            padding-bottom: 18px;
            margin-bottom: 26px;
        }

        .topbar h1 {
            font-size: 22px;
            font-weight: 600;
            margin: 0;
        }

        .topbar p {
            margin: 4px 0 0;
            color: var(--muted);
            font-size: 14px;
        }

        .stat-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
            margin-bottom: 34px;
        }

        .stat-card {
            flex: 1 1 220px;
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 22px 24px;
        }

        .stat-card .stat-label {
            font-size: 13px;
            color: var(--muted);
            margin-bottom: 8px;
        }

        .stat-card .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--ink);
        }

        .stat-card a.stat-link {
            display: inline-block;
            margin-top: 12px;
            font-size: 13.5px;
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
        }

        .stat-card a.stat-link:hover {
            color: var(--accent-dark);
            text-decoration: underline;
        }

        .section-title {
            font-weight: 600;
            font-size: 17px;
            color: var(--ink);
            margin: 0 0 16px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--surface);
        }

        th, td {
            padding: 11px 14px;
            border-bottom: 1px solid var(--border);
            text-align: left;
            font-size: 14px;
        }

        th {
            color: var(--muted);
            font-weight: 600;
            font-size: 12.5px;
            text-transform: uppercase;
            letter-spacing: .03em;
        }

        .thumb {
            object-fit: cover;
            border: 1px solid var(--border);
        }

        .empty-box {
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 30px;
            text-align: center;
            color: var(--muted);
        }

        .pagination-bar {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 20px;
        }

        .pagination-bar .page-link {
            display: inline-block;
            min-width: 36px;
            text-align: center;
            padding: 7px 12px;
            border: 1px solid var(--border);
            border-radius: 4px;
            color: var(--ink);
            font-size: 14px;
            text-decoration: none;
            background: var(--surface);
        }

        .pagination-bar .page-link:hover {
            background: #f2f2f2;
            text-decoration: none;
        }

        .pagination-bar .page-link.active {
            background: var(--accent);
            border-color: var(--accent);
            color: #fff;
        }
    </style>
</head>

<body>
    <div class="page-wrap">

        <div class="topbar">
            <div>
                <h1>Xin chào<c:if test="${not empty sessionScope.account}">, ${sessionScope.account.fullName}</c:if></h1>
                <p>Đây là trang chủ khu vực quản trị.</p>
            </div>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-label">Tổng số danh mục</div>
                <div class="stat-value">${totalCategories}</div>
                <a class="stat-link" href="<c:url value='/admin/categories/list'/>">Quản lý danh mục &rarr;</a>
            </div>
            <div class="stat-card">
                <div class="stat-label">Tổng số user</div>
                <div class="stat-value">${totalUsers}</div>
                <a class="stat-link" href="<c:url value='/admin/user/list'/>">Quản lý user &rarr;</a>
            </div>
        </div>

        <div class="section-title">User mới nhất</div>

        <c:choose>
            <c:when test="${not empty latestUsers}">
                <table>
                    <thead>
                        <tr>
                            <th>Ảnh</th>
                            <th>Họ tên</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${latestUsers}" var="u">
                            <tr>
                                <td>
                                    <c:url value="/image" var="imgUrl">
                                        <c:param name="fname" value="${u.avatar}" />
                                    </c:url>
                                    <img class="thumb" height="52" width="52" style="border-radius:50%;" src="${imgUrl}" alt="Ảnh"
                                        onerror="this.src='https://placehold.co/52x52?text=U'" />
                                </td>
                                <td>${u.fullName}</td>
                                <td>${u.username}</td>
                                <td>${u.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.status == 1}">Hoạt động</c:when>
                                        <c:otherwise>Đã khóa</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:if test="${totalPages > 1}">

                    <div class="pagination-bar">

                        <c:if test="${currentPage > 1}">
                            <c:url value="/admin/home" var="prevPageUrl">
                                <c:param name="page" value="${currentPage - 1}" />
                            </c:url>
                            <a href="${prevPageUrl}" class="page-link">&laquo; Trước</a>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <c:url value="/admin/home" var="pageUrl">
                                <c:param name="page" value="${p}" />
                            </c:url>
                            <a href="${pageUrl}" class="page-link ${p == currentPage ? 'active' : ''}">${p}</a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <c:url value="/admin/home" var="nextPageUrl">
                                <c:param name="page" value="${currentPage + 1}" />
                            </c:url>
                            <a href="${nextPageUrl}" class="page-link">Sau &raquo;</a>
                        </c:if>

                    </div>

                </c:if>

            </c:when>
            <c:otherwise>
                <div class="empty-box">Chưa có user nào.</div>
            </c:otherwise>
        </c:choose>

    </div>
</body>
</html>
