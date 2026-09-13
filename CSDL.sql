IF DB_ID('springbootdb') IS NULL
BEGIN
    CREATE DATABASE springbootdb;
END
GO

USE springbootdb;
GO

IF OBJECT_ID('dbo.categories', 'U') IS NOT NULL
    DROP TABLE dbo.categories;
GO

CREATE TABLE dbo.categories (
    category_id   INT IDENTITY(1,1) PRIMARY KEY,
    categoryname  NVARCHAR(255) NULL,
    images        NVARCHAR(255) NULL,
    status        INT NOT NULL DEFAULT 1
);
GO

IF OBJECT_ID('dbo.users', 'U') IS NOT NULL
    DROP TABLE dbo.users;
GO

CREATE TABLE dbo.users (
    user_id      INT IDENTITY(1,1) PRIMARY KEY,
    fullname     NVARCHAR(255) NULL,
    username     NVARCHAR(100) NULL,
    password     NVARCHAR(255) NULL,
    email        NVARCHAR(255) NULL,
    phone        NVARCHAR(20)  NULL,
    address      NVARCHAR(500) NULL,
    avatar       NVARCHAR(255) NULL,
    status       INT NOT NULL DEFAULT 1,
    role         NVARCHAR(20)  NOT NULL DEFAULT 'USER',
    created_at   DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

CREATE UNIQUE INDEX UX_users_username ON dbo.users(username);
GO

ALTER TABLE dbo.users
    ADD CONSTRAINT CK_users_role CHECK (role IN (N'ADMIN', N'USER'));
GO


INSERT INTO dbo.categories (categoryname, images, status) VALUES
(N'Điện thoại',      NULL, 1),
(N'Laptop',          NULL, 1),
(N'Máy tính bảng',   NULL, 1),
(N'Phụ kiện',        NULL, 1),
(N'Đồng hồ',         NULL, 1),
(N'Tai nghe',        NULL, 1),
(N'Loa',             NULL, 1),
(N'Thiết bị mạng',   NULL, 1),
(N'Gia dụng',        NULL, 1),
(N'Thời trang',      NULL, 0);
GO


INSERT INTO dbo.users (fullname, username, password, email, phone, address, avatar, status, role, created_at) VALUES
(N'Quản trị viên',   'admin',        '123456', 'admin@example.com',    '0900000000', N'Hà Nội',       NULL, 1, N'ADMIN', SYSDATETIME()),
(N'Nguyễn Văn A',    'nguyenvana',   '123456', 'a@example.com',        '0901111111', N'TP.HCM',       NULL, 1, N'USER',  SYSDATETIME()),
(N'Trần Thị B',      'tranthib',     '123456', 'b@example.com',        '0902222222', N'Đà Nẵng',      NULL, 0, N'USER',  SYSDATETIME()),
(N'Lê Văn C',        'levanc',       '123456', 'c@example.com',        '0903333333', N'Hải Phòng',    NULL, 1, N'USER',  SYSDATETIME()),
(N'Phạm Thị D',      'phamthid',     '123456', 'd@example.com',        '0904444444', N'Cần Thơ',      NULL, 1, N'USER',  SYSDATETIME()),
(N'Hoàng Văn E',     'hoangvane',    '123456', 'e@example.com',        '0905555555', N'Huế',          NULL, 1, N'USER',  SYSDATETIME()),
(N'Vũ Thị F',        'vuthif',       '123456', 'f@example.com',        '0906666666', N'Nha Trang',    NULL, 0, N'USER',  SYSDATETIME()),
(N'Đặng Văn G',      'dangvang',     '123456', 'g@example.com',        '0907777777', N'Quy Nhơn',     NULL, 1, N'USER',  SYSDATETIME()),
(N'Bùi Thị H',       'buithih',      '123456', 'h@example.com',        '0908888888', N'Vũng Tàu',     NULL, 1, N'USER',  SYSDATETIME()),
(N'Ngô Văn I',       'ngovani',      '123456', 'i@example.com',        '0909999999', N'Biên Hòa',     NULL, 1, N'USER',  SYSDATETIME()),
(N'Đỗ Thị K',        'dothik',       '123456', 'k@example.com',        '0910000000', N'Tây Ninh',     NULL, 0, N'USER',  SYSDATETIME()),
(N'Lý Văn L',        'lyvanl',       '123456', 'l@example.com',        '0911111111', N'Long An',      NULL, 1, N'USER',  SYSDATETIME());
GO
