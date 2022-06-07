USE [master]
GO
/****** Object:  Database [QuanLyNhaHang]    Script Date: 06/06/2022 11:45:11 CH ******/
CREATE DATABASE [QuanLyNhaHang]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyNhaHang', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyNhaHang.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyNhaHang_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyNhaHang_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyNhaHang] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyNhaHang].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyNhaHang] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyNhaHang] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyNhaHang] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyNhaHang] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyNhaHang] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyNhaHang] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyNhaHang] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyNhaHang] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyNhaHang] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QuanLyNhaHang] SET QUERY_STORE = OFF
GO
USE [QuanLyNhaHang]
GO
/****** Object:  UserDefinedFunction [dbo].[auto_MaHD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[auto_MaHD]()
RETURNS CHAR(8)
AS
BEGIN
   	DECLARE @ID CHAR(8)
   	SELECT @ID = count(MaHD) from HOADON
   	IF @ID = 0
          	SET @ID = '0'
   	ELSE
          	SELECT @ID = CASE
                  	WHEN @ID >= 0 and @ID < 9 THEN 'HD00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
                  	WHEN @ID >= 10 and @ID < 99 THEN 'HD0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
                  	WHEN @ID >= 100  THEN 'HD' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
          	END
   	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[auto_maKH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[auto_maKH]()
RETURNS CHAR(8)
AS
BEGIN
   	DECLARE @ID CHAR(8)
   	SELECT @ID = count(MaKH) from KHACHHANG
   	IF @ID = 0
          	SET @ID = '0'
   	ELSE
          	SELECT @ID = CASE
                  	WHEN @ID >= 0 and @ID < 9 THEN 'KH00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
                  	WHEN @ID >= 10 and @ID < 99 THEN 'KH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
                  	WHEN @ID >= 100  THEN 'KH' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
          	END
   	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MaNV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_MaNV]()
RETURNS CHAR(8)
AS
BEGIN
	DECLARE @ID CHAR(8)
	SELECT @ID = count(MaNV) from NHANVIEN
	IF @ID = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'NV00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 10 and @ID < 99 THEN 'NV0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 100  THEN 'NV' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_SoPYC]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_SoPYC]()
RETURNS CHAR(8)
AS
BEGIN
	DECLARE @ID CHAR(8)
	SELECT @ID = count(SoPYC) from PHIEUYEUCAU
	IF @ID = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'YC00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 10 and @ID < 99 THEN 'YC0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 100  THEN 'YC' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[DemKhongDen]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DemKhongDen](@ma char(10))
RETURNS int
AS 
BEGIN
	DECLARE @count int
	SELECT @count=count(PHIEUYEUCAU.maKH) FROM PHIEUYEUCAU,HOADON WHERE PHIEUYEUCAU.maKH=@ma AND PHIEUYEUCAU.soPYC=HOADON.soPYC group by PHIEUYEUCAU.maKH
	RETURN @count
END
GO
/****** Object:  UserDefinedFunction [dbo].[getInforCus]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[getInforCus](@shb char(8))
returns @bang table
(
	sopyc char(8),
	maKH char(8),
	tenKH nvarchar(26),
	soDienThoai char(11),
	diaChi nvarchar(100)
)
as
begin
	declare @soPYC char(8), @makh char(8), @tenkh nvarchar(26), @sodienthoai char(11), @diachi nvarchar(100)
	select @soPYC=PHIEUYEUCAU.soPYC,@makh=KHACHHANG.maKH,@tenkh=tenKH,@sodienthoai=soDienThoai,@diachi=diaChi
	from PHIEUYEUCAU,KHACHHANG, BAN
	where BAN.SoHieuBan=@shb and BAN.SoHieuBan = PHIEUYEUCAU.SoHieuBan
	and PHIEUYEUCAU.maKH=KHACHHANG.maKH and  LOAI = N'2'
	insert into @bang values(@soPYC, @makh, @tenkh, @sodienthoai, @diachi)
	return
end
GO
/****** Object:  UserDefinedFunction [dbo].[NV_sohoadon]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[NV_sohoadon](@ma char(8)) 
returns int
as
begin
	declare @count int
	select @count= bang1.sl from (select NHANVIEN.maNV, count(MaHD) as sl
		from NHANVIEN, HOADON
		where NHANVIEN.maNV = HOADON.maNV
		group by NHANVIEN.maNV) as bang1
		where bang1.maNV=@ma
	return @count
end
GO
/****** Object:  UserDefinedFunction [dbo].[NV_timkiem]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[NV_timkiem](@ma char(8))
returns @bang table 
(
	MaNV char(8),
	HoTen nvarchar(26),
	diaChi nvarchar(100),
	soDienThoai char(11)
)
as
begin
	declare @manv char(8), @hoten nvarchar(26), @diachi nvarchar(100), @soDienThoai char(11)
	select @manv=NHANVIEN.maNV, @hoten=NHANVIEN.hoTen, @diachi=NHANVIEN.diaChi, @soDienThoai=NHANVIEN.soDienThoai
	from NHANVIEN
	where NHANVIEN.maNV = @ma
	insert into @bang values(@manv, @hoten, @diachi, @soDienThoai)
	return
end
GO
/****** Object:  UserDefinedFunction [dbo].[SearchBill]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SearchBill] (@kh nvarchar(30))
RETURNS @BANGBill TABLE
(MaHD CHAR(8),
NgayThu date,
TongTien bigint, 
MaNV char(8),
SoPYC char(8),
MaKH char(8)
)AS
BEGIN
INSERT INTO @BANGBill
SELECT * from dbo.HOADON 
WHERE maHD LIKE CONCAT('%',@kh,'%') OR ngayThu LIKE CONCAT('%',@kh,'%')
OR tongTien LIKE CONCAT('%',@kh,'%') OR maNV LIKE CONCAT('%',@kh,'%')
OR soPYC LIKE CONCAT('%',@kh,'%')
RETURN
END

GO
/****** Object:  UserDefinedFunction [dbo].[SearchCus]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SearchCus] (@kh nvarchar(30))
RETURNS @BANGCus TABLE
(maKH CHAR(8),
TenKH nvarchar(26),
SoDienThoai char(11), 
DiaChi nvarchar(100)
)AS
BEGIN
INSERT INTO @BANGCus
SELECT * from dbo.KHACHHANG 
WHERE maKH LIKE CONCAT('%',@kh,'%') OR tenKH LIKE CONCAT('%',@kh,'%')
OR soDienThoai LIKE CONCAT('%',@kh,'%') OR diaChi LIKE CONCAT('%',@kh,'%')

RETURN
END

GO
/****** Object:  UserDefinedFunction [dbo].[SearchKM]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SearchKM] (@kh nvarchar(30))
RETURNS @BANGKM TABLE
(MaKM CHAR(8),
TenKM nvarchar(50),
Han date, 
MucGiam CHAR(8)
)AS
BEGIN
INSERT INTO @BANGKM
SELECT * from dbo.KHUYENMAI 
WHERE maKM LIKE CONCAT('%',@kh,'%') OR tenKM LIKE CONCAT('%',@kh,'%')
OR han LIKE CONCAT('%',@kh,'%') OR mucGiam LIKE CONCAT('%',@kh,'%')

RETURN
END

GO
/****** Object:  UserDefinedFunction [dbo].[SearchNV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SearchNV] (@kh nvarchar(30))
RETURNS @BANGNV TABLE
(maNV CHAR(8),
hoTen nvarchar(26),
diaChi nvarchar(100), 
soDienThoai CHAR(11),
chucVu nvarchar(26)
)AS
BEGIN
INSERT INTO @BANGNV
SELECT manv, hoten, DiaChi, SoDienThoai, ChucVu from dbo.NHANVIEN 
WHERE maNV LIKE CONCAT('%',@kh,'%') OR hoTen LIKE CONCAT('%',@kh,'%') 
OR diaChi LIKE CONCAT('%',@kh,'%') OR soDienThoai LIKE CONCAT('%',@kh,'%')  
OR chucVu LIKE CONCAT('%',@kh,'%') 
RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[SSdoanhthu]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SSdoanhthu](@ngay date)
returns @bangTK table(
ngayT date,
ngay date,
a bigint,
b bigint,
c decimal(18,2),
d bigint,
e bigint,
f decimal(18,2)
)
as 
begin
declare @ngay1 date
select @ngay1=DATEADD(month, -1, CAST(@ngay AS date))
declare @thang1 int,@thang2 int,@nam int
select @thang1=MONTH(@ngay1)
select @thang2=MONTH(@ngay)
select @nam=YEAR(@ngay)
declare @tien bigint,@tien1 bigint,@tien2 bigint,@soHD int

--select @soHD=count(maHD) from HOADON where MONTH(ngayThu)=@thang1 and YEAR(ngayThu)=@nam

select @tien1=sum(tongTien) from HOADON where MONTH(ngayThu)=@thang1 and YEAR(ngayThu)=@nam group by MONTH(ngayThu)
select @tien2=sum(tongTien) from HOADON where MONTH(ngayThu)=@thang2 and YEAR(ngayThu)=@nam group by MONTH(ngayThu)
select @tien=@tien2-@tien1

declare @tienN bigint,@tienN1 bigint,@tienN2 bigint,@soHDN int

--select @soHDN=count(soPN) from PHIEUNHAP where MONTH(ngayNhap)=@thang1 and YEAR(ngayNhap)=@nam

select @tienN1=sum(tongTien) from PHIEUNHAP where MONTH(ngayNhap)=@thang1 and YEAR(ngayNhap)=@nam group by MONTH(ngayNhap)
select @tienN2=sum(tongTien) from PHIEUNHAP where MONTH(ngayNhap)=@thang2 and YEAR(ngayNhap)=@nam group by MONTH(ngayNhap)
if @tienN1=NULL select @tienN1=0
if @tienN2=NULL select @tienN2=0
if @tien1=NULL select @tien1=0
if @tien2=NULL select @tien2=0
select @tienN=@tienN2-@tienN1
--print 'Nam '+CONVERT(char(5),@nam)
--print 'Thang '+CONVERT(char(3),@thang1)+'-->a='+CONVERT(char(10),@tien1)+'-->e='+CONVERT(char(10),@tienN1)
--print 'Thang '+CONVERT(char(3),@thang2)+'-->a='+CONVERT(char(10),@tien2)+'-->e='+CONVERT(char(10),@tienN2)
--print 'b=' +CONVERT(char(10),@tien)+'  d=' +CONVERT(char(10),@tienN)
--print 'c='+CONVERT(char(10),(@tien / @soHD))+'  f='+CONVERT(char(10),(@tieNn / @soHDN))
 
insert into @bangTK values(@ngay1,@ngay,@tien1,@tien,100*(CAST(@tien AS float) / CAST(@tien1 AS float)),@tienN1,@tienN,100*(CAST(@tienN AS float) / CAST(@tienN1 AS float)))
return 
end
GO
/****** Object:  UserDefinedFunction [dbo].[SSdoanhthuNam]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SSdoanhthuNam](@ngay date)
returns @bangTK table(
ngayT date,
ngay date,
a bigint,
b bigint,
c decimal(18,2),
d bigint,
e bigint,
f decimal(18,2)
)
as 
begin
declare @ngay1 date
select @ngay1=DATEADD(year, -1, CAST(@ngay AS date))
declare @tien bigint,@tien1 bigint,@tien2 bigint,@soHD int

--select @soHD=count(maHD) from HOADON where MONTH(ngayThu)=@thang1 and YEAR(ngayThu)=@nam
select @tien1=sum(tongTien) from HOADON where YEAR(ngayThu)=YEAR(@ngay1)
select @tien2=sum(tongTien) from HOADON where YEAR(ngayThu)=YEAR(@ngay)
select @tien=case when @tien2!=0 and @tien1!=0 then @tien2-@tien1 when @tien2=0 then @tien1 else @tien2 end
 

declare @tienN bigint,@tienN1 bigint,@tienN2 bigint,@soHDN int

--select @soHDN=count(soPN) from PHIEUNHAP where MONTH(ngayNhap)=@thang1 and YEAR(ngayNhap)=@nam
select @tienN1=sum(tongTien) from PHIEUNHAP where YEAR(ngayNhap)=YEAR(@ngay1)
select @tienN2=sum(tongTien) from PHIEUNHAP where YEAR(NgayNhap)=YEAR(@ngay)
select @tienN=case when @tienN2!=0 and @tienN1!=0 then @tienN2-@tienN1 when @tienN2=0 then @tienN1 else @tienN2 end
 
declare @c decimal
select @c=case when (@tien1!=0 and @tien2!=0) then (100*(CAST(@tien AS float) / CAST( @tien1 AS float))) when (@tien1=0 and @tien2=0) then 0 else 100 end

declare @e decimal
select @e=case when (@tienN1!=0 and @tienN2!=0) then (100*(CAST(@tienN AS float) / CAST( @tienN1 AS float))) when (@tienN1=0 and @tienN2=0) then 0 else 100 end
insert into @bangTK values(@ngay1,@ngay,@tien1,@tien,@c,@tienN1,@tienN,@e)

return 
end
GO
/****** Object:  UserDefinedFunction [dbo].[SSdoanhthuNgay]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SSdoanhthuNgay](@ngay date)
returns @bangTK table(
ngayT date,
ngay date,
a bigint,
b bigint,
c decimal(18,2),
d bigint,
e bigint,
f decimal(18,2)
)
as 
begin
declare @ngay1 date
select @ngay1=DATEADD(day, -1, CAST(@ngay AS date))
declare @tien bigint,@tien1 bigint,@tien2 bigint,@soHD int

--select @soHD=count(maHD) from HOADON where MONTH(ngayThu)=@thang1 and YEAR(ngayThu)=@nam
select @tien1=sum(tongTien) from HOADON where CONVERT(date,ngayThu)=@ngay1
select @tien2=sum(tongTien) from HOADON where CONVERT(date,ngayThu)=@ngay
select @tien=case when @tien2!=0 and @tien1!=0 then @tien2-@tien1 when @tien2=0 then @tien1 else @tien2 end

declare @tienN bigint,@tienN1 bigint,@tienN2 bigint,@soHDN int

--select @soHDN=count(soPN) from PHIEUNHAP where MONTH(ngayNhap)=@thang1 and YEAR(ngayNhap)=@nam

select @tienN1=sum(tongTien) from PHIEUNHAP where CONVERT(date,ngayNhap)=@ngay1
select @tienN2=sum(tongTien) from PHIEUNHAP where CONVERT(date,ngayNhap)=@ngay
select @tienN=case when (@tienN2!=0 and @tienN1!=0) then @tienN2-@tienN1 when @tienN2=0 then @tienN1 else @tienN2 end
 
declare @c decimal
select @c=case when (@tien1!=0 and @tien2!=0) then (100*(CAST(@tien AS float) / CAST( @tien1 AS float))) when (@tien1=0 and @tien2=0) then 0 else 100 end

declare @e decimal
select @e=case when (@tienN1!=0 and @tienN2!=0) then (100*(CAST(@tienN AS float) / CAST( @tienN1 AS float))) when (@tienN1=0 and @tienN2=0) then 0 else 100 end
insert into @bangTK values(@ngay1,@ngay,@tien1,@tien,@c,@tienN1,@tienN,@e)

return 
end
GO
/****** Object:  UserDefinedFunction [dbo].[TimKiemKH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[TimKiemKH]( @sdt varchar(10))
returns @bangKQ table
(
maKH char(10),
tenKH nvarchar(25)
)
as
begin
declare @ma varchar(10),@ten nvarchar(25)
select @ma=KHACHHANG.maKH,@ten=KHACHHANG.tenKH from KHACHHANG where soDienThoai=@sdt
   insert into @bangKQ values(@ma,@ten)
return
end
GO
/****** Object:  Table [dbo].[BAN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAN](
	[SoHieuBan] [char](8) NOT NULL,
	[ViTri] [char](8) NOT NULL,
	[SoGhe] [int] NOT NULL,
	[TinhTrang] [char](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SoHieuBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIETNHAP]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETNHAP](
	[SoPN] [char](8) NOT NULL,
	[MaNL] [char](8) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [bigint] NOT NULL,
 CONSTRAINT [PK_CHITIETNHAP] PRIMARY KEY CLUSTERED 
(
	[SoPN] ASC,
	[MaNL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIETPYC]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETPYC](
	[SoPYC] [char](8) NOT NULL,
	[MaMonAn] [char](8) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [bigint] NOT NULL,
 CONSTRAINT [PK_CHITIETPYC] PRIMARY KEY CLUSTERED 
(
	[SoPYC] ASC,
	[MaMonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHITIETXUAT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETXUAT](
	[MaNL] [char](8) NOT NULL,
	[SoPX] [char](8) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [bigint] NOT NULL,
 CONSTRAINT [PK_CHITIETXUAT] PRIMARY KEY CLUSTERED 
(
	[MaNL] ASC,
	[SoPX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOADON]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADON](
	[MaHD] [char](8) NOT NULL,
	[NgayThu] [date] NOT NULL,
	[TongTien] [bigint] NOT NULL,
	[MaNV] [char](8) NOT NULL,
	[MaKH] [char](8) NOT NULL,
	[SoPYC] [char](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHACHHANG](
	[MaKH] [char](8) NOT NULL,
	[TenKH] [nvarchar](26) NULL,
	[SoDienThoai] [char](11) NULL,
	[DiaChi] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHUYENMAI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHUYENMAI](
	[MaKM] [char](8) NOT NULL,
	[TenKM] [nvarchar](50) NULL,
	[Han] [date] NOT NULL,
	[MucGiam] [char](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAIMON]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAIMON](
	[MaLM] [char](8) NOT NULL,
	[TenLM] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MONAN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONAN](
	[MaMonAn] [char](8) NOT NULL,
	[TenMon] [nvarchar](50) NOT NULL,
	[DonGia] [bigint] NOT NULL,
	[DVT] [nvarchar](26) NOT NULL,
	[MaLM] [char](8) NOT NULL,
	[pathimage] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaMonAn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NGUYENLIEU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NGUYENLIEU](
	[MaNL] [char](8) NOT NULL,
	[SoLuong] [int] NULL,
	[TenNL] [nvarchar](100) NOT NULL,
	[DonVi] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK__NGUYENLI__2725D73C7998F475] PRIMARY KEY CLUSTERED 
(
	[MaNL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHACUNGCAP]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHACUNGCAP](
	[MaNCC] [char](8) NOT NULL,
	[SoDienThoai] [char](11) NOT NULL,
	[TongTien] [bigint] NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN](
	[MaNV] [char](8) NOT NULL,
	[HoTen] [nvarchar](26) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [char](8) NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[SoDienThoai] [char](11) NOT NULL,
	[ChucVu] [nvarchar](26) NOT NULL,
	[Luong] [bigint] NOT NULL,
	[matkhau] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUKM]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUKM](
	[MaKM] [char](8) NOT NULL,
	[SoPYC] [char](8) NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_PHIEUKM] PRIMARY KEY CLUSTERED 
(
	[MaKM] ASC,
	[SoPYC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUNHAP]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUNHAP](
	[SoPN] [char](8) NOT NULL,
	[NgayNhap] [date] NOT NULL,
	[TongTien] [bigint] NOT NULL,
	[MaNV] [char](8) NOT NULL,
	[MaNCC] [char](8) NOT NULL,
 CONSTRAINT [PK_PHIEUNHAP] PRIMARY KEY CLUSTERED 
(
	[SoPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUXUAT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUXUAT](
	[SoPX] [char](8) NOT NULL,
	[NgayXuat] [date] NOT NULL,
	[MaNV] [char](8) NOT NULL,
 CONSTRAINT [PK__PHIEUXUA__BC3C6A45C816B618] PRIMARY KEY CLUSTERED 
(
	[SoPX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHIEUYEUCAU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHIEUYEUCAU](
	[SoPYC] [char](8) NOT NULL,
	[NgayXuat] [date] NOT NULL,
	[NgayGioYC] [char](20) NOT NULL,
	[LOAI] [char](20) NOT NULL,
	[MaKH] [char](8) NOT NULL,
	[SoHieuBan] [char](8) NULL,
PRIMARY KEY CLUSTERED 
(
	[SoPYC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B1      ', N'D1      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B10     ', N'D2      ', 8, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B11     ', N'D2      ', 12, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B12     ', N'D2      ', 10, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B13     ', N'D3      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B2      ', N'D1      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B3      ', N'D1      ', 10, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B4      ', N'D2      ', 10, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B5      ', N'D2      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B6      ', N'D2      ', 6, N'BOOKED  ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B7      ', N'D3      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B8      ', N'D3      ', 6, N'BOOKED  ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B9      ', N'D1      ', 6, N'NONE    ')
GO
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0001  ', N'NL001   ', 17, 320000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0002  ', N'NL002   ', 20, 170000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0003  ', N'NL003   ', 5, 460000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0004  ', N'NL004   ', 15, 360000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0005  ', N'NL005   ', 14, 340000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0006  ', N'NL006   ', 30, 60000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0007  ', N'NL007   ', 50, 30000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0008  ', N'NL008   ', 10, 210000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0009  ', N'NL009   ', 50, 50000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0010  ', N'NL010   ', 25, 150000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0011  ', N'NL011   ', 10, 130000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0012  ', N'NL012   ', 18, 340000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0013  ', N'NL001   ', 20, 310000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0014  ', N'NL002   ', 26, 190000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0015  ', N'NL003   ', 7, 480000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0016  ', N'NL004   ', 18, 390000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0017  ', N'NL001   ', 27, 345000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0017  ', N'NL005   ', 20, 340000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0018  ', N'NL002   ', 33, 180000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0018  ', N'NL006   ', 24, 57000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0019  ', N'NL007   ', 67, 29000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0020  ', N'NL008   ', 24, 250000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0021  ', N'NL009   ', 60, 45000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0022  ', N'NL010   ', 23, 150000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0023  ', N'NL011   ', 15, 140000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0024  ', N'NL012   ', 23, 360000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0025  ', N'NL003   ', 10, 475000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0026  ', N'NL004   ', 23, 345000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0027  ', N'NL005   ', 32, 333000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0028  ', N'NL006   ', 50, 55000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0029  ', N'NL007   ', 70, 26000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0030  ', N'NL008   ', 30, 270000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0031  ', N'NL009   ', 67, 43000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0032  ', N'NL010   ', 40, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0033  ', N'NL011   ', 53, 130000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0034  ', N'NL012   ', 12, 390000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0035  ', N'NL001   ', 21, 350000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0036  ', N'NL002   ', 24, 170000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0047  ', N'NL005   ', 35, 333000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0048  ', N'NL006   ', 56, 55000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0049  ', N'NL007   ', 72, 25000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0050  ', N'NL008   ', 25, 270000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0051  ', N'NL009   ', 54, 45000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0052  ', N'NL010   ', 35, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0053  ', N'NL011   ', 24, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0054  ', N'NL012   ', 23, 390000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0055  ', N'NL001   ', 23, 340000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0056  ', N'NL002   ', 22, 170000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0057  ', N'NL003   ', 11, 455000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0058  ', N'NL004   ', 24, 353000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0059  ', N'NL007   ', 73, 25000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0060  ', N'NL008   ', 23, 280000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0061  ', N'NL009   ', 55, 45000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0062  ', N'NL010   ', 33, 180000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0063  ', N'NL011   ', 24, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0064  ', N'NL012   ', 23, 350000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0065  ', N'NL001   ', 13, 350000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0066  ', N'NL002   ', 21, 170000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0067  ', N'NL003   ', 15, 465000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0068  ', N'NL004   ', 24, 343000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0069  ', N'NL005   ', 34, 333000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0070  ', N'NL006   ', 46, 56000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0071  ', N'NL009   ', 55, 43000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0072  ', N'NL010   ', 32, 180000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0073  ', N'NL011   ', 24, 170000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0074  ', N'NL012   ', 25, 350000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0075  ', N'NL001   ', 14, 350000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0076  ', N'NL002   ', 21, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0077  ', N'NL003   ', 16, 465000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0078  ', N'NL004   ', 24, 353000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0079  ', N'NL005   ', 34, 323000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0080  ', N'NL006   ', 43, 56000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0081  ', N'NL007   ', 73, 25000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0082  ', N'NL008   ', 26, 260000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0083  ', N'NL011   ', 24, 140000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0084  ', N'NL012   ', 25, 330000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0085  ', N'NL001   ', 35, 350000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0086  ', N'NL002   ', 46, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0087  ', N'NL003   ', 15, 485000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0088  ', N'NL004   ', 24, 343000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0089  ', N'NL005   ', 34, 323000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0090  ', N'NL006   ', 43, 56000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0091  ', N'NL007   ', 53, 23000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0092  ', N'NL008   ', 16, 270000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0093  ', N'NL009   ', 55, 47000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0094  ', N'NL010   ', 32, 140000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0095  ', N'NL001   ', 23, 350000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0096  ', N'NL002   ', 35, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0097  ', N'NL003   ', 17, 485000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0098  ', N'NL004   ', 35, 343000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0099  ', N'NL005   ', 34, 373000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'pn01    ', N'NL001   ', 1, 200000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0100  ', N'NL006   ', 43, 56000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0101  ', N'NL007   ', 52, 23000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0102  ', N'NL008   ', 27, 240000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0103  ', N'NL009   ', 75, 47000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0104  ', N'NL010   ', 32, 150000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0105  ', N'NL011   ', 24, 170000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0106  ', N'NL012   ', 23, 330000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0107  ', N'NL003   ', 15, 465000)
GO
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0108  ', N'NL004   ', 33, 363000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0109  ', N'NL005   ', 34, 373000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0110  ', N'NL006   ', 45, 53000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0111  ', N'NL007   ', 56, 23000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0112  ', N'NL008   ', 23, 257000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0113  ', N'NL009   ', 64, 48000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0114  ', N'NL010   ', 33, 130000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0115  ', N'NL011   ', 24, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0116  ', N'NL012   ', 23, 370000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0117  ', N'NL001   ', 27, 345000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0118  ', N'NL002   ', 33, 180000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0119  ', N'NL003   ', 14, 465000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0120  ', N'NL004   ', 33, 363000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0121  ', N'NL007   ', 57, 23000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0122  ', N'NL008   ', 22, 257000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0123  ', N'NL009   ', 65, 48000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0124  ', N'NL010   ', 32, 130000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0125  ', N'NL011   ', 27, 160000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0126  ', N'NL012   ', 22, 370000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0127  ', N'NL005   ', 32, 373000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0128  ', N'NL002   ', 35, 180000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0129  ', N'NL003   ', 14, 465000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0130  ', N'NL006   ', 46, 53000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0131  ', N'NL001   ', 1, 200000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0131  ', N'NL002   ', 1, 100000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0132  ', N'NL001   ', 2, 200000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0133  ', N'NL004   ', 10, 1000000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0133  ', N'NL005   ', 1, 500000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0134  ', N'NL003   ', 10, 2000000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0135  ', N'NL009   ', 20, 20000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0136  ', N'NL011   ', 50, 40000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0137  ', N'NL007   ', 20, 20000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0138  ', N'NL008   ', 20, 30000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0139  ', N'NL010   ', 10, 50000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0140  ', N'NL006   ', 30, 20000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0141  ', N'NL013   ', 10, 30000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0141  ', N'NL014   ', 10, 30000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0142  ', N'NL012   ', 9, 150000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN1000  ', N'NL002   ', 1, 100000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN10001 ', N'NL001   ', 1, 200000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN10001 ', N'NL003   ', 1, 400000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN10001 ', N'NL004   ', 1, 400000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN10001 ', N'NL008   ', 2, 100000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN109   ', N'NL001   ', 1, 200000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN141   ', N'NL012   ', 10, 100000)
GO
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'1       ', N'BR001   ', 0, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'2       ', N'BR001   ', 0, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'3       ', N'BR001   ', 1, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'827723  ', N'BR001   ', 1, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'HD001   ', N'BR001   ', 8, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'jhdjhj  ', N'BR003   ', 1, 245000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC001  ', N'BR002   ', 7, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC0019 ', N'BR002   ', 3, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC002  ', N'NU002   ', 8, 10000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC002  ', N'PZ002   ', 2, 455000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC0111 ', N'BR001   ', 5, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC014  ', N'BR003   ', 4, 245000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC0809 ', N'BR002   ', 2, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC0898 ', N'BR002   ', 2, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC0899 ', N'BR002   ', 2, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC100  ', N'BR003   ', 1, 245000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC101  ', N'BR003   ', 1, 245000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC103  ', N'BR002   ', 1, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC104  ', N'BR002   ', 1, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC107  ', N'BR001   ', 1, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC108  ', N'BR003   ', 1, 245000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC110  ', N'BR001   ', 5, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC111  ', N'BR001   ', 1, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC112  ', N'PZ01    ', 1, 190000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC113  ', N'PZ01    ', 1, 190000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC114  ', N'BR002   ', 1, 259000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC189  ', N'BR001   ', 2, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC7777 ', N'NU001   ', 5, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC8888 ', N'PZ001   ', 2, 365000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'PYC9999 ', N'BR001   ', 4, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'shdjs   ', N'BR001   ', 1, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'shgdhs  ', N'BR001   ', 1, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'usdyuys ', N'BR001   ', 1, 250000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0001  ', N'BR001   ', 2, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0001  ', N'BR002   ', 3, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0002  ', N'NU002   ', 1, 10000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0003  ', N'BR002   ', 3, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0003  ', N'PZ003   ', 3, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0004  ', N'PZ001   ', 2, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0005  ', N'BR002   ', 4, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0006  ', N'BR001   ', 3, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0007  ', N'PZ001   ', 2, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0008  ', N'NU004   ', 9, 35000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0008  ', N'PZ002   ', 1, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0009  ', N'PZ002   ', 4, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0010  ', N'BR003   ', 3, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0011  ', N'BR003   ', 6, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0012  ', N'BR002   ', 5, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0013  ', N'BR001   ', 7, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0014  ', N'BR003   ', 4, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0015  ', N'PZ002   ', 5, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0016  ', N'BR002   ', 3, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0017  ', N'PZ003   ', 4, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0018  ', N'BR001   ', 5, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0019  ', N'BR003   ', 9, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0020  ', N'PZ003   ', 5, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0021  ', N'BR002   ', 11, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0022  ', N'PZ003   ', 5, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0023  ', N'PZ002   ', 4, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0024  ', N'BR001   ', 5, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0025  ', N'BR002   ', 3, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0026  ', N'PZ002   ', 4, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0027  ', N'BR003   ', 5, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0028  ', N'PZ002   ', 6, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0029  ', N'PZ001   ', 5, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0030  ', N'BR001   ', 4, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0031  ', N'PZ002   ', 5, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0032  ', N'NU003   ', 5, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0032  ', N'PZ003   ', 5, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0033  ', N'BR003   ', 8, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0034  ', N'BR002   ', 6, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0035  ', N'PZ002   ', 9, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0036  ', N'BR002   ', 4, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0037  ', N'BR001   ', 5, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0038  ', N'PZ002   ', 7, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0039  ', N'BR001   ', 6, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0040  ', N'PZ003   ', 6, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0041  ', N'BR002   ', 9, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0042  ', N'PZ003   ', 5, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0043  ', N'BR001   ', 6, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0044  ', N'PZ001   ', 4, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0045  ', N'BR001   ', 5, 50000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0046  ', N'BR003   ', 7, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0047  ', N'PZ001   ', 6, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0048  ', N'PZ002   ', 7, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0049  ', N'NU001   ', 8, 30000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0050  ', N'BR002   ', 5, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0051  ', N'PZ003   ', 5, 60000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0052  ', N'BR003   ', 12, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0053  ', N'PZ002   ', 3, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0054  ', N'NU003   ', 8, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0055  ', N'BR003   ', 5, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0056  ', N'BR002   ', 6, 59000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0057  ', N'PZ001   ', 10, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC0058  ', N'PZ003   ', 6, 60000)
GO
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0001  ', 13, 420000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0023  ', 17, 390000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0033  ', 21, 370000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0043  ', 27, 364000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0053  ', 25, 346000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0063  ', 26, 386000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0073  ', 23, 383000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0095  ', 28, 387000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0105  ', 31, 387000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0107  ', 1, 0)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL001   ', N'PX0108  ', 4, 0)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0002  ', 15, 200000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0024  ', 18, 210000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0034  ', 17, 240000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0044  ', 34, 267000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0054  ', 27, 246000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0064  ', 28, 285000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0074  ', 25, 285000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0096  ', 24, 285000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL002   ', N'PX0106  ', 27, 285000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0003  ', 4, 450000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0013  ', 6, 465000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0035  ', 8, 475000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0045  ', 10, 475000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0055  ', 13, 485000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0065  ', 16, 445000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0075  ', 17, 448000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL003   ', N'PX0085  ', 13, 448000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0004  ', 12, 360000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0014  ', 12, 390000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0036  ', 15, 390000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0046  ', 25, 378000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0056  ', 25, 386000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0066  ', 24, 357000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0076  ', 23, 354000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL004   ', N'PX0086  ', 26, 354000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0005  ', 9, 180000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0015  ', 13, 190000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0025  ', 16, 210000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0047  ', 18, 257000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0057  ', 23, 277000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0067  ', 25, 257000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0077  ', 26, 259000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0087  ', 28, 256000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL005   ', N'PX0097  ', 27, 254000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0006  ', 12, 60000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0016  ', 15, 60000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0026  ', 18, 65000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0048  ', 23, 65000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0058  ', 34, 64000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0068  ', 38, 64300)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0078  ', 38, 64600)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0088  ', 31, 64400)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL006   ', N'PX0098  ', 34, 64700)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0007  ', 14, 40000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0017  ', 19, 46000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0027  ', 27, 48000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0037  ', 27, 44700)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0059  ', 37, 47700)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0069  ', 34, 44600)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0079  ', 36, 44400)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0089  ', 38, 44200)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL007   ', N'PX0099  ', 38, 44300)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0008  ', 12, 180000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0018  ', 12, 180000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0028  ', 21, 140000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0038  ', 23, 140000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0060  ', 25, 170000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0070  ', 27, 175000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0080  ', 24, 177000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0090  ', 25, 178000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0100  ', 24, 175000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0009  ', 15, 70000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0019  ', 15, 70000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0029  ', 28, 74000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0039  ', 34, 74000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0049  ', 45, 77000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0071  ', 47, 77500)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0081  ', 48, 77800)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0091  ', 44, 77400)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL009   ', N'PX0101  ', 48, 77800)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0010  ', 18, 250000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0020  ', 17, 250000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0030  ', 32, 240000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0040  ', 36, 256000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0050  ', 47, 275000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0072  ', 43, 256000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0082  ', 44, 253000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0092  ', 43, 258000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL010   ', N'PX0102  ', 44, 254000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0011  ', 8, 190000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0021  ', 9, 195000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0031  ', 13, 175000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0041  ', 15, 176000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0051  ', 21, 164000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0061  ', 26, 157000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0083  ', 22, 158000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0093  ', 28, 154000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL011   ', N'PX0103  ', 22, 157000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0012  ', 10, 350000)
GO
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0022  ', 12, 350000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0032  ', 15, 340000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0042  ', 16, 370000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0052  ', 23, 376000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0062  ', 22, 375000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0084  ', 26, 377000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0094  ', 23, 373000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0104  ', 27, 374000)
GO
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'fggfg   ', CAST(N'2022-05-10' AS Date), 235000, N'NV02    ', N'KH1234  ', N'shgdhs  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0001  ', CAST(N'2022-02-06' AS Date), 1000000, N'NV04    ', N'KH0001  ', N'YC0001  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0002  ', CAST(N'2022-02-06' AS Date), 1234000, N'NV04    ', N'KH0001  ', N'YC0002  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0003  ', CAST(N'2022-02-06' AS Date), 123400, N'NV08    ', N'KH0002  ', N'YC0003  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0004  ', CAST(N'2022-02-06' AS Date), 1234000, N'NV09    ', N'KH0003  ', N'YC0004  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0005  ', CAST(N'2022-02-07' AS Date), 1234000, N'NV12    ', N'KH0004  ', N'YC0005  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0006  ', CAST(N'2022-02-10' AS Date), 1234000, N'NV13    ', N'KH0005  ', N'YC0006  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0007  ', CAST(N'2022-02-13' AS Date), 1234000, N'NV03    ', N'KH0005  ', N'YC0007  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0008  ', CAST(N'2022-02-18' AS Date), 1234000, N'NV04    ', N'KH0006  ', N'YC0008  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0009  ', CAST(N'2022-02-19' AS Date), 1234000, N'NV08    ', N'KH0007  ', N'YC0009  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD001   ', CAST(N'2022-05-18' AS Date), 1840000, N'NV01    ', N'KH1234  ', N'HD001   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0010  ', CAST(N'2022-02-19' AS Date), 1234000, N'NV09    ', N'KH0008  ', N'YC0010  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0011  ', CAST(N'2022-02-20' AS Date), 1234000, N'NV12    ', N'KH0009  ', N'YC0011  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0012  ', CAST(N'2022-02-21' AS Date), 1234000, N'NV13    ', N'KH0010  ', N'YC0012  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0013  ', CAST(N'2022-02-25' AS Date), 1234000, N'NV03    ', N'KH0011  ', N'YC0013  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0014  ', CAST(N'2022-02-27' AS Date), 1234000, N'NV04    ', N'KH0012  ', N'YC0014  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0015  ', CAST(N'2022-02-28' AS Date), 1234000, N'NV08    ', N'KH0002  ', N'YC0015  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0016  ', CAST(N'2022-02-28' AS Date), 1234000, N'NV09    ', N'KH0013  ', N'YC0016  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0017  ', CAST(N'2022-03-01' AS Date), 1234000, N'NV12    ', N'KH0014  ', N'YC0017  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0018  ', CAST(N'2022-03-02' AS Date), 1234000, N'NV13    ', N'KH0015  ', N'YC0018  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0019  ', CAST(N'2022-03-03' AS Date), 1234000, N'NV03    ', N'KH0010  ', N'YC0019  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD002   ', CAST(N'2022-05-17' AS Date), 1813000, N'NV02    ', N'KH1234  ', N'PYC001  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0020  ', CAST(N'2022-03-04' AS Date), 1234000, N'NV04    ', N'KH0012  ', N'YC0020  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0021  ', CAST(N'2022-03-04' AS Date), 1234000, N'NV03    ', N'KH0018  ', N'YC0021  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0022  ', CAST(N'2022-03-05' AS Date), 1234000, N'NV04    ', N'KH0004  ', N'YC0022  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0023  ', CAST(N'2022-03-06' AS Date), 1234000, N'NV08    ', N'KH0008  ', N'YC0023  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0024  ', CAST(N'2022-03-11' AS Date), 1234000, N'NV09    ', N'KH0020  ', N'YC0024  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0025  ', CAST(N'2022-03-15' AS Date), 1234000, N'NV12    ', N'KH0021  ', N'YC0025  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0026  ', CAST(N'2022-03-15' AS Date), 1234000, N'NV13    ', N'KH0022  ', N'YC0026  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0027  ', CAST(N'2022-03-16' AS Date), 1234000, N'NV03    ', N'KH0023  ', N'YC0027  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0028  ', CAST(N'2022-03-19' AS Date), 1234000, N'NV04    ', N'KH0024  ', N'YC0028  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0029  ', CAST(N'2022-03-19' AS Date), 1234000, N'NV08    ', N'KH0025  ', N'YC0029  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0030  ', CAST(N'2022-03-20' AS Date), 1234000, N'NV09    ', N'KH0026  ', N'YC0030  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0031  ', CAST(N'2022-03-28' AS Date), 1234000, N'NV12    ', N'KH0027  ', N'YC0031  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0032  ', CAST(N'2022-03-29' AS Date), 1234000, N'NV13    ', N'KH0028  ', N'YC0032  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0033  ', CAST(N'2022-03-30' AS Date), 1234000, N'NV03    ', N'KH0016  ', N'YC0033  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0034  ', CAST(N'2022-03-30' AS Date), 1234000, N'NV04    ', N'KH0017  ', N'YC0034  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0035  ', CAST(N'2022-04-02' AS Date), 1234000, N'NV08    ', N'KH0029  ', N'YC0035  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0036  ', CAST(N'2022-04-05' AS Date), 1234000, N'NV09    ', N'KH0030  ', N'YC0036  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0037  ', CAST(N'2022-04-06' AS Date), 1234000, N'NV12    ', N'KH0031  ', N'YC0037  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0038  ', CAST(N'2022-04-07' AS Date), 1234000, N'NV13    ', N'KH0004  ', N'YC0038  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0039  ', CAST(N'2022-04-09' AS Date), 1234000, N'NV03    ', N'KH0032  ', N'YC0039  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0040  ', CAST(N'2022-04-09' AS Date), 1234000, N'NV04    ', N'KH0033  ', N'YC0040  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0041  ', CAST(N'2022-04-09' AS Date), 1234000, N'NV03    ', N'KH0034  ', N'YC0041  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0042  ', CAST(N'2022-04-10' AS Date), 1234000, N'NV04    ', N'KH0017  ', N'YC0042  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0043  ', CAST(N'2022-04-12' AS Date), 1234000, N'NV08    ', N'KH0035  ', N'YC0043  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0044  ', CAST(N'2022-04-13' AS Date), 1234000, N'NV09    ', N'KH0036  ', N'YC0044  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0045  ', CAST(N'2022-04-14' AS Date), 1234000, N'NV12    ', N'KH0037  ', N'YC0045  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0046  ', CAST(N'2022-04-15' AS Date), 1234000, N'NV13    ', N'KH0038  ', N'YC0046  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0047  ', CAST(N'2022-04-16' AS Date), 1234000, N'NV03    ', N'KH0039  ', N'YC0047  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0048  ', CAST(N'2022-04-17' AS Date), 1234000, N'NV04    ', N'KH0009  ', N'YC0048  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0049  ', CAST(N'2022-04-18' AS Date), 1234000, N'NV08    ', N'KH0040  ', N'YC0049  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0050  ', CAST(N'2022-04-21' AS Date), 1234000, N'NV09    ', N'KH0041  ', N'YC0050  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0051  ', CAST(N'2022-04-22' AS Date), 1234000, N'NV12    ', N'KH0042  ', N'YC0051  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0052  ', CAST(N'2022-04-23' AS Date), 1234000, N'NV13    ', N'KH0043  ', N'YC0052  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0053  ', CAST(N'2022-04-25' AS Date), 1234000, N'NV03    ', N'KH0044  ', N'YC0053  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0054  ', CAST(N'2022-04-26' AS Date), 1234000, N'NV04    ', N'KH0045  ', N'YC0054  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0055  ', CAST(N'2022-04-28' AS Date), 1234000, N'NV08    ', N'KH0046  ', N'YC0055  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0056  ', CAST(N'2022-04-29' AS Date), 1234000, N'NV09    ', N'KH0047  ', N'YC0056  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0057  ', CAST(N'2022-04-29' AS Date), 1234000, N'NV12    ', N'KH0048  ', N'YC0057  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0058  ', CAST(N'2022-04-25' AS Date), 134000, N'NV13    ', N'KH0049  ', N'YC0058  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0059  ', CAST(N'2022-04-19' AS Date), 1340000, N'NV12    ', N'KH0050  ', N'YC0059  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0060  ', CAST(N'2022-04-25' AS Date), 1300000, N'NV12    ', N'KH0040  ', N'YC0059  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD01    ', CAST(N'2022-05-13' AS Date), 777000, N'NV01    ', N'KH1234  ', N'PYC0019 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0111  ', CAST(N'2022-05-17' AS Date), 1062500, N'NV01    ', N'KH1234  ', N'PYC0111 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD02    ', CAST(N'2022-05-13' AS Date), 100000, N'NV03    ', N'KH1234  ', N'PYC7777 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD0222  ', CAST(N'2022-05-14' AS Date), 901600, N'NV03    ', N'KH1234  ', N'PYC014  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD03    ', CAST(N'2022-05-10' AS Date), 1000000, N'NV01    ', N'KH1234  ', N'PYC9999 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD04    ', CAST(N'2022-05-11' AS Date), 518000, N'NV01    ', N'KH1234  ', N'PYC0809 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD05    ', CAST(N'2022-05-15' AS Date), 518000, N'NV01    ', N'KH1234  ', N'PYC0898 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD06    ', CAST(N'2022-05-16' AS Date), 518000, N'NV01    ', N'KH1234  ', N'PYC0899 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD100   ', CAST(N'2022-05-25' AS Date), 237650, N'NV01    ', N'KH1234  ', N'PYC100  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD101   ', CAST(N'2022-05-25' AS Date), 237650, N'NV01    ', N'KH1234  ', N'PYC101  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD105   ', CAST(N'2022-05-25' AS Date), 238280, N'NV01    ', N'KH1234  ', N'PYC104  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD108   ', CAST(N'2022-05-28' AS Date), 235000, N'NV01    ', N'KH1234  ', N'PYC107  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD110   ', CAST(N'2022-05-28' AS Date), 1250000, N'NV02    ', N'KH1234  ', N'PYC110  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD111   ', CAST(N'2022-05-30' AS Date), 235000, N'NV02    ', N'KH1234  ', N'PYC111  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD112   ', CAST(N'2022-05-24' AS Date), 190000, N'NV02    ', N'KH1234  ', N'PYC112  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD113   ', CAST(N'2022-05-31' AS Date), 178600, N'NV01    ', N'KH1234  ', N'PYC113  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD873867', CAST(N'2022-05-17' AS Date), 425000, N'NV03    ', N'KH1234  ', N'PYC189  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD999   ', CAST(N'2022-05-13' AS Date), 671600, N'NV02    ', N'KH1234  ', N'PYC8888 ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'hdfjhdf ', CAST(N'2022-05-10' AS Date), 507600, N'NV01    ', N'KH0043  ', N'YC0052  ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'hdfjhjdf', CAST(N'2022-05-10' AS Date), 211500, N'NV01    ', N'KH0046  ', N'YC0055  ')
GO
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0001  ', N'Nguyễn Ngọc Anh', N'0345551232 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0002  ', N'Trần Văn Nam', N'0949145902 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0003  ', N'Trương Thanh Hà', N'0293847713 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0004  ', N'Hoàng Thành Nam', N'0949876234 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0005  ', N'Trần Văn Quyết', N'0898534762 ', N'Hoàng Mai, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0006  ', N'Đỗ Hồng Ngọc', N'0989347269 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0007  ', N'Trương Thị La', N'0983674326 ', N'Pleiku, Gia Lai')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0008  ', N'Trần Văn Minh', N'0898592762 ', N'Hoàng Mai, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0009  ', N'Trương Thảo Nhi', N'0980468209 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0010  ', N'Hoàng Mỹ Linh', N'0987234678 ', N'Hai Bà Trưng, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0011  ', N'Đỗ Hoàng Hải', N'0347861290 ', N'Hòa An, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0012  ', N'Trần Ngọc Anh', N'0298675238 ', N'Phủ Lý, Hà Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0013  ', N'Đỗ Phan Lâm', N'0983762847 ', N'Đức Cơ, Gia Lai')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0014  ', N'Nguyễn Thảo Ngân', N'0983678935 ', N'Thạch An, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0015  ', N'Nguyễn Thanh Phong ', N'0967482657 ', N'Thanh Ba, Phú Thọ')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0016  ', N'Trịnh Thúy Quỳnh', N'0347892971 ', N'Nam Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0017  ', N'Đậu Thị Lan', N'0987654363 ', N'Thanh Xuân, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0018  ', N'Hồ Thị Dung', N'0983746252 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0019  ', N'Chu Thị Huyền', N'0936251725 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0020  ', N'Đào Hồng Vy', N'0897863948 ', N'Ba Vì, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0021  ', N'An Thanh Tú', N'0983737383 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0022  ', N'Nguyễn Tùng Lâm', N'0944478976 ', N'Lâm Thao, Phú Thọ')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0023  ', N'Trần Duy Mạnh', N'0388978465 ', N'Ba Đình, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0024  ', N'Đỗ Phan Long', N'0898776543 ', N'Hoàng Mai, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0025  ', N'Phạm Đình Khương Duy', N'0354689726 ', N'Đô Lương, Nghệ An')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0026  ', N'Hoàng Đình Huy', N'0984763523 ', N'Thanh Sơn, Phú Thọ')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0027  ', N'Trương Anh Duy', N'0987363524 ', N'Kim Bảng, Hà Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0028  ', N'Hoàng Văn Thao', N'0983535678 ', N'Lục Ngạn, Bắc Giang')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0029  ', N'Nông Thị Trang', N'0367489065 ', N'Bảo Lạc, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0030  ', N'Trần Thị Tới', N'0987653546 ', N'Tiên Lữ, Hưng Yên')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0031  ', N'Hồ Nguyễn Ngọc', N'0463738292 ', N'Thạch An, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0032  ', N'Trần Văn Quân', N'0367826265 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0033  ', N'Phan Thanh Lam', N'0786869535 ', N'Đống Đa, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0034  ', N'Đinh Thị Mai', N'0989046475 ', N'Hai Bà Trưng, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0035  ', N'Lê Thị Linh Chi', N'0987467584 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0036  ', N'Nguyễn Ngọc Hoài', N'0983736283 ', N'Nam Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0037  ', N'Hoàng Văn Biên', N'0467352936 ', N'Hoàn Kiếm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0038  ', N'Lê Phúc Hưng', N'0987936352 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0039  ', N'Hoàng Lin Phương', N'0983636475 ', N'Đống Đa, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0040  ', N'Trịnh Văn Tú', N'0987476758 ', N'Ba Đình, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0041  ', N'Mai Ngọc Sơn', N'0238746351 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0042  ', N'Bế Quốc Khánh', N'0983647352 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0043  ', N'Đinh Xuân Hải', N'0473826563 ', N'Ba Vì, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0044  ', N'Hoàng Xuân Nam', N'0987463821 ', N'Việt Yên, Bắc Giang')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0045  ', N'Đỗ Lê Huy', N'0347879765 ', N'Thanh Xuân, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0046  ', N'Đào Việt Hà', N'0989373625 ', N'Hai Bà Trưng, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0047  ', N'Dương Huy Hoàng', N'0893838472 ', N'Hà Đông, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0048  ', N'Lưu Đình Kiệt', N'0345678293 ', N'Hoàn Kiếm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0049  ', N'Phan Văn Đức', N'0938372648 ', N'Ba Đình, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH0050  ', N'Bùi Duy Hoàng', N'0364758391 ', N'Hòa Lạc, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH1234  ', NULL, NULL, NULL)
GO
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0105  ', N'Quốc tế lao động', CAST(N'2022-05-02' AS Date), N'7       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0106  ', N'Quốc tế thiếu nhi', CAST(N'2022-06-02' AS Date), N'6       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0209  ', N'Quốc khánh', CAST(N'2022-09-03' AS Date), N'15      ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0302  ', N'Thành lập Đảng', CAST(N'2022-06-04' AS Date), N'8       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM1003  ', N'Giỗ tổ', CAST(N'2022-06-11' AS Date), N'7       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM123   ', N'KMHM', CAST(N'2022-05-25' AS Date), N'3       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM1402  ', N'Lễ tình nhân', CAST(N'2022-06-15' AS Date), N'5       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM2022  ', N'Tết', CAST(N'2022-07-06' AS Date), N'9       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM2511  ', N'Black Friday', CAST(N'2022-11-25' AS Date), N'9       ')
GO
INSERT [dbo].[LOAIMON] ([MaLM], [TenLM]) VALUES (N'BR      ', N'Burger')
INSERT [dbo].[LOAIMON] ([MaLM], [TenLM]) VALUES (N'NU      ', N'Nuoc')
INSERT [dbo].[LOAIMON] ([MaLM], [TenLM]) VALUES (N'PZ      ', N'Pizza')
GO
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'BR001   ', N'Burger Bò', 250000, N'VND', N'BR      ', N'D:\QLNhaHang\Food\food\beef-burger.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'BR002   ', N'Burger Cá hồi', 259000, N'VND', N'BR      ', N'D:\QLNhaHang\Food\food\burger-ca-hoi.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'BR003   ', N'Burger Thịt viên', 245000, N'VND', N'BR      ', N'D:\QLNhaHang\Food\food\burger-ga.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU001   ', N'Pepsi', 20000, N'VND', N'NU      ', N'D:\QLNhaHang\Food\food\pepsi.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU002   ', N'Nước suối', 10000, N'VND', N'NU      ', N'D:\QLNhaHang\Food\food\dasani.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU003   ', N'Trà đen', 20000, N'VND', N'NU      ', N'D:\QLNhaHang\Food\food\cheden.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU004   ', N'Nước cam', 35000, N'VND', N'NU      ', N'D:\QLNhaHang\Food\food\cam.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'PZ001   ', N'Pizza Tôm', 365000, N'VND', N'PZ      ', N'D:\QLNhaHang\Food\food\pizza tom.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'PZ002   ', N'Pizza Rau củ', 455000, N'VND', N'PZ      ', N'D:\QLNhaHang\Food\food\banh-pizza-chay-600x375.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'PZ003   ', N'Pizza Phô mai', 260000, N'VND', N'PZ      ', N'D:\QLNhaHang\Food\food\Pizza-phô-mai.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'PZ01    ', N'Pizza thịt', 190000, N'VND', N'PZ      ', N'D:\QLNhaHang\Resources\5.jpg')
GO
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL001   ', 100, N'Thịt bò', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL002   ', 52, N'Thịt lợn', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL003   ', 61, N'Cá hồi', N'Con')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL004   ', 61, N'Tôm', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL005   ', 36, N'Phomai', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL006   ', 120, N'Dứa', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL007   ', 120, N'Xà lách', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL008   ', 42, N'Nấm', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL009   ', 220, N'Bột mì', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL010   ', 20, N'Sốt cà chua', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL011   ', 110, N'Olive', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL012   ', 10, N'Mực', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL013   ', 10, N'Cam', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL014   ', 10, N'Táo', N'Kg')
GO
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC01   ', N'0283947239 ', 79070000, N'Gia Lâm, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC02   ', N'0365473950 ', 64960000, N'Thạch Thất, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC03   ', N'0362937495 ', 80880000, N'Long Biên, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC04   ', N'0325444666 ', 69750000, N'Hà Đông, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC05   ', N'0245385022 ', 72860000, N'Cầu Giấy, Hà Nội')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV01    ', N'Hà Công Quốc Bảo', CAST(N'2001-08-15' AS Date), N'Nam     ', N'Bắc Từ Liêm, Hà Nội', N'0358775132 ', N'Administrator', 20000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV02    ', N'Đào Việt Hà', CAST(N'2001-03-18' AS Date), N'Nu      ', N'Đô Lương, Nghệ An', N'0942700012 ', N'Warehouse Manager', 10000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV03    ', N'Nguyễn Phan Như Quỳnh', CAST(N'2001-08-11' AS Date), N'Nu      ', N'Pleiku, Gia Lai', N'0846231674 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV04    ', N'Nông Phương Trang', CAST(N'2001-02-06' AS Date), N'Nu      ', N'Sông Hiến, Cao Bằng', N'0846696888 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV05    ', N'Đỗ Đức Mạnh', CAST(N'2003-04-13' AS Date), N'Nam     ', N'Cầu Giấy, Hà Nội', N'0342859683 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV06    ', N'Phương Khánh Dũng', CAST(N'2000-01-04' AS Date), N'Nam     ', N'Hai Bà Trưng, Hà Nội', N'0348293472 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV07    ', N'Lý Minh Anh', CAST(N'2002-05-23' AS Date), N'Nam     ', N'Yên Thành, Nghệ An', N'0938774652 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV08    ', N'Phùng Khánh Linh', CAST(N'2003-02-16' AS Date), N'Nu      ', N'Hoằng Hóa, Thanh Hóa', N'0243573899 ', N'Cashier', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV09    ', N'Khổng Thanh Trà', CAST(N'2002-07-24' AS Date), N'Nu      ', N'Phổ Yên, Thái Nguyên', N'0452664859 ', N'Cashier', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV10    ', N'Tô Diệu Linh', CAST(N'2000-12-23' AS Date), N'Nu      ', N'Cầu Giấy, Hà Nội', N'0327492642 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV11    ', N'Thạch Huệ Anh', CAST(N'2001-11-23' AS Date), N'Nu      ', N'Vĩnh Yên, Vĩnh Phúc', N'0127384682 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV12    ', N'Lâm Minh Thu', CAST(N'2001-10-23' AS Date), N'Nu      ', N'Cầu Giấy, Hà Nội', N'0192475930 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV13    ', N'Thẩm Thu Trà', CAST(N'2001-10-05' AS Date), N'Nu      ', N'Long Biên, Hà Nội', N'0128465823 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV14    ', N'Lý Thảo My', CAST(N'2001-05-30' AS Date), N'Nu      ', N'Hoàn Kiếm, Hà Nội', N'0482940240 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
GO
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM0105  ', N'YC0058  ', 2)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM0105  ', N'YC0059  ', 2)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1003  ', N'YC0039  ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1003  ', N'YC0041  ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1003  ', N'YC0042  ', 2)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1402  ', N'YC0007  ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2022  ', N'YC0001  ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2022  ', N'YC0002  ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2022  ', N'YC0004  ', 1)
GO
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0001  ', CAST(N'2022-02-06' AS Date), 2000000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0002  ', CAST(N'2022-02-06' AS Date), 5000000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0003  ', CAST(N'2022-02-06' AS Date), 3620000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0004  ', CAST(N'2022-02-06' AS Date), 1500000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0005  ', CAST(N'2022-02-07' AS Date), 1000000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0006  ', CAST(N'2022-02-07' AS Date), 2100000, N'NV14    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0007  ', CAST(N'2022-02-07' AS Date), 4350000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0008  ', CAST(N'2022-02-07' AS Date), 3240000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0009  ', CAST(N'2022-02-08' AS Date), 1340000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0010  ', CAST(N'2022-02-08' AS Date), 2340000, N'NV14    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0011  ', CAST(N'2022-02-08' AS Date), 1440000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0012  ', CAST(N'2022-02-08' AS Date), 4350000, N'NV14    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0013  ', CAST(N'2022-02-09' AS Date), 2420000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0014  ', CAST(N'2022-02-09' AS Date), 2450000, N'NV10    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0015  ', CAST(N'2022-02-09' AS Date), 3510000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0016  ', CAST(N'2022-02-10' AS Date), 2450000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0017  ', CAST(N'2022-02-10' AS Date), 1350000, N'NV14    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0018  ', CAST(N'2022-02-10' AS Date), 1240000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0019  ', CAST(N'2022-02-10' AS Date), 5420000, N'NV14    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0020  ', CAST(N'2022-02-12' AS Date), 2450000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0021  ', CAST(N'2022-02-12' AS Date), 2340000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0022  ', CAST(N'2022-02-12' AS Date), 2110000, N'NV05    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0023  ', CAST(N'2022-02-12' AS Date), 2140000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0024  ', CAST(N'2022-02-13' AS Date), 1240000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0025  ', CAST(N'2022-02-13' AS Date), 5340000, N'NV14    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0026  ', CAST(N'2022-02-13' AS Date), 2520000, N'NV14    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0027  ', CAST(N'2022-02-13' AS Date), 2510000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0028  ', CAST(N'2022-02-14' AS Date), 3560000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0029  ', CAST(N'2022-02-15' AS Date), 1250000, N'NV10    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0030  ', CAST(N'2022-02-15' AS Date), 2520000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0031  ', CAST(N'2022-02-15' AS Date), 1440000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0032  ', CAST(N'2022-02-16' AS Date), 4350000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0033  ', CAST(N'2022-02-17' AS Date), 1340000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0034  ', CAST(N'2022-02-17' AS Date), 2450000, N'NV14    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0035  ', CAST(N'2022-02-17' AS Date), 3140000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0036  ', CAST(N'2022-02-17' AS Date), 2450000, N'NV10    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0037  ', CAST(N'2022-02-18' AS Date), 2450000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0038  ', CAST(N'2022-02-19' AS Date), 1240000, N'NV05    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0039  ', CAST(N'2022-02-19' AS Date), 5420000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0040  ', CAST(N'2022-02-15' AS Date), 2340000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0041  ', CAST(N'2022-02-19' AS Date), 2340000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0042  ', CAST(N'2022-02-19' AS Date), 2110000, N'NV05    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0043  ', CAST(N'2022-02-20' AS Date), 2240000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0044  ', CAST(N'2022-02-20' AS Date), 1240000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0045  ', CAST(N'2022-02-20' AS Date), 5340000, N'NV14    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0046  ', CAST(N'2022-02-21' AS Date), 1340000, N'NV14    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0047  ', CAST(N'2022-02-22' AS Date), 2530000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0048  ', CAST(N'2022-02-22' AS Date), 3560000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0049  ', CAST(N'2022-02-22' AS Date), 1250000, N'NV10    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0050  ', CAST(N'2022-02-19' AS Date), 2450000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0051  ', CAST(N'2022-02-23' AS Date), 1440000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0052  ', CAST(N'2022-02-23' AS Date), 4350000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0053  ', CAST(N'2022-02-24' AS Date), 1340000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0054  ', CAST(N'2022-02-24' AS Date), 2450000, N'NV14    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0055  ', CAST(N'2022-02-24' AS Date), 3140000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0056  ', CAST(N'2022-02-24' AS Date), 2450000, N'NV10    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0057  ', CAST(N'2022-02-24' AS Date), 3520000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0058  ', CAST(N'2022-02-25' AS Date), 2560000, N'NV05    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0059  ', CAST(N'2022-02-26' AS Date), 5420000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0060  ', CAST(N'2022-02-23' AS Date), 2340000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0061  ', CAST(N'2022-02-27' AS Date), 5310000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0062  ', CAST(N'2022-02-27' AS Date), 2110000, N'NV05    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0063  ', CAST(N'2022-02-28' AS Date), 2240000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0064  ', CAST(N'2022-02-28' AS Date), 1530000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0065  ', CAST(N'2022-03-01' AS Date), 3560000, N'NV14    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0066  ', CAST(N'2022-03-01' AS Date), 1340000, N'NV14    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0067  ', CAST(N'2022-03-02' AS Date), 2510000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0068  ', CAST(N'2022-03-02' AS Date), 3560000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0069  ', CAST(N'2022-03-02' AS Date), 3230000, N'NV10    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0070  ', CAST(N'2022-02-27' AS Date), 2450000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0071  ', CAST(N'2022-03-03' AS Date), 1440000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0072  ', CAST(N'2022-03-03' AS Date), 4350000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0073  ', CAST(N'2022-03-04' AS Date), 1340000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0074  ', CAST(N'2022-03-04' AS Date), 2450000, N'NV14    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0075  ', CAST(N'2022-03-05' AS Date), 3140000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0076  ', CAST(N'2022-03-06' AS Date), 2450000, N'NV10    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0077  ', CAST(N'2022-03-08' AS Date), 3520000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0078  ', CAST(N'2022-03-09' AS Date), 2560000, N'NV05    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0079  ', CAST(N'2022-03-09' AS Date), 5420000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0080  ', CAST(N'2022-03-03' AS Date), 2340000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0081  ', CAST(N'2022-03-09' AS Date), 5310000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0082  ', CAST(N'2022-03-09' AS Date), 2110000, N'NV05    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0083  ', CAST(N'2022-03-13' AS Date), 2240000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0084  ', CAST(N'2022-03-15' AS Date), 1530000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0085  ', CAST(N'2022-03-15' AS Date), 3560000, N'NV14    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0086  ', CAST(N'2022-03-15' AS Date), 1340000, N'NV14    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0087  ', CAST(N'2022-03-16' AS Date), 2510000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0088  ', CAST(N'2022-03-17' AS Date), 3560000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0089  ', CAST(N'2022-03-20' AS Date), 3230000, N'NV10    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0090  ', CAST(N'2022-03-09' AS Date), 2450000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0091  ', CAST(N'2022-03-20' AS Date), 2430000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0092  ', CAST(N'2022-03-23' AS Date), 4350000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0093  ', CAST(N'2022-03-24' AS Date), 2310000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0094  ', CAST(N'2022-03-24' AS Date), 2450000, N'NV14    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0095  ', CAST(N'2022-03-25' AS Date), 4350000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0096  ', CAST(N'2022-03-26' AS Date), 3530000, N'NV10    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0097  ', CAST(N'2022-03-28' AS Date), 3520000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0098  ', CAST(N'2022-03-29' AS Date), 2340000, N'NV05    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0099  ', CAST(N'2022-03-29' AS Date), 5420000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'pn01    ', CAST(N'2022-05-10' AS Date), 200000, N'NV01    ', N'NCC02   ')
GO
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0100  ', CAST(N'2022-03-20' AS Date), 2340000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0101  ', CAST(N'2022-03-29' AS Date), 5310000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0102  ', CAST(N'2022-03-29' AS Date), 2110000, N'NV05    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0103  ', CAST(N'2022-03-30' AS Date), 3420000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0104  ', CAST(N'2022-04-02' AS Date), 1530000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0105  ', CAST(N'2022-04-02' AS Date), 2440000, N'NV14    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0106  ', CAST(N'2022-04-02' AS Date), 1340000, N'NV14    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0107  ', CAST(N'2022-04-02' AS Date), 4230000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0108  ', CAST(N'2022-04-03' AS Date), 3560000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0109  ', CAST(N'2022-04-03' AS Date), 2420000, N'NV10    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0110  ', CAST(N'2022-03-29' AS Date), 2450000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0111  ', CAST(N'2022-04-04' AS Date), 2430000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0112  ', CAST(N'2022-04-04' AS Date), 4350000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0113  ', CAST(N'2022-04-04' AS Date), 2310000, N'NV14    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0114  ', CAST(N'2022-04-04' AS Date), 2450000, N'NV14    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0115  ', CAST(N'2022-04-05' AS Date), 4350000, N'NV05    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0116  ', CAST(N'2022-04-06' AS Date), 3530000, N'NV10    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0117  ', CAST(N'2022-04-06' AS Date), 3520000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0118  ', CAST(N'2022-04-07' AS Date), 2340000, N'NV05    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0119  ', CAST(N'2022-04-08' AS Date), 5420000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0120  ', CAST(N'2022-04-04' AS Date), 2340000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0121  ', CAST(N'2022-04-09' AS Date), 5310000, N'NV05    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0122  ', CAST(N'2022-04-09' AS Date), 2110000, N'NV05    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0123  ', CAST(N'2022-04-10' AS Date), 3420000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0124  ', CAST(N'2022-04-11' AS Date), 1530000, N'NV05    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0125  ', CAST(N'2022-04-12' AS Date), 2440000, N'NV14    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0126  ', CAST(N'2022-04-12' AS Date), 1340000, N'NV14    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0127  ', CAST(N'2022-04-12' AS Date), 4230000, N'NV10    ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0128  ', CAST(N'2022-04-12' AS Date), 3560000, N'NV10    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0129  ', CAST(N'2022-04-12' AS Date), 2420000, N'NV10    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0130  ', CAST(N'2022-04-09' AS Date), 2450000, N'NV10    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0131  ', CAST(N'2022-05-16' AS Date), 300000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0132  ', CAST(N'2022-05-15' AS Date), 800000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0133  ', CAST(N'2022-05-14' AS Date), 1050000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0134  ', CAST(N'2022-05-13' AS Date), 2000000, N'NV02    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0135  ', CAST(N'2022-05-12' AS Date), 400000, N'NV03    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0136  ', CAST(N'2022-05-11' AS Date), 2000000, N'NV02    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0137  ', CAST(N'2022-05-10' AS Date), 400000, N'NV03    ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0138  ', CAST(N'2022-05-09' AS Date), 600000, N'NV03    ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0139  ', CAST(N'2022-05-08' AS Date), 500000, N'NV03    ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0140  ', CAST(N'2022-05-17' AS Date), 600000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0141  ', CAST(N'2022-05-30' AS Date), 600000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0142  ', CAST(N'2022-05-24' AS Date), 1350000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN1000  ', CAST(N'2022-05-24' AS Date), 100000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN10001 ', CAST(N'2022-05-28' AS Date), 1200000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN109   ', CAST(N'2022-05-23' AS Date), 200000, N'NV01    ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN141   ', CAST(N'2022-05-18' AS Date), 1000000, N'NV01    ', N'NCC01   ')
GO
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0001  ', CAST(N'2022-02-07' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0002  ', CAST(N'2022-02-07' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0003  ', CAST(N'2022-02-08' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0004  ', CAST(N'2022-02-08' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0005  ', CAST(N'2022-02-08' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0006  ', CAST(N'2022-02-09' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0007  ', CAST(N'2022-02-09' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0008  ', CAST(N'2022-02-09' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0009  ', CAST(N'2022-02-09' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0010  ', CAST(N'2022-02-09' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0011  ', CAST(N'2022-02-10' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0012  ', CAST(N'2022-02-11' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0013  ', CAST(N'2022-02-11' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0014  ', CAST(N'2022-02-11' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0015  ', CAST(N'2022-02-13' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0016  ', CAST(N'2022-02-14' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0017  ', CAST(N'2022-02-14' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0018  ', CAST(N'2022-02-14' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0019  ', CAST(N'2022-02-14' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0020  ', CAST(N'2022-02-15' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0021  ', CAST(N'2022-02-17' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0022  ', CAST(N'2022-02-17' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0023  ', CAST(N'2022-02-18' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0024  ', CAST(N'2022-02-18' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0025  ', CAST(N'2022-02-18' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0026  ', CAST(N'2022-02-19' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0027  ', CAST(N'2022-02-20' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0028  ', CAST(N'2022-02-20' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0029  ', CAST(N'2022-02-22' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0030  ', CAST(N'2022-02-22' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0031  ', CAST(N'2022-02-23' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0032  ', CAST(N'2022-02-24' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0033  ', CAST(N'2022-02-24' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0034  ', CAST(N'2022-02-24' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0035  ', CAST(N'2022-02-25' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0036  ', CAST(N'2022-02-25' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0037  ', CAST(N'2022-02-26' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0038  ', CAST(N'2022-02-26' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0039  ', CAST(N'2022-02-28' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0040  ', CAST(N'2022-02-28' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0041  ', CAST(N'2022-03-02' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0042  ', CAST(N'2022-03-02' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0043  ', CAST(N'2022-03-03' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0044  ', CAST(N'2022-03-04' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0045  ', CAST(N'2022-03-05' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0046  ', CAST(N'2022-03-09' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0047  ', CAST(N'2022-03-10' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0048  ', CAST(N'2022-03-10' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0049  ', CAST(N'2022-03-12' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0050  ', CAST(N'2022-03-12' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0051  ', CAST(N'2022-03-13' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0052  ', CAST(N'2022-03-14' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0053  ', CAST(N'2022-03-14' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0054  ', CAST(N'2022-03-14' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0055  ', CAST(N'2022-03-15' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0056  ', CAST(N'2022-03-15' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0057  ', CAST(N'2022-03-16' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0058  ', CAST(N'2022-03-16' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0059  ', CAST(N'2022-03-17' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0060  ', CAST(N'2022-03-17' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0061  ', CAST(N'2022-03-18' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0062  ', CAST(N'2022-03-18' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0063  ', CAST(N'2022-03-19' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0064  ', CAST(N'2022-03-20' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0065  ', CAST(N'2022-03-21' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0066  ', CAST(N'2022-03-21' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0067  ', CAST(N'2022-03-21' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0068  ', CAST(N'2022-03-22' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0069  ', CAST(N'2022-03-22' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0070  ', CAST(N'2022-03-12' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0071  ', CAST(N'2022-03-23' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0072  ', CAST(N'2022-03-24' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0073  ', CAST(N'2022-03-24' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0074  ', CAST(N'2022-03-25' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0075  ', CAST(N'2022-03-25' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0076  ', CAST(N'2022-03-26' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0077  ', CAST(N'2022-03-27' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0078  ', CAST(N'2022-03-28' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0079  ', CAST(N'2022-03-28' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0080  ', CAST(N'2022-03-30' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0081  ', CAST(N'2022-03-30' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0082  ', CAST(N'2022-03-30' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0083  ', CAST(N'2022-04-01' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0084  ', CAST(N'2022-04-01' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0085  ', CAST(N'2022-04-02' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0086  ', CAST(N'2022-04-03' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0087  ', CAST(N'2022-04-03' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0088  ', CAST(N'2022-04-04' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0089  ', CAST(N'2022-04-04' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0090  ', CAST(N'2022-04-05' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0091  ', CAST(N'2022-04-05' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0092  ', CAST(N'2022-04-06' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0093  ', CAST(N'2022-04-07' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0094  ', CAST(N'2022-04-07' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0095  ', CAST(N'2022-04-07' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0096  ', CAST(N'2022-04-07' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0097  ', CAST(N'2022-04-09' AS Date), N'NV07    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0098  ', CAST(N'2022-04-09' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0099  ', CAST(N'2022-04-10' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0100  ', CAST(N'2022-04-10' AS Date), N'NV07    ')
GO
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0101  ', CAST(N'2022-04-11' AS Date), N'NV10    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0102  ', CAST(N'2022-04-11' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0103  ', CAST(N'2022-04-11' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0104  ', CAST(N'2022-04-12' AS Date), N'NV11    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0105  ', CAST(N'2022-04-12' AS Date), N'NV05    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0106  ', CAST(N'2022-04-12' AS Date), N'NV06    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0107  ', CAST(N'2022-05-17' AS Date), N'NV01    ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0108  ', CAST(N'2022-05-31' AS Date), N'NV02    ')
GO
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'1       ', CAST(N'2022-05-30' AS Date), N'09:47:48.4699844    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'2       ', CAST(N'2022-05-30' AS Date), N'08:25:35.2118807    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'3       ', CAST(N'2022-05-30' AS Date), N'08:26:14.0221428    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'827723  ', CAST(N'2022-05-10' AS Date), N'13:15:59.4817425    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'HD001   ', CAST(N'2022-05-16' AS Date), N'23:51:33.8302049    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'jhdjhj  ', CAST(N'2022-05-10' AS Date), N'12:49:26.5353725    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC001  ', CAST(N'2022-05-16' AS Date), N'23:55:27.8654153    ', N'1                   ', N'KH1234  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC0019 ', CAST(N'2022-05-17' AS Date), N'09:13:11.3655070    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC002  ', CAST(N'2022-05-17' AS Date), N'00:02:23.0758849    ', N'1                   ', N'KH1234  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC0111 ', CAST(N'2022-05-17' AS Date), N'00:07:13.7388150    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC014  ', CAST(N'2022-05-17' AS Date), N'00:25:54.9557876    ', N'1                   ', N'KH1234  ', N'B13     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC0809 ', CAST(N'2022-05-17' AS Date), N'13:06:40.1676447    ', N'1                   ', N'KH1234  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC0898 ', CAST(N'2022-05-17' AS Date), N'13:06:22.5910481    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC0899 ', CAST(N'2022-05-17' AS Date), N'13:06:32.7637929    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC100  ', CAST(N'2022-05-25' AS Date), N'10:50:25.0696015    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC101  ', CAST(N'2022-05-25' AS Date), N'10:53:34.6759456    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC103  ', CAST(N'2022-05-25' AS Date), N'10:55:45.7890622    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC104  ', CAST(N'2022-05-25' AS Date), N'10:56:15.5159690    ', N'1                   ', N'KH1234  ', N'B11     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC107  ', CAST(N'2022-05-26' AS Date), N'14:03:43.9870688    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC108  ', CAST(N'2022-05-26' AS Date), N'14:08:06.6248027    ', N'1                   ', N'KH1234  ', N'B12     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC110  ', CAST(N'2022-05-28' AS Date), N'00:31:42.3186815    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC111  ', CAST(N'2022-05-30' AS Date), N'08:41:48.8988315    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC112  ', CAST(N'2022-05-30' AS Date), N'13:49:46.1002364    ', N'1                   ', N'KH1234  ', N'B11     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC113  ', CAST(N'2022-05-31' AS Date), N'15:04:32.5128569    ', N'1                   ', N'KH1234  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC114  ', CAST(N'2022-06-03' AS Date), N'08:22:35.6386098    ', N'1                   ', N'KH1234  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC189  ', CAST(N'2022-05-17' AS Date), N'13:23:06.3911063    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC7777 ', CAST(N'2022-05-17' AS Date), N'12:54:10.5788046    ', N'1                   ', N'KH1234  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC8888 ', CAST(N'2022-05-17' AS Date), N'12:48:55.1107022    ', N'1                   ', N'KH1234  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'PYC9999 ', CAST(N'2022-05-17' AS Date), N'09:20:30.7473297    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'shdjs   ', CAST(N'2022-05-10' AS Date), N'13:10:54.5494645    ', N'1                   ', N'KH1234  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'shgdhs  ', CAST(N'2022-05-10' AS Date), N'13:08:17.9488607    ', N'1                   ', N'KH1234  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'usdyuys ', CAST(N'2022-05-10' AS Date), N'12:48:32.9836385    ', N'1                   ', N'KH1234  ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0001  ', CAST(N'2022-02-06' AS Date), N'07:45:12            ', N'1                   ', N'KH0001  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0002  ', CAST(N'2022-02-06' AS Date), N'08:15:14            ', N'1                   ', N'KH0001  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0003  ', CAST(N'2022-02-06' AS Date), N'08:18:25            ', N'1                   ', N'KH0002  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0004  ', CAST(N'2022-02-06' AS Date), N'09:05:39            ', N'1                   ', N'KH0003  ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0005  ', CAST(N'2022-02-07' AS Date), N'09:30:32            ', N'1                   ', N'KH0004  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0006  ', CAST(N'2022-02-10' AS Date), N'09:55:19            ', N'1                   ', N'KH0005  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0007  ', CAST(N'2022-02-13' AS Date), N'10:20:17            ', N'1                   ', N'KH0005  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0008  ', CAST(N'2022-02-18' AS Date), N'11:15:28            ', N'1                   ', N'KH0006  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0009  ', CAST(N'2022-02-19' AS Date), N'12:00:12            ', N'1                   ', N'KH0007  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0010  ', CAST(N'2022-02-19' AS Date), N'12:53:09            ', N'1                   ', N'KH0008  ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0011  ', CAST(N'2022-02-20' AS Date), N'14:07:17            ', N'1                   ', N'KH0009  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0012  ', CAST(N'2022-02-21' AS Date), N'15:07:20            ', N'1                   ', N'KH0010  ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0013  ', CAST(N'2022-02-25' AS Date), N'17:03:92            ', N'1                   ', N'KH0011  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0014  ', CAST(N'2022-02-27' AS Date), N'08:30:00            ', N'1                   ', N'KH0012  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0015  ', CAST(N'2022-02-28' AS Date), N'09:40:12            ', N'1                   ', N'KH0002  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0016  ', CAST(N'2022-02-28' AS Date), N'10:20:17            ', N'1                   ', N'KH0013  ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0017  ', CAST(N'2022-03-01' AS Date), N'08:13:42            ', N'1                   ', N'KH0014  ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0018  ', CAST(N'2022-03-02' AS Date), N'08:02:10            ', N'1                   ', N'KH0015  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0019  ', CAST(N'2022-03-03' AS Date), N'09:15:23            ', N'1                   ', N'KH0010  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0020  ', CAST(N'2022-03-04' AS Date), N'07:43:23            ', N'1                   ', N'KH0012  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0021  ', CAST(N'2022-03-04' AS Date), N'10:12:15            ', N'1                   ', N'KH0018  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0022  ', CAST(N'2022-03-05' AS Date), N'14:15:20            ', N'1                   ', N'KH0004  ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0023  ', CAST(N'2022-03-06' AS Date), N'09:12:09            ', N'1                   ', N'KH0008  ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0024  ', CAST(N'2022-03-11' AS Date), N'12:05:10            ', N'1                   ', N'KH0020  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0025  ', CAST(N'2022-03-15' AS Date), N'14:03:26            ', N'1                   ', N'KH0021  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0026  ', CAST(N'2022-03-15' AS Date), N'18:23:12            ', N'1                   ', N'KH0022  ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0027  ', CAST(N'2022-03-16' AS Date), N'08:16:18            ', N'1                   ', N'KH0023  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0028  ', CAST(N'2022-03-19' AS Date), N'07:12:05            ', N'1                   ', N'KH0024  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0029  ', CAST(N'2022-03-19' AS Date), N'08:11:21            ', N'1                   ', N'KH0025  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0030  ', CAST(N'2022-03-20' AS Date), N'07:14:39            ', N'1                   ', N'KH0026  ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0031  ', CAST(N'2022-03-28' AS Date), N'08:12:34            ', N'1                   ', N'KH0027  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0032  ', CAST(N'2022-03-29' AS Date), N'08:00:16            ', N'1                   ', N'KH0028  ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0033  ', CAST(N'2022-03-30' AS Date), N'08:00:15            ', N'1                   ', N'KH0016  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0034  ', CAST(N'2022-03-30' AS Date), N'09:04:35            ', N'1                   ', N'KH0017  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0035  ', CAST(N'2022-04-02' AS Date), N'07:02:11            ', N'1                   ', N'KH0029  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0036  ', CAST(N'2022-04-05' AS Date), N'07:06:18            ', N'1                   ', N'KH0030  ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0037  ', CAST(N'2022-04-06' AS Date), N'08:06:30            ', N'1                   ', N'KH0031  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0038  ', CAST(N'2022-04-07' AS Date), N'07:45:12            ', N'1                   ', N'KH0004  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0039  ', CAST(N'2022-04-09' AS Date), N'08:15:20            ', N'1                   ', N'KH0032  ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0040  ', CAST(N'2022-04-09' AS Date), N'10:14:30            ', N'1                   ', N'KH0033  ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0041  ', CAST(N'2022-04-09' AS Date), N'12:13:16            ', N'1                   ', N'KH0034  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0042  ', CAST(N'2022-04-10' AS Date), N'14:15:30            ', N'1                   ', N'KH0017  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0043  ', CAST(N'2022-04-12' AS Date), N'16:23:65            ', N'1                   ', N'KH0035  ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0044  ', CAST(N'2022-04-13' AS Date), N'08:12:32            ', N'1                   ', N'KH0036  ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0045  ', CAST(N'2022-04-14' AS Date), N'09:14:24            ', N'1                   ', N'KH0037  ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0046  ', CAST(N'2022-04-15' AS Date), N'12:45:28            ', N'1                   ', N'KH0038  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0047  ', CAST(N'2022-04-16' AS Date), N'08:17:11            ', N'1                   ', N'KH0039  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0048  ', CAST(N'2022-04-17' AS Date), N'09:00:10            ', N'1                   ', N'KH0009  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0049  ', CAST(N'2022-04-18' AS Date), N'09:10:14            ', N'1                   ', N'KH0040  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0050  ', CAST(N'2022-04-21' AS Date), N'10:15:14            ', N'1                   ', N'KH0041  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0051  ', CAST(N'2022-04-22' AS Date), N'11:15:23            ', N'1                   ', N'KH0042  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0052  ', CAST(N'2022-04-23' AS Date), N'12:11:34            ', N'1                   ', N'KH0043  ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0053  ', CAST(N'2022-04-25' AS Date), N'13:34:23            ', N'1                   ', N'KH0044  ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0054  ', CAST(N'2022-04-26' AS Date), N'14:05:43            ', N'1                   ', N'KH0045  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0055  ', CAST(N'2022-04-28' AS Date), N'15:13:35            ', N'1                   ', N'KH0046  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0056  ', CAST(N'2022-04-29' AS Date), N'07:55:14            ', N'1                   ', N'KH0047  ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0057  ', CAST(N'2022-04-29' AS Date), N'12:48:32.9836385    ', N'1                   ', N'KH0048  ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0058  ', CAST(N'2022-04-30' AS Date), N'09:19:29            ', N'1                   ', N'KH0049  ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC0059  ', CAST(N'2022-05-01' AS Date), N'07:45:33            ', N'1                   ', N'KH0050  ', N'B8      ')
GO
ALTER TABLE [dbo].[CHITIETNHAP]  WITH CHECK ADD  CONSTRAINT [FK_MaNL] FOREIGN KEY([MaNL])
REFERENCES [dbo].[NGUYENLIEU] ([MaNL])
GO
ALTER TABLE [dbo].[CHITIETNHAP] CHECK CONSTRAINT [FK_MaNL]
GO
ALTER TABLE [dbo].[CHITIETNHAP]  WITH CHECK ADD  CONSTRAINT [FK_SoPN] FOREIGN KEY([SoPN])
REFERENCES [dbo].[PHIEUNHAP] ([SoPN])
GO
ALTER TABLE [dbo].[CHITIETNHAP] CHECK CONSTRAINT [FK_SoPN]
GO
ALTER TABLE [dbo].[CHITIETPYC]  WITH CHECK ADD  CONSTRAINT [FK_MaMonAn] FOREIGN KEY([MaMonAn])
REFERENCES [dbo].[MONAN] ([MaMonAn])
GO
ALTER TABLE [dbo].[CHITIETPYC] CHECK CONSTRAINT [FK_MaMonAn]
GO
ALTER TABLE [dbo].[CHITIETPYC]  WITH CHECK ADD  CONSTRAINT [FK_SoPYC_3] FOREIGN KEY([SoPYC])
REFERENCES [dbo].[PHIEUYEUCAU] ([SoPYC])
GO
ALTER TABLE [dbo].[CHITIETPYC] CHECK CONSTRAINT [FK_SoPYC_3]
GO
ALTER TABLE [dbo].[CHITIETXUAT]  WITH CHECK ADD  CONSTRAINT [FK_MaNL_2] FOREIGN KEY([MaNL])
REFERENCES [dbo].[NGUYENLIEU] ([MaNL])
GO
ALTER TABLE [dbo].[CHITIETXUAT] CHECK CONSTRAINT [FK_MaNL_2]
GO
ALTER TABLE [dbo].[CHITIETXUAT]  WITH CHECK ADD  CONSTRAINT [FK_SoPX_2] FOREIGN KEY([SoPX])
REFERENCES [dbo].[PHIEUXUAT] ([SoPX])
GO
ALTER TABLE [dbo].[CHITIETXUAT] CHECK CONSTRAINT [FK_SoPX_2]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_MaKH_2] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KHACHHANG] ([MaKH])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_MaKH_2]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_MaNV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_MaNV]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_SoPYC] FOREIGN KEY([SoPYC])
REFERENCES [dbo].[PHIEUYEUCAU] ([SoPYC])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_SoPYC]
GO
ALTER TABLE [dbo].[MONAN]  WITH CHECK ADD  CONSTRAINT [FK_MaLM] FOREIGN KEY([MaLM])
REFERENCES [dbo].[LOAIMON] ([MaLM])
GO
ALTER TABLE [dbo].[MONAN] CHECK CONSTRAINT [FK_MaLM]
GO
ALTER TABLE [dbo].[PHIEUKM]  WITH CHECK ADD  CONSTRAINT [FK_MaKM] FOREIGN KEY([MaKM])
REFERENCES [dbo].[KHUYENMAI] ([MaKM])
GO
ALTER TABLE [dbo].[PHIEUKM] CHECK CONSTRAINT [FK_MaKM]
GO
ALTER TABLE [dbo].[PHIEUKM]  WITH CHECK ADD  CONSTRAINT [FK_SoPYC_2] FOREIGN KEY([SoPYC])
REFERENCES [dbo].[PHIEUYEUCAU] ([SoPYC])
GO
ALTER TABLE [dbo].[PHIEUKM] CHECK CONSTRAINT [FK_SoPYC_2]
GO
ALTER TABLE [dbo].[PHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_MaNCC] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NHACUNGCAP] ([MaNCC])
GO
ALTER TABLE [dbo].[PHIEUNHAP] CHECK CONSTRAINT [FK_MaNCC]
GO
ALTER TABLE [dbo].[PHIEUNHAP]  WITH CHECK ADD  CONSTRAINT [FK_MaNV_1] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[PHIEUNHAP] CHECK CONSTRAINT [FK_MaNV_1]
GO
ALTER TABLE [dbo].[PHIEUXUAT]  WITH CHECK ADD  CONSTRAINT [FK_MaNV_3] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[PHIEUXUAT] CHECK CONSTRAINT [FK_MaNV_3]
GO
ALTER TABLE [dbo].[PHIEUYEUCAU]  WITH CHECK ADD  CONSTRAINT [FK_MaKH] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KHACHHANG] ([MaKH])
GO
ALTER TABLE [dbo].[PHIEUYEUCAU] CHECK CONSTRAINT [FK_MaKH]
GO
ALTER TABLE [dbo].[PHIEUYEUCAU]  WITH CHECK ADD  CONSTRAINT [FK_SoHieuBan] FOREIGN KEY([SoHieuBan])
REFERENCES [dbo].[BAN] ([SoHieuBan])
GO
ALTER TABLE [dbo].[PHIEUYEUCAU] CHECK CONSTRAINT [FK_SoHieuBan]
GO
/****** Object:  StoredProcedure [dbo].[add_CTPyc]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[add_CTPyc](@spyc char(8), @mamon char(8),@sl int, @gia bigint)
as
begin
	INSERT INTO CHITIETPYC (SOPYC, MAMONAN, SOLUONG, DONGIA) VALUES  (@spyc, @mamon, @sl, @gia)
end	
GO
/****** Object:  StoredProcedure [dbo].[Add_HD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Add_HD](@ma char(8),@ngay datetime,@tongTien bigint, @manv CHAR(8), @makh CHAR(8),@pyc char(8))
as
begin
 insert into HOADON values(@ma,@ngay,@tongTien,@manv, @makh, @pyc)
end
GO
/****** Object:  StoredProcedure [dbo].[add_KH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[add_KH](@ma char(8),@ten as nvarchar(26),@sdt as char(11),@dc as nvarchar(100))
as 
begin
	INSERT into KHACHHANG(MaKH, TenKH, SoDienThoai, DiaChi) VALUES (@ma, @ten, @sdt, @dc)	
End
GO
/****** Object:  StoredProcedure [dbo].[add_KM]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[add_KM](@ma char(8),@ten nvarchar(50),@han date,@muc char(8))
as
begin
 insert into KHUYENMAI values(@ma,@ten,@han,@muc)
end
GO
/****** Object:  StoredProcedure [dbo].[add_NV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[add_NV](@MANV CHAR(8),@hoten nvarchar(26),@NgaySinh date,@gioitinh char(8), @diaChi nvarchar(100), @soDienThoai char(11),@chucVu nvarchar(26), @luong bigint)
As 
Begin
INSERT INTO NHANVIEN (maNV,hoTen,ngaysinh, gioitinh,diaChi,soDienThoai,chucVu, luong, matkhau) VALUES(@MANV,@hoten,@ngaysinh,@gioitinh ,@diaChi,@soDienThoai, @chucVu, @luong, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
End
GO
/****** Object:  StoredProcedure [dbo].[add_Pyc]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[add_Pyc](@spyc char(8), @ngayxuat date, @ngayyc char(20), @loai char(20), @ma char(8), @shb char(8))
as
begin
	Insert into PHIEUYEUCAU(SOPYC, NGAYXUAT, NGAYGIOYC, LOAI, MAKH, SOHIEUBAN) values (@spyc, @ngayxuat, @ngayyc, @loai, @ma, @shb)
end
GO
/****** Object:  StoredProcedure [dbo].[BanAn_Load]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BanAn_Load] 
AS
BEGIN
	SELECT * FROM BAN
END
GO
/****** Object:  StoredProcedure [dbo].[BDNam]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDNam] as
begin
SELECT YEAR(NgayThu) as NamThu, SUM(TongTien) as Tong 
FROM HOADON
WHERE YEAR(NgayThu) >= DATEADD(year, -3, YEAR(GETDATE())) and YEAR(NgayThu)<= YEAR(GETDATE())
GROUP BY YEAR(NgayThu)
end
GO
/****** Object:  StoredProcedure [dbo].[BDNam_Chi]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDNam_Chi] as
begin
SELECT YEAR(NgayNhap) as NamNhap, SUM(TongTien) as Tong 
FROM PHIEUNHAP
WHERE YEAR(NgayNhap) >= DATEADD(year, -3, YEAR(GETDATE())) and YEAR(NgayNhap)<= YEAR(GETDATE())
GROUP BY YEAR(NgayNhap)
end
GO
/****** Object:  StoredProcedure [dbo].[BDNam_Thu]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDNam_Thu] as
begin
SELECT YEAR(NgayThu) as NamThu, SUM(TongTien) as Tong 
FROM HOADON
WHERE YEAR(NgayThu) >= DATEADD(year, -3, YEAR(GETDATE())) and YEAR(NgayThu)<= YEAR(GETDATE())
GROUP BY YEAR(NgayThu)
end
GO
/****** Object:  StoredProcedure [dbo].[BDNgay_Chi]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDNgay_Chi] as
begin
SELECT NgayNhap, SUM(TongTien) as Tong 
FROM PHIEUNHAP 
WHERE NgayNhap between  DATEADD(day, -7, GETDATE()-55) and (getdate()-55)
GROUP BY NgayNhap
end
GO
/****** Object:  StoredProcedure [dbo].[BDNgay_Thu]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDNgay_Thu] as
begin
SELECT NgayThu, SUM(TongTien) as Tong 
FROM HOADON 
WHERE NgayThu between  DATEADD(day, -7, GETDATE()) and getdate()
GROUP BY NgayThu
end
GO
/****** Object:  StoredProcedure [dbo].[BDThang]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDThang] as
begin
SELECT MONTH(NgayThu) as ThangThu, SUM(TongTien) as Tong 
FROM HOADON
WHERE MONTH(NgayThu) >= DATEADD(month, -3, MONTH(GETDATE())-1) and MONTH(NgayThu) <= (MONTH(GETDATE())-1)
GROUP BY MONTH(NgayThu)
end
GO
/****** Object:  StoredProcedure [dbo].[BDThang_Chi]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDThang_Chi] as
begin
SELECT MONTH(NgayNhap) as ThangNhap, SUM(TongTien) as Tong 
FROM PHIEUNHAP
WHERE MONTH(NgayNhap) >= DATEADD(month, -3, MONTH(GETDATE())) and MONTH(NgayNhap) <= MONTH(GETDATE())
GROUP BY MONTH(NgayNhap)
end
GO
/****** Object:  StoredProcedure [dbo].[BDThang_Thu]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[BDThang_Thu] as
begin
SELECT MONTH(NgayThu) as ThangThu, SUM(TongTien) as Tong 
FROM HOADON
WHERE MONTH(NgayThu) >= DATEADD(month, -3, MONTH(GETDATE())) and MONTH(NgayThu) <= MONTH(GETDATE())
GROUP BY MONTH(NgayThu)
end
GO
/****** Object:  StoredProcedure [dbo].[book_table]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[book_table](@shb char(8))
as
begin
	Update Ban set TinhTrang = N'BOOKED' where SoHieuBan = @shb
end
GO
/****** Object:  StoredProcedure [dbo].[Cancel_ban]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[Cancel_ban](@shb as char(8))
as
begin
	-- cap nhat lai trang thai ban
	
	select @shb=soHieuBan from Ban where tinhTrang = 'BOOKED'
	update BAN set tinhTrang='NONE' where BAN.soHieuBan=@shb
end
GO
/****** Object:  StoredProcedure [dbo].[ChiTietNhap_ChinhSua]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ChiTietNhap_ChinhSua] 
(@sopn NVARCHAR(100),
@ngaynhap NVARCHAR(100),
@tongtien NVARCHAR(100),
@manv NVARCHAR(100),
@mancc NVARCHAR(100))
AS
BEGIN
	UPDATE PHIEUNHAP 
	SET NgayNhap = @ngaynhap, TongTien = @tongtien, MaNV = @manv, MaNCC = @mancc
	WHERE soPN = @sopn
END
GO
/****** Object:  StoredProcedure [dbo].[ChiTietNhap_Load]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ChiTietNhap_Load] (@sopn NVARCHAR(100))
AS
BEGIN
	SELECT NL.MaNL AS N'Mã nguyên liệu', NL.TenNL AS N'Tên nguyên liệu', CTN.SoLuong AS N'Số lượng', NL.DonVi AS N'Đơn vị', CTN.DonGia AS N'Đơn giá' 
	FROM CHITIETNHAP AS CTN, NGUYENLIEU AS NL 
	WHERE CTN.MaNL = NL.MaNL AND CTN.SoPN = @sopn
END
GO
/****** Object:  StoredProcedure [dbo].[ChiTietNhap_Xoa]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ChiTietNhap_Xoa]  (@sopn NVARCHAR(100))
AS
BEGIN
	BEGIN
		DELETE FROM CHITIETNHAP WHERE SoPN = @sopn
	END
	BEGIN
		DELETE FROM PHIEUNHAP WHERE SoPN = @sopn
	END
END
GO
/****** Object:  StoredProcedure [dbo].[ChiTietXuat_ChinhSua]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ChiTietXuat_ChinhSua] 
(@sopx NVARCHAR(100),
@ngayxuat NVARCHAR(100),
@manv NVARCHAR(100))
AS
BEGIN
	UPDATE PHIEUXUAT 
	SET NgayXuat = @ngayxuat, MaNV = @manv 
	WHERE soPX = @sopx
END
GO
/****** Object:  StoredProcedure [dbo].[ChiTietXuat_Load]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ChiTietXuat_Load] (@sopx NVARCHAR(100))
AS
BEGIN
	SELECT NGUYENLIEU.MaNL AS N'Mã nguyên liệu', TenNL AS N'Tên nguyên liệu', CHITIETXUAT.SoLuong AS N'Số lượng' 
	FROM NGUYENLIEU, CHITIETXUAT 
	WHERE NGUYENLIEU.MaNL = CHITIETXUAT.MaNL AND CHITIETXUAT.SoPX = @sopx
END
GO
/****** Object:  StoredProcedure [dbo].[ChiTietXuat_Xoa]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ChiTietXuat_Xoa] (@sopx NVARCHAR(100))
AS
BEGIN
	BEGIN
		DELETE FROM CHITIETXUAT WHERE SoPX = @sopx
	END
	BEGIN
		DELETE FROM PHIEUXUAT WHERE SoPX = @sopx
	END
END
GO
/****** Object:  StoredProcedure [dbo].[delete_KH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[delete_KH](@maKH CHAR(8))
as
Begin
Update  KHACHHANG set SoDienThoai=NULL, TenKH = Null, diachi = NULL  where MaKH=@maKH
end 
GO
/****** Object:  StoredProcedure [dbo].[delete_KM]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[delete_KM](@ma char(8))
as
begin
delete from KHUYENMAI where maKM=@ma
delete from PHIEUKM where MaKM= @ma
end
GO
/****** Object:  StoredProcedure [dbo].[delete_NV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[delete_NV](@maNV CHAR(8))
as
Begin
	Update NhanVien set hoTen = NULL, diaChi = NULL, soDienThoai = NULL, chucVu = NULL where maNV = @maNV
end 
GO
/****** Object:  StoredProcedure [dbo].[DemPYC]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DemPYC]  @ma char(10)
as
begin
DECLARE @sl int
select @sl=count(soPYC) from PHIEUYEUCAU group by maKH having  maKH=@ma
if @sl>=5
  begin
       print N'Khách hàng có mã '+@ma+N'có số lần yêu cầu đơn là '+CONVERT(char,@sl)
  end
else
   begin
       print N'Không thỏa mãn!'
   end
end
GO
/****** Object:  StoredProcedure [dbo].[get_dataTable]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_dataTable](@shb as char(8))
as 
begin
	select p.soPYC, tenmon, soLuong, m.DonGia,Sum(m.donGia*soLuong), h.tongTien
	from CHITIETPYC c,MONAN m, PHIEUYEUCAU p, HOADON h
	where c.maMonAn = m.maMonAn	and c.soPYC = p.soPYC and p.soHieuBan = @shb and p.Loai = 2 and h.soPYC = p.soPYC
	group by tenMon, soLuong, m.DonGia,p.soPYC, h.tongTien
end
GO
/****** Object:  StoredProcedure [dbo].[get_MaMonAn]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_MaMonAn](@tenmon nvarchar(50))
as
begin
	select mamonan from MONAN where TenMon  = @tenmon
end
GO
/****** Object:  StoredProcedure [dbo].[get_MucGiam]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_MucGiam](@ma char(8))
as
begin 
	select mucgiam from KHUYENMAI where MaKM = @ma
end
GO
/****** Object:  StoredProcedure [dbo].[get_preMoney]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_preMoney](@spyc char(8))
as
begin 
	select Sum((Soluong)*(Dongia)) from CHITIETPYC where sopyc = @spyc
end
GO
/****** Object:  StoredProcedure [dbo].[get_preTT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_preTT](@maKH char(8))
as 
begin
	select sum(donGia) from CHITIETPYC,PHIEUYEUCAU where maKH=@maKH and CHITIETPYC.soPYC=PHIEUYEUCAU.soPYC
end
GO
/****** Object:  StoredProcedure [dbo].[get_Pyc2]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_Pyc2]
as
begin 
	select * from PHIEUYEUCAU where loai='2'
end
GO
/****** Object:  StoredProcedure [dbo].[get_Shb]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_Shb]
as
begin 
	select sohieuban from ban where TinhTrang='NONE'
end
GO
/****** Object:  StoredProcedure [dbo].[get_Status]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[get_Status](@shb char(8))
as
begin 
  Select tinhtrang from ban where sohieuban = @shb
end
GO
/****** Object:  StoredProcedure [dbo].[IN_HOA_DON]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[IN_HOA_DON] 
(@sopyc NVARCHAR(100), @tongtien NVARCHAR(100))
AS
BEGIN
	SELECT PHIEUYEUCAU.SoPYC, PHIEUYEUCAU.NgayXuat, PHIEUYEUCAU.SoHieuBan, KHACHHANG.TenKH,
			CHITIETPYC.MaMonAn, CHITIETPYC.DonGia, CHITIETPYC.SoLuong, @tongtien
	FROM PHIEUYEUCAU, KHACHHANG, CHITIETPYC
	WHERE PHIEUYEUCAU.SoPYC = CHITIETPYC.SoPYC
	AND KHACHHANG.MaKH = PHIEUYEUCAU.MaKH
	AND PHIEUYEUCAU.SoPYC = @sopyc
END
GO
/****** Object:  StoredProcedure [dbo].[KMofcustomer]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[KMofcustomer] (@sdt char(11))
as
begin
	select bang1.MaKH,PHIEUYEUCAU.SoPYC,PHIEUYEUCAU.NgayGioYC,KHUYENMAI.MaKM,KHUYENMAI.TenKM,KHUYENMAI.Han,KHUYENMAI.MucGiam,PHIEUKM.SoLuong 
	from (select maKH from KHACHHANG where soDienThoai=@sdt)as bang1,PHIEUYEUCAU,KHUYENMAI,PHIEUKM
	where bang1.maKH = PHIEUYEUCAU.maKH 
	and PHIEUKM.soPYC = PHIEUYEUCAU.soPYC
	and PHIEUKM.maKM = KHUYENMAI.maKM
end
GO
/****** Object:  StoredProcedure [dbo].[MonAn_Load]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MonAn_Load] 
AS
BEGIN
	SELECT * FROM MONAN
END
GO
/****** Object:  StoredProcedure [dbo].[MonAn_TimKiem]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MonAn_TimKiem] 
(@mon NVARCHAR(100), 
@gia NVARCHAR(100))
AS
BEGIN
	DECLARE  @monan NVARCHAR(100)
	DECLARE  @giamon1 NVARCHAR(100)
	DECLARE  @giamon2 NVARCHAR(100)
	IF @mon = 'Pizza'
	BEGIN
		SET @monan = 'PZ'
	END
	IF @mon = 'Humberger'
	BEGIN
		SET @monan = 'BR'
	END
	IF @mon = 'Cake'
	BEGIN
		SET @monan = 'CAKE'
	END
	IF @mon = 'Drink'
	BEGIN
		SET @monan = 'NU'
	END

	IF @gia = '0-100K'
	BEGIN
		SET @giamon1 = 0
		SET @giamon2 = 100000
	END

	IF @gia = '100-200k'
	BEGIN
		SET @giamon1 = 100000
		SET @giamon2 = 200000
	END

	IF @gia = '>200k'
	BEGIN
		SET @giamon1 = 200000
		SET @giamon2 = 10000000
	END

	SELECT * FROM MONAN 
	WHERE MONAN.MaMonAn LIKE N'%' + @monan + '%'
	AND MONAN.DonGia > @giamon1 AND MONAN.DonGia <= @giamon2
END
GO
/****** Object:  StoredProcedure [dbo].[NCC_max]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NCC_max]
as
begin
	select maNCC, soDienThoai, diaChi
	from NHACUNGCAP
	where NHACUNGCAP.maNCC = (select top 1 temp.maNCC
	from (select NHACUNGCAP.maNCC, count(PHIEUNHAP.maNCC) as sl
	from PHIEUNHAP, NHACUNGCAP
	where NHACUNGCAP.maNCC = PHIEUNHAP.maNCC
	group by NHACUNGCAP.maNCC
	) as temp
	order by temp.sl desc )
end 
GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_ItSD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_ItSD] (@ngaysd NVARCHAR(20))
AS
BEGIN
    SELECT DISTINCT TOP 3 NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUXUAT AS PX, CHITIETXUAT AS CTX 
	WHERE NL.MaNL = CTX.MaNL AND CTX.SoPX = PX.SoPX AND PX.NgayXuat <= @ngaysd
END
GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_Load]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_Load]
AS
BEGIN
    SELECT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' 
	FROM NGUYENLIEU
END
GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_MoiNhap]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_MoiNhap] (@ngaynhap NVARCHAR(20))
AS
BEGIN
    SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUNHAP AS PN, CHITIETNHAP AS CTN 
	WHERE NL.MaNL = CTN.MaNL AND CTN.SoPN = PN.SoPN AND PN.NgayNhap >= @ngaynhap
END


--(@manl NVARCHAR(100), @tennl NVARCHAR(100))

GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_SapHet]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_SapHet] 
AS
BEGIN
    SELECT DISTINCT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' 
	FROM NGUYENLIEU 
	WHERE SoLuong <= 3
END
GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_ThuongXuyen]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_ThuongXuyen] 
AS
BEGIN
    SELECT DISTINCT NGUYENLIEU.MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', NGUYENLIEU.SoLuong as 'Số lượng', DonVi as 'Đơn vị' 
	FROM CHITIETNHAP, NGUYENLIEU 
	WHERE CHITIETNHAP.MaNL = NGUYENLIEU.MaNL 
	GROUP BY NGUYENLIEU.MaNL, NGUYENLIEU.TenNL, NGUYENLIEU.TenNL, NGUYENLIEU.SoLuong, NGUYENLIEU.DonVi 
	HAVING COUNT(CHITIETNHAP.SoPN) >= ALL(SELECT COUNT(CHITIETNHAP.SoPN) 
	FROM CHITIETNHAP, NGUYENLIEU 
	WHERE CHITIETNHAP.MaNL = NGUYENLIEU.MaNL 
	GROUP BY NGUYENLIEU.MaNL)
END
GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_TimKiem]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_TimKiem] (@manl NVARCHAR(100), @tennl NVARCHAR(100))
AS
BEGIN
    SELECT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' 
	FROM NGUYENLIEU 
	WHERE MaNL = @manl 
	OR TenNL =@tennl
END
GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_TonKho]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_TonKho] (@ngaysd NVARCHAR(20))
AS
BEGIN
    SELECT DISTINCT TOP 3 NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUNHAP AS PN, CHITIETNHAP AS CTN 
	WHERE NL.MaNL = CTN.MaNL AND CTN.SoPN = PN.SoPN AND PN.NgayNhap <= @ngaysd
END
GO
/****** Object:  StoredProcedure [dbo].[NguyenLieu_VuaXuat]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[NguyenLieu_VuaXuat] (@ngayxuat DATE)
AS
BEGIN
    SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUXUAT AS PX, CHITIETXUAT AS CTX 
	WHERE NL.MaNL = CTX.MaNL AND CTX.SoPX = PX.SoPX AND PX.NgayXuat >= @ngayxuat
END
GO
/****** Object:  StoredProcedure [dbo].[PhieuNhap_Load]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PhieuNhap_Load] 
AS
BEGIN
    SELECT SoPN as 'Số phiếu nhập', NgayNhap as 'Ngày nhập', TongTien as 'Tổng tiền', MaNV as 'Mã nhân viên', MaNCC as 'Nhà cung cấp' 
	FROM PHIEUNHAP
END
GO
/****** Object:  StoredProcedure [dbo].[PhieuNhap_TimKiem]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PhieuNhap_TimKiem] 
(@sopn NVARCHAR(100), 
@ngaynhap1 NVARCHAR(100), 
@ngaynhap2 NVARCHAR(100),
@tongtien NVARCHAR(100), 
@manv NVARCHAR(100), 
@mancc NVARCHAR(100))
AS
BEGIN
	SELECT SoPN as 'Số phiếu nhập', NgayNhap as 'Ngày nhập', TongTien as 'Tổng tiền', MaNV as 'Mã nhân viên', MaNCC as 'Nhà cung cấp' 
	FROM Phieunhap 
	WHERE SoPN LIKE N'%' + @sopn + '%'
	OR NgayNhap BETWEEN @ngaynhap1 AND @ngaynhap2
	OR TongTien = @tongtien
	OR MaNV LIKE N'%' + @manv + '%'
	OR MaNCC LIKE N'%' + @mancc + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[PhieuXuat_Load]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PhieuXuat_Load]  
AS
BEGIN
	SELECT SoPX as 'Số phiếu xuất', NgayXuat as 'Ngày xuất', PHIEUXUAT.MaNV as 'Mã nhân viên',NHANVIEN.HoTen as 'Tên nhân viên' 
	FROM PHIEUXUAT, NHANVIEN 
	WHERE PHIEUXUAT.MaNV = NHANVIEN.MaNV
END
GO
/****** Object:  StoredProcedure [dbo].[PhieuXuat_TimKiem]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PhieuXuat_TimKiem]  
(@sopx NVARCHAR(100), 
@date1 NVARCHAR(100), 
@date2 NVARCHAR(100), 
@manv NVARCHAR(100))
AS
BEGIN
	SELECT SoPX as 'Số phiếu xuất', NgayXuat as 'Ngày xuất', PHIEUXUAT.MaNV as 'Mã nhân viên',NHANVIEN.HoTen as 'Tên nhân viên' 
	FROM PHIEUXUAT, NHANVIEN 
	WHERE PHIEUXUAT.MaNV = NHANVIEN.MaNV
	AND SoPX LIKE N'%' + @sopx + '%'
	AND NgayXuat BETWEEN @date1 AND @date2
	AND PHIEUXUAT.MaNV LIKE N'%' + @manv + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[proc_xemKH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_xemKH](@ma char(8))
as
begin
declare @pyc char(8)
select @pyc=soPYC from PHIEUYEUCAU where maKH=@ma
select a.maKH,tenKH,soDienThoai,diaChi,p.soPYC,ngayGioYC,maMonAn,soLuong,p.soHieuBan, b.ViTri,ngayThu,tongTien 
from (KHACHHANG a  join PHIEUYEUCAU p  on a.maKH=p.maKH and a.maKH=@ma join CHITIETPYC c on p.soPYC=c.soPYC join Ban b on b.SoHieuBan=p.SoHieuBan join HOADON h on c.soPYC=h.soPYC )
end
GO
/****** Object:  StoredProcedure [dbo].[SearchFood]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchFood](@tenMon nvarchar(100))
as
begin
	select * from MONAN where tenMon like '%'+@tenMon+'%'
end
GO
/****** Object:  StoredProcedure [dbo].[Them_HD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Them_HD](@MaHD CHAR(8),@NgayThu date,@TongTien
bigint,@MaNV char(8), @MaKH char(8), @SoPYC char(8))
As
Begin
INSERT INTO HOADON (MaHD,NgayThu,TongTien,MaNV,MaKH,SoPYC)
VALUES (@MaHD,@NgayThu,@TongTien,@MaNV,@MaKH,@SoPYC)
End
GO
/****** Object:  StoredProcedure [dbo].[ThemNguyenLieu_ThemNL]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemNguyenLieu_ThemNL]  
(@sopn NVARCHAR(100), 
@manl NVARCHAR(100), 
@soluong NVARCHAR(100), 
@dongia NVARCHAR(100))
AS
BEGIN
	BEGIN
		INSERT INTO CHITIETNHAP VALUES (@sopn, @manl, @soluong, @dongia)
	END
	BEGIN
		DECLARE  @sumsoluong int
		SELECT @sumsoluong = NGUYENLIEU.SoLuong FROM NGUYENLIEU WHERE NGUYENLIEU.MaNL = @manl
		SET @sumsoluong = @sumsoluong + @soluong
		UPDATE NGUYENLIEU SET SoLuong = @sumsoluong WHERE MaNL = @manl
	END
END
GO
/****** Object:  StoredProcedure [dbo].[ThemNguyenLieu_ThemPN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ThemNguyenLieu_ThemPN]  
(@sopn NVARCHAR(100), 
@ngaynhap NVARCHAR(100), 
@tongtien NVARCHAR(100), 
@manv NVARCHAR(100), 
@mancc NVARCHAR(100))
AS
BEGIN
	INSERT INTO PHIEUNHAP VALUES (@sopn, @ngaynhap, @tongtien, @manv, @mancc)
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐnam_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐnam_CHI] 
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE YEAR(NgayNhap) =  YEAR(getdate())
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐnam_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐnam_THU] 
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE YEAR(NgayThu) = YEAR(getdate())
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐnam1_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐnam1_CHI] 
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE YEAR(NgayNhap) =  YEAR(getdate()) - 1
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐnam1_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐnam1_THU] 
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE YEAR(NgayThu) = YEAR(getdate()) - 1
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐngay_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐngay_CHI] 
AS
BEGIN
	SELECT SUM(TongTien) Tong FROM PHIEUNHAP 
	WHERE MONTH(NgayNhap) = GETDATE() 
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐngay_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐngay_THU] 
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE NgayThu = GETDATE()
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐngay1_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐngay1_CHI] 
AS
BEGIN
	SELECT SUM(TongTien) Tong FROM PHIEUNHAP 
	WHERE MONTH(NgayNhap) = (GETDATE()-1)
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐngay1_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐngay1_THU] 
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE NgayThu = (GETDATE()-1)
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐthang_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[TKBĐthang_CHI] 
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE MONTH(NgayNhap) = MONTH(Getdate()) 
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐthang_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐthang_THU] 
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE MONTH(NgayThu) = MONTH(getdate())
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐthang1_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[TKBĐthang1_CHI] 
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE MONTH(NgayNhap) = MONTH(Getdate()) - 1
END
GO
/****** Object:  StoredProcedure [dbo].[TKBĐthang1_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKBĐthang1_THU] 
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE MONTH(NgayThu) = MONTH(getdate()) - 1
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_CHI] 
( @date1 date,
  @date2 date)
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE NgayNhap between  @date1 and @date2
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_KH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_KH] 
( @date1 date,
  @date2 date)
AS
BEGIN
	SELECT K.TenKH FROM KHACHHANG K, HOADON H 
	WHERE K.MaKH = H.MaKH AND NgayThu between @date1 and @date2
	GROUP BY K.TenKH 
	HAVING SUM(TONGTIEN)>= ALL (SELECT SUM(TONGTIEN) FROM  KHACHHANG A join HOADON B 
	on A.MaKH = B.MaKH WHERE NgayThu  between @date1 and @date2 group by A.MaKH) -- @date1 and @date2 )
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_MonDT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_MonDT] 
( @date1 date,
  @date2 date)
AS
BEGIN
	SELECT M.TenMon
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn 
	JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC 
	WHERE NgayXuat between @date1 and @date2
	GROUP BY M.TenMon, M.DonGia, P.SoLuong 
	HAVING (M.DonGia *P.SoLuong) >= ALL (SELECT (M.DonGia *P.SoLuong) 
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 
	ON P.SoPYC = P2.SoPYC 
	WHERE NgayXuat between @date1 and @date2)
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_MonYT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_MonYT] 
( @date1 NVARCHAR(100),
  @date2 NVARCHAR(100))
AS
BEGIN
    select ma.TenMon 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and p.NgayXuat between @date1 and @date2
	group by ma.TenMon having count(pyc.SoPYC) >= all(
	select count(pyc.SoPYC) 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and p.NgayXuat between @date1 and @date2
	group by ma.TenMon)
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_NV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_NV] 
( @date1 date,
  @date2 date)
AS
BEGIN
	select nv.HoTen from NHANVIEN as nv, HOADON as hd  
	where (nv.MaNV = hd.MaNV and hd.NgayThu between @date1 and @date2)
	group by nv.HoTen having (count(hd.MaHD)) >=  all (select count(hd.MaHD) 
	from NHANVIEN as nv, HOADON as hd where (nv.MaNV = hd.MaNV and hd.NgayThu between @date1 and @date2)
	group by nv.HoTen)
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_SoHD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_SoHD] 
( @date1 date,
  @date2 date)
AS
BEGIN
	SELECT COUNT(MaHD) SoLuotPX FROM HOADON 
	WHERE NgayThu between @date1 and @date2
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_SoPN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_SoPN] 
( @date1 date,
  @date2 date)
AS
BEGIN
	SELECT COUNT(SoPN) SoLuotPN FROM PHIEUNHAP 
	WHERE NgayNhap  between @date1 and @date2
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_SoPX]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_SoPX] 
( @date1 date,
  @date2 date)
AS
BEGIN
	SELECT COUNT(SoPX) SoLuotPX FROM PHIEUXUAT 
	WHERE NgayXuat between @date1 and @date2
END
GO
/****** Object:  StoredProcedure [dbo].[TKchon_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKchon_THU] 
( @date1 date,
  @date2 date)
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE NgayThu between  @date1 and @date2
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_CHI] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE YEAR(NgayNhap) = (SELECT YEAR(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_KH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[TKnam_KH] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT K.TenKH, SUM(TONGTIEN) FROM KHACHHANG K, HOADON H 
	WHERE K.MaKH = H.MaKH AND YEAR(NgayThu) = (SELECT YEAR(@date))
	GROUP BY K.TenKH 
	HAVING SUM(TONGTIEN)>= ALL (SELECT (SUM(TONGTIEN)) FROM  KHACHHANG A, HOADON B 
	WHERE A.MaKH = B.MaKH AND YEAR(NgayThu) = (SELECT YEAR(@date))
	GROUP BY A.TenKH)
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_MonDT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_MonDT] 
( @date NVARCHAR(100))
AS
BEGIN
	SELECT M.TenMon
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn 
	JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC 
	WHERE  YEAR(NgayXuat) = (SELECT YEAR(@date))
	GROUP BY M.TenMon, M.DonGia, P.SoLuong 
	HAVING (M.DonGia *P.SoLuong) >= ALL (SELECT (M.DonGia *P.SoLuong) 
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 
	ON P.SoPYC = P2.SoPYC 
	WHERE  YEAR(NgayXuat) = (SELECT YEAR(@date)))
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_MonYT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_MonYT] 
( @date NVARCHAR(100))
AS
BEGIN
    select ma.TenMon 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and YEAR(p.NgayXuat) = (SELECT YEAR(@date))
	group by ma.TenMon having count(pyc.SoPYC) >= all(
	select count(pyc.SoPYC) 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and YEAR(p.NgayXuat) = (SELECT YEAR(@date))
	group by ma.TenMon)
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_NV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_NV] 
(@date NVARCHAR(100))
AS
BEGIN
	select nv.HoTen from NHANVIEN as nv, HOADON as hd  
	where (nv.MaNV = hd.MaNV and YEAR(hd.NgayThu) = (SELECT YEAR(@date)))
	group by nv.HoTen having (count(hd.MaHD)) >=  all (select count(hd.MaHD) 
	from NHANVIEN as nv, HOADON as hd where (nv.MaNV = hd.MaNV and YEAR(hd.NgayThu) = (SELECT YEAR(@date)))
	group by nv.HoTen)
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_SoHD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_SoHD] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(MaHD) SoLuotPX FROM HOADON 
	WHERE YEAR(NgayThu) = (SELECT YEAR(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_SoPN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_SoPN] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(SoPN) SoLuotPN FROM PHIEUNHAP 
	WHERE YEAR(NgayNhap) = (SELECT YEAR(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_SoPX]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_SoPX] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(SoPX) SoLuotPX FROM PHIEUXUAT 
	WHERE YEAR(NgayXuat) = (SELECT YEAR(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKnam_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKnam_THU] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE YEAR(NgayThu) = (SELECT YEAR(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TKngay_CHI] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE NgayNhap = @date 
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_KH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TKngay_KH] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT K.TenKH FROM KHACHHANG K, HOADON H 
	WHERE K.MaKH = H.MaKH AND NgayThu = @date
	GROUP BY K.TenKH 
	HAVING SUM(TONGTIEN)>= ALL (SELECT (SUM(TONGTIEN)) FROM  KHACHHANG A, HOADON B 
	WHERE A.MaKH = B.MaKH AND NgayThu = @date)
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_MonDT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKngay_MonDT] 
( @date NVARCHAR(100))
AS
BEGIN
	SELECT M.TenMon
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn 
	JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC 
	WHERE NgayXuat = @date
	GROUP BY M.TenMon, M.DonGia, P.SoLuong 
	HAVING (M.DonGia *P.SoLuong) >= ALL (SELECT (M.DonGia *P.SoLuong) 
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 
	ON P.SoPYC = P2.SoPYC 
	WHERE NgayXuat = @date)
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_MonYT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKngay_MonYT] 
( @date NVARCHAR(100))
AS
BEGIN
    select ma.TenMon 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and p.NgayXuat = @date
	group by ma.TenMon having count(pyc.SoPYC) >= all(
	select count(pyc.SoPYC) 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and p.NgayXuat = @date
	group by ma.TenMon)
END


GO
/****** Object:  StoredProcedure [dbo].[TKngay_NV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TKngay_NV] 
(@date NVARCHAR(100))
AS
BEGIN
	select nv.HoTen from NHANVIEN as nv, HOADON as hd  
	where (nv.MaNV = hd.MaNV and hd.NgayThu = @date)
	group by nv.HoTen having (count(hd.MaHD)) >=  all (select count(hd.MaHD) 
	from NHANVIEN as nv, HOADON as hd where (nv.MaNV = hd.MaNV and hd.NgayThu = @date)
	group by nv.HoTen)
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_SoHD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TKngay_SoHD] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(MaHD) SoLuotPX FROM HOADON 
	WHERE NgayThu = @date
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_SoPN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TKngay_SoPN] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(SoPN) SoLuotPN FROM PHIEUNHAP 
	WHERE NgayNhap = @date
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_SoPX]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TKngay_SoPX] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(SoPX) SoLuotPX FROM PHIEUXUAT 
	WHERE NgayXuat = @date
END
GO
/****** Object:  StoredProcedure [dbo].[TKngay_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TKngay_THU] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE NgayThu = @date
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_CHI]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_CHI] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT SUM(TongTien) FROM PHIEUNHAP 
	WHERE MONTH(NgayNhap) = (SELECT MONTH(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_KH]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_KH] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT K.TenKH, SUM(TONGTIEN) FROM KHACHHANG K, HOADON H 
	WHERE K.MaKH = H.MaKH AND MONTH(NgayThu) = 4--(SELECT MONTH(@date))
	GROUP BY K.TenKH 
	HAVING SUM(TONGTIEN)>= ALL (SELECT (SUM(TONGTIEN)) FROM  KHACHHANG A, HOADON B 
	WHERE A.MaKH = B.MaKH AND MONTH(NgayThu) = 4--(SELECT MONTH(@date))
	GROUP BY A.TenKH )
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_MonDT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_MonDT] 
( @date NVARCHAR(100))
AS
BEGIN
	SELECT M.TenMon
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn 
	JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC 
	WHERE  MONTH(NgayXuat) = (SELECT MONTH(@date))
	GROUP BY M.TenMon, M.DonGia, P.SoLuong 
	HAVING (M.DonGia *P.SoLuong) >= ALL (SELECT (M.DonGia *P.SoLuong) 
	FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 
	ON P.SoPYC = P2.SoPYC 
	WHERE  MONTH(NgayXuat) = (SELECT MONTH(@date)))
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_MonYT]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_MonYT] 
( @date NVARCHAR(100))
AS
BEGIN
    select ma.TenMon 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and MONTH(p.NgayXuat) = (SELECT MONTH(@date))
	group by ma.TenMon having count(pyc.SoPYC) >= all(
	select count(pyc.SoPYC) 
	from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p 
	where ma.MaMonAn = pyc.MaMonAn 
	and pyc.SoPYC = p.SoPYC 
	and MONTH(p.NgayXuat) = (SELECT MONTH(@date))
	group by ma.TenMon)
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_NV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_NV] 
(@date NVARCHAR(100))
AS
BEGIN
	select nv.HoTen from NHANVIEN as nv, HOADON as hd  
	where (nv.MaNV = hd.MaNV and MONTH(hd.NgayThu) = (SELECT MONTH(@date)))
	group by nv.HoTen having (count(hd.MaHD)) >=  all (select count(hd.MaHD) 
	from NHANVIEN as nv, HOADON as hd where (nv.MaNV = hd.MaNV and MONTH(hd.NgayThu) = (SELECT MONTH(@date)))
	group by nv.HoTen)
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_SoHD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_SoHD] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(MaHD) SoLuotPX FROM HOADON 
	WHERE MONTH(NgayThu) = (SELECT MONTH(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_SoPN]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_SoPN] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(SoPN) SoLuotPN FROM PHIEUNHAP 
	WHERE MONTH(NgayNhap) = (SELECT MONTH(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_SoPX]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_SoPX] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT COUNT(SoPX) SoLuotPX FROM PHIEUXUAT 
	WHERE MONTH(NgayXuat) = (SELECT MONTH(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[TKthang_THU]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TKthang_THU] 
(@date NVARCHAR(100))
AS
BEGIN
	SELECT SUM(TongTien) TongTien FROM HOADON
	WHERE MONTH(NgayThu) = (SELECT MONTH(@date))
END
GO
/****** Object:  StoredProcedure [dbo].[update_ban]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_ban](@spyc char(8))
as
begin
	declare @shb char(8)
	select @shb = sohieuban from PHIEUYEUCAU where SoPYC = @spyc
	Update Ban set TinhTrang = N'FULL' where SoHieuBan = @shb
end
GO
/****** Object:  StoredProcedure [dbo].[update_BanTrong]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_BanTrong](@SoHieuBan char(8))
As
Begin
Update BAN set TinhTrang='NONE' where @SoHieuBan = SoHieuBan
End
GO
/****** Object:  StoredProcedure [dbo].[update_HD]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[update_HD](@ma char(8),@ngay datetime,@tongTien bigint, @manv CHAR(8), @makh CHAR(8),@pyc char(8))
as
begin 
 update HOADON set soPYC=@pyc,ngayThu=@ngay,tongTien=@tongTien, MaNV = @manv, MaKH = @makh where maHD=@ma
end
GO
/****** Object:  StoredProcedure [dbo].[update_Kh]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_Kh](@maKH char(8), @hoten nvarchar(26), @sdt char(11), @dc nvarchar(100))
As 
Begin
Update KHACHHANG set TenKH = @hoten ,SoDienThoai=@sdt, diachi = @dc where MaKH = @maKH
end
GO
/****** Object:  StoredProcedure [dbo].[update_KH1]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[update_KH1](@ma char(8),@ten nvarchar(26),@sdt char(11),@dc nvarchar(100),@ngay datetime,@maMon char(8),@sl int,@gia bigint,@soBan char(8))
as
begin 
 declare @pyc char(8)
 select @pyc=soPYC from PHIEUYEUCAU where maKH=@ma
 update KHACHHANG set tenKH=@ten,soDienThoai=@sdt,diaChi=@dc where maKH=@ma
 update PHIEUYEUCAU set ngayGioYC=@ngay , sohieuban= @soBan where soPYC=@pyc
 update CHITIETPYC set maMonAn=@maMon,soLuong=@sl,donGia=@gia where soPYC=@pyc
end
GO
/****** Object:  StoredProcedure [dbo].[update_KM]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[update_KM](@ma char(8),@ten nvarchar(50),@han date,@muc char(8))
as
begin 
 update KHUYENMAI set tenKM=@ten,han=@han,mucGiam=@muc where maKM=@ma
end
GO
/****** Object:  StoredProcedure [dbo].[update_NV]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_NV](@manv char(8), @hoten nvarchar(26), @diaChi nvarchar(100), @soDienThoai char(11),@chucVu nvarchar(26))
As 
Begin
Update NHANVIEN set Hoten = @hoten , diachi = @diaChi,  SoDienThoai=@soDienThoai,ChucVu= @chucVu where MaNV = @manv
end
GO
/****** Object:  StoredProcedure [dbo].[update_PYC]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[update_PYC](@SoPYC char(8))
As
Begin
Update PHIEUYEUCAU set LOAI='1' where @SoPYC = SoPYC
End


GO
/****** Object:  StoredProcedure [dbo].[Xoa_MonAn]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Xoa_MonAn](@TenMon NVARCHAR(50), @DonGia bigint)
As
Begin
DELETE FROM MONAN WHERE TenMon=@TenMon AND @DonGia=DonGia
End
GO
/****** Object:  StoredProcedure [dbo].[XuatNguyenLieu_XuatNL]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[XuatNguyenLieu_XuatNL] 
(@sopx NVARCHAR(100),
@manl NVARCHAR(100),
@soluong NVARCHAR(100))
AS
BEGIN
	DECLARE  @sumsoluong int
	BEGIN
		SELECT @sumsoluong = NGUYENLIEU.SoLuong FROM NGUYENLIEU WHERE NGUYENLIEU.MaNL = @manl
	END

	SET @sumsoluong = @sumsoluong - @soluong

	IF @sumsoluong >= 0
	BEGIN
		BEGIN
		UPDATE NGUYENLIEU SET SoLuong = @sumsoluong WHERE MaNL = @manl
		END
		BEGIN
		INSERT INTO CHITIETXUAT VALUES (@manl, @sopx, @soluong, 0)
		END
	END
	
	ELSE 
	BEGIN
		PRINT N'ERROR'
	END
END
GO
/****** Object:  StoredProcedure [dbo].[XuatNguyenLieu_XuatPX]    Script Date: 06/06/2022 11:45:12 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[XuatNguyenLieu_XuatPX] 
(@sopx NVARCHAR(100),
@ngayxuat NVARCHAR(100),
@manv NVARCHAR(100))
AS
BEGIN
	INSERT INTO PHIEUXUAT 
	VALUES (@sopx, @ngayxuat, @manv)
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyNhaHang] SET  READ_WRITE 
GO
