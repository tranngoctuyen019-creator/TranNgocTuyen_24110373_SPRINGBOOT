<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý user</title>

<style>
	:root {
		--ink: #1c1c1c;
		--muted: #6b6b6b;
		--border: #dcdcdc;
		--surface: #ffffff;
		--accent: #2f5d50;
		--accent-dark: #24463c;
		--danger: #a13d3d;
	}

	body {
		font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
			Roboto, Helvetica, Arial, sans-serif;
		background: #f6f6f4;
		color: var(--ink);
	}

	.page-wrap {
	    width: 100%;
	    max-width: none;
	    margin: 0;
	    padding: 48px 56px 72px;
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
		font-size: 32px;
		font-weight: 600;
		margin: 0;
	}

	.topbar p {
		color: var(--muted);
		font-size: 17px;
		margin: 4px 0 0;
	}

	.toolbar {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 22px;
		gap: 14px;
		flex-wrap: wrap;
	}

	.btn-add {
		background: var(--accent);
		color: #fff;
		font-weight: 500;
		border: none;
		border-radius: 4px;
		padding: 14px 28px;
		font-size: 19px;
		display: inline-block;
		text-decoration: none;
	}

	.btn-add:hover {
		background: var(--accent-dark);
		color: #fff;
		text-decoration: none;
	}

	.search-form {
		display: flex;
		gap: 10px;
	}

	.search-form input[type="text"] {
		height: 44px;
		border: 1px solid var(--border);
		border-radius: 4px;
		padding: 0 14px;
		font-size: 17px;
		min-width: 260px;
	}

	.search-form button {
		background: #fff;
		border: 1px solid var(--border);
		border-radius: 4px;
		padding: 0 20px;
		font-size: 17px;
		cursor: pointer;
	}

	.search-form button:hover {
		background: #f2f2f2;
	}

	table {
		margin-bottom: 0 !important;
		background: var(--surface);
		width: 100%;
	}

	.table > thead > tr > th {
		background: transparent;
		color: var(--muted);
		border-bottom: 1px solid var(--border) !important;
		border-top: none !important;
		font-weight: 600;
		font-size: 17px;
		padding: 18px 20px;
	}

	.table > tbody > tr > td {
		border-top: 1px solid #eee !important;
		vertical-align: middle !important;
		padding: 20px 18px;
		font-size: 18px;
	}

	img.thumb {
		border-radius: 50%;
		border: 1px solid var(--border);
		object-fit: cover;
	}

	.btn-sm {
		border-radius: 4px;
		font-weight: 500;
		padding: 9px 18px;
		border: 1px solid transparent;
		font-size: 17px;
	}

	.btn-primary {
		background: transparent;
		color: var(--accent);
		border-color: var(--accent);
		text-decoration: none;
	}

	.btn-primary:hover {
		background: var(--accent);
		color: #fff;
	}

	.btn-danger {
		background: transparent;
		color: var(--danger);
		border-color: var(--danger);
		text-decoration: none;
	}

	.btn-danger:hover {
		background: var(--danger);
		color: #fff;
	}

	.badge-status {
		display: inline-block;
		padding: 5px 12px;
		border-radius: 20px;
		font-size: 14px;
		font-weight: 600;
	}

	.badge-active {
		background: #e4f3ec;
		color: var(--accent-dark);
	}

	.badge-locked {
		background: #f6e5e5;
		color: var(--danger);
	}

	.empty-row {
		padding: 30px !important;
		color: var(--muted);
	}

	.pagination-bar {
		display: flex;
		justify-content: center;
		gap: 8px;
		margin-top: 26px;
	}

	.pagination-bar .page-link {
		display: inline-block;
		min-width: 40px;
		text-align: center;
		padding: 9px 14px;
		border: 1px solid var(--border);
		border-radius: 4px;
		color: var(--ink);
		font-size: 16px;
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

	<c:url value="/admin/user/add" var="addUserUrl" />
	<c:url value="/admin/user/list" var="listUserUrl" />

	<div class="page-wrap">

		<div class="topbar">

			<div>
				<h1>Quản lý user</h1>
				<p>Danh sách người dùng hiện có trong hệ thống</p>
			</div>
		</div>

		<div class="toolbar">

			<a href="${addUserUrl}" class="btn-add">
				Thêm user mới
			</a>

		</div>

		<table class="table table-hover">

			<thead>

				<tr>
					<th>STT</th>
					<th>Ảnh</th>
					<th>Họ tên</th>
					<th>Username</th>
					<th>Email</th>
					<th>SĐT</th>
					<th>Trạng thái</th>
					<th>Hành động</th>
				</tr>

			</thead>

			<tbody>

				<c:forEach items="${userList}" var="u" varStatus="STT">

					<tr>

						<td>
							${STT.index + 1}
						</td>

						<td>

							<c:url value="/image" var="imgUrl">

								<c:param
									name="fname"
									value="${u.avatar}" />

							</c:url>

							<img
								class="thumb"
								height="48"
								width="48"
								src="${imgUrl}"
								alt="Ảnh"
								onerror="this.src='https://placehold.co/48x48?text=U'" />

						</td>

						<td>
							${u.fullName}
						</td>

						<td>
							${u.username}
						</td>

						<td>
							${u.email}
						</td>

						<td>
							${u.phone}
						</td>

						<td>
							<c:choose>
								<c:when test="${u.status == 1}">
									<span class="badge-status badge-active">Hoạt động</span>
								</c:when>
								<c:otherwise>
									<span class="badge-status badge-locked">Đã khóa</span>
								</c:otherwise>
							</c:choose>
						</td>

						<td>

							<c:url
								value="/admin/user/edit"
								var="editUrl">

								<c:param
									name="id"
									value="${u.userId}" />

							</c:url>

							<a
								href="${editUrl}"
								class="btn btn-primary btn-sm">

								Sửa

							</a>

							<c:url
								value="/admin/user/delete"
								var="deleteUrl">

								<c:param
									name="id"
									value="${u.userId}" />

							</c:url>

							<a
								href="${deleteUrl}"
								class="btn btn-danger btn-sm"
								onclick="return confirm('Bạn có chắc chắn muốn xóa user này không?');">

								Xóa

							</a>

						</td>

					</tr>

				</c:forEach>

				<c:if test="${empty userList}">

					<tr>

						<td
							colspan="8"
							class="text-center empty-row">

							Chưa có user nào.

						</td>

					</tr>

				</c:if>

			</tbody>

		</table>

		<c:if test="${totalPages > 1}">

			<div class="pagination-bar">

				<c:if test="${currentPage > 1}">
					<c:url value="/admin/user/list" var="prevPageUrl">
						<c:param name="keyword" value="${keyword}" />
						<c:param name="page" value="${currentPage - 1}" />
					</c:url>
					<a href="${prevPageUrl}" class="page-link">&laquo; Trước</a>
				</c:if>

				<c:forEach begin="1" end="${totalPages}" var="p">
					<c:url value="/admin/user/list" var="pageUrl">
						<c:param name="keyword" value="${keyword}" />
						<c:param name="page" value="${p}" />
					</c:url>
					<a href="${pageUrl}" class="page-link ${p == currentPage ? 'active' : ''}">${p}</a>
				</c:forEach>

				<c:if test="${currentPage < totalPages}">
					<c:url value="/admin/user/list" var="nextPageUrl">
						<c:param name="keyword" value="${keyword}" />
						<c:param name="page" value="${currentPage + 1}" />
					</c:url>
					<a href="${nextPageUrl}" class="page-link">Sau &raquo;</a>
				</c:if>

			</div>

		</c:if>

	</div>

</body>

</html>
