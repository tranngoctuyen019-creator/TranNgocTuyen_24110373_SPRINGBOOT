				<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<style>
	.page-wrap { max-width: 1180px; margin: 0 auto; padding: 36px 20px 60px; }
	.hero { border: 1px solid var(--border); padding: 32px; margin-bottom: 32px; }
	.hero h1 { font-weight: 600; font-size: 24px; margin: 0 0 8px; }
	.hero p { margin: 0; color: var(--muted); }
	.section-title { font-weight: 600; font-size: 17px; color: var(--ink); margin: 0 0 18px; border-bottom: 1px solid var(--border); padding-bottom: 10px; }
	.category-grid { display: flex; flex-wrap: wrap; gap: 18px; }
	.category-card { background: var(--surface); border: 1px solid var(--border); width: calc(20% - 15px); min-width: 200px; text-decoration: none; color: var(--ink); display:block; }
	.category-card:hover { border-color: var(--accent); text-decoration: none; color: var(--ink); }
	.category-card img { width: 100%; height: 150px; object-fit: cover; border-bottom: 1px solid var(--border); }
	.category-info { padding: 14px; text-align: center; }
	.category-info .c-name { font-weight: 500; font-size: 15px; }
	.empty-box { background: var(--surface); border: 1px solid var(--border); padding: 40px; text-align: center; color: var(--muted); }
	.pagination-bar { display: flex; justify-content: center; gap: 8px; margin-top: 26px; }
	.pagination-bar .page-link { display: inline-block; min-width: 40px; text-align: center; padding: 9px 14px; border: 1px solid var(--border); border-radius: 4px; color: var(--ink); font-size: 15px; text-decoration: none; background: var(--surface); }
	.pagination-bar .page-link:hover { background: #f2f2f2; text-decoration: none; }
	.pagination-bar .page-link.active { background: var(--accent); border-color: var(--accent); color: #fff; }
</style>
</head>
<body>
	<div class="page-wrap">
		<c:if test="${param.error == 'forbidden'}">
			<div class="alert alert-danger">Bạn không có quyền truy cập khu vực quản trị.</div>
		</c:if>
		<div class="hero">
			<h1>Chào mừng đến với Ngọc Tuyên Shop</h1>
			<p>Khám phá những danh mục sản phẩm của chúng tôi</p>
		</div>

		<h3 class="section-title">Danh mục sản phẩm</h3>

		<c:choose>
			<c:when test="${empty categories}">
				<div class="empty-box">Chưa có danh mục nào.</div>
			</c:when>
			<c:otherwise>
				<div class="category-grid">
					<c:forEach items="${categories}" var="cate">
						<a class="category-card" href="<c:url value='/product'><c:param name='cateId' value='${cate.categoryId}'/></c:url>">
							<c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
							<img src="${imgUrl}" alt="${cate.categoryname}" onerror="this.src='https://placehold.co/300x200?text=No+Image'">
							<div class="category-info">
								<div class="c-name">${cate.categoryname}</div>
							</div>
						</a>
					</c:forEach>
				</div>

				<c:if test="${totalPages > 1}">
					<div class="pagination-bar">
						<c:if test="${currentPage > 1}">
							<c:url value="/home" var="prevPageUrl">
								<c:param name="page" value="${currentPage - 1}"/>
							</c:url>
							<a href="${prevPageUrl}" class="page-link">&laquo; Trước</a>
						</c:if>

						<c:forEach begin="1" end="${totalPages}" var="p">
							<c:url value="/home" var="pageUrl">
								<c:param name="page" value="${p}"/>
							</c:url>
							<a href="${pageUrl}" class="page-link ${p == currentPage ? 'active' : ''}">${p}</a>
						</c:forEach>

						<c:if test="${currentPage < totalPages}">
							<c:url value="/home" var="nextPageUrl">
								<c:param name="page" value="${currentPage + 1}"/>
							</c:url>
							<a href="${nextPageUrl}" class="page-link">Sau &raquo;</a>
						</c:if>
					</div>
				</c:if>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
