<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Chỉnh sửa user</title>

    <style>

        :root {
            --ink: #1c1c1c;
            --muted: #6b6b6b;
            --border: #dcdcdc;
            --surface: #ffffff;
            --accent: #2f5d50;
            --accent-dark: #24463c;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
                         Roboto, Helvetica, Arial, sans-serif;
            background: #f6f6f4;
            color: var(--ink);
        }

        .page-wrap {
            max-width: 860px;
            margin: 0 auto;
            padding: 46px 24px 70px;
        }

        .topbar {
            border-bottom: 1px solid var(--border);
            padding-bottom: 18px;
            margin-bottom: 26px;
        }

        .topbar h1 {
            font-size: 26px;
            font-weight: 600;
            margin: 0;
        }

        .topbar p {
            color: var(--muted);
            font-size: 15px;
            margin: 4px 0 0;
        }

        .form-card {
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 32px 36px;
        }

        .form-row {
            display: flex;
            gap: 18px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: var(--ink);
            font-size: 15px;
            margin-bottom: 7px;
        }

        .form-control {
            display: block;
            width: 100%;
            height: 36px;
            box-sizing: border-box;

            border: 1px solid var(--border);
            border-radius: 4px;

            padding: 7px 14px;
            font-size: 16px;

            background: #fff;
            color: var(--ink);

            box-shadow: none;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: none;
        }

        select.form-control {
            cursor: pointer;
        }

        textarea.form-control {
            height: auto;
            min-height: 90px;
            resize: vertical;
            padding: 10px 14px;
            line-height: 1.5;
        }

        .current-image-box {
            width: 100%;
            border: 1px solid var(--border);
            padding: 14px;
            text-align: center;
            margin-bottom: 16px;
        }

        .current-image-box img {
            display: block;
            width: 96px;
            height: 96px;
            margin: 0 auto;
            object-fit: cover;

            border: 1px solid var(--border);
            border-radius: 50%;
        }

        .current-image-box .img-label {
            display: block;
            font-size: 14px;
            color: var(--muted);
            margin-bottom: 10px;
        }

        .form-group input[type="file"] {
            display: block;
            width: 100%;
            height: 36px;
            box-sizing: border-box;

            border: 1px solid var(--border);
            border-radius: 4px;

            padding: 5px 14px;
            font-size: 15px;

            background: #fff;
            color: var(--ink);
        }

        .form-group input[type="file"]:focus {
            outline: none;
            border-color: var(--accent);
        }

        .hint {
            display: block;
            font-size: 13px;
            color: var(--muted);
            margin-top: 6px;
        }

        hr.divider {
            border: none;
            border-top: 1px solid var(--border);
            margin: 22px 0;
        }

        .btn {
            display: inline-block;

            border-radius: 4px;
            font-weight: 500;

            padding: 11px 24px;

            border: 1px solid transparent;
            font-size: 15px;

            text-decoration: none;
            cursor: pointer;
            line-height: 1.2;
        }

        .btn-success {
            background: var(--accent);
            color: #fff;
        }

        .btn-success:hover {
            background: var(--accent-dark);
            color: #fff;
        }

        .btn-default {
            background: #fff;
            color: var(--muted);
            border-color: var(--border);
        }

        .btn-default:hover {
            background: #f2f2f2;
            color: var(--ink);
            text-decoration: none;
        }

        .btn-group-actions {
            margin-top: 22px;
        }

    </style>

</head>


<body>

    <div class="page-wrap">

        <div class="topbar">

            <h1>Chỉnh sửa user</h1>

            <p>
                Cập nhật thông tin người dùng
            </p>

        </div>

        <div class="form-card">

            <c:url value="/admin/user/edit" var="editUrl" />

            <form
                role="form"
                action="${editUrl}"
                method="post"
                enctype="multipart/form-data">

                <input
                    type="hidden"
                    name="id"
                    value="${user.userId}">

                <div class="form-row">

                    <div class="form-group">

                        <label>
                            Họ và tên
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            name="fullName"
                            value="${user.fullName}"
                            required />

                    </div>

                    <div class="form-group">

                        <label>
                            Username
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            name="username"
                            value="${user.username}"
                            required />

                    </div>

                </div>

                <div class="form-row">

                    <div class="form-group">

                        <label>
                            Mật khẩu mới
                        </label>

                        <input
                            type="password"
                            class="form-control"
                            name="password"
                            placeholder="Để trống nếu không đổi" />

                        <span class="hint">Chỉ nhập nếu muốn đặt lại mật khẩu</span>

                    </div>

                    <div class="form-group">

                        <label>
                            Trạng thái
                        </label>

                        <select
                            class="form-control"
                            name="status">

                            <option value="1" ${user.status == 1 ? 'selected' : ''}>Hoạt động</option>
                            <option value="0" ${user.status == 0 ? 'selected' : ''}>Khóa</option>

                        </select>

                    </div>

                </div>

                <div class="form-row">

                    <div class="form-group">

                        <label>
                            Vai trò
                        </label>

                        <select
                            class="form-control"
                            name="role">

                            <option value="USER" ${user.role == 'ADMIN' ? '' : 'selected'}>Người dùng</option>
                            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Quản trị viên</option>

                        </select>

                    </div>

                </div>

                <div class="form-row">

                    <div class="form-group">

                        <label>
                            Email
                        </label>

                        <input
                            type="email"
                            class="form-control"
                            name="email"
                            value="${user.email}"
                            required />

                    </div>

                    <div class="form-group">

                        <label>
                            Số điện thoại
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            name="phone"
                            value="${user.phone}" />

                    </div>

                </div>

                <div class="form-group">

                    <label>
                        Địa chỉ
                    </label>

                    <textarea
                        class="form-control"
                        name="address"
                        rows="3">${user.address}</textarea>

                </div>

                <div class="form-group">

                    <label>
                        Ảnh đại diện
                    </label>

                    <div class="current-image-box">

                        <span class="img-label">
                            Ảnh hiện tại
                        </span>

                        <c:url
                            value="/image?fname=${user.avatar}"
                            var="imgUrl" />

                        <img
                            src="${imgUrl}"
                            alt="Ảnh hiện tại"
                            onerror="this.src='https://placehold.co/96x96?text=U'">

                    </div>

                    <label>
                        Chọn ảnh mới (nếu muốn thay đổi)
                    </label>

                    <input
                        type="file"
                        name="avatar"
                        class="form-control" />

                </div>

                <div class="btn-group-actions">

                    <button
                        type="submit"
                        class="btn btn-success">
                        Cập nhật
                    </button>

                    <a
                        href="<c:url value='/admin/user/list'/>"
                        class="btn btn-default">
                        Quay lại danh sách
                    </a>

                </div>

            </form>

        </div>

    </div>

</body>

</html>
