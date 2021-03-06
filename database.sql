USE [master]
GO
/****** Object:  Database [QuanLyNhaHang]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[auto_MaHD]    Script Date: 08/06/2022 2:34:08 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[auto_MaHD]()
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
/****** Object:  UserDefinedFunction [dbo].[auto_maKH]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[AUTO_MaNV]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[AUTO_SoPYC]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[DemKhongDen]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[getInforCus]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[NV_sohoadon]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[NV_timkiem]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[SearchBill]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[SearchCus]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[SearchKM]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[SearchNV]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[SSdoanhthu]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[SSdoanhthuNam]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[SSdoanhthuNgay]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  UserDefinedFunction [dbo].[TimKiemKH]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[BAN]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[CHITIETNHAP]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[CHITIETPYC]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[CHITIETXUAT]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[HOADON]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[KHUYENMAI]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[LOAIMON]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[MONAN]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[NGUYENLIEU]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[NHACUNGCAP]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[PHIEUKM]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[PHIEUNHAP]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[PHIEUXUAT]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  Table [dbo].[PHIEUYEUCAU]    Script Date: 08/06/2022 2:34:08 CH ******/
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
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B1      ', N'D1      ', 6, N'FULL    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B10     ', N'D2      ', 8, N'FULL    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B2      ', N'D1      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B3      ', N'D1      ', 10, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B4      ', N'D2      ', 10, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B5      ', N'D2      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B6      ', N'D2      ', 6, N'NONE    ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B7      ', N'D3      ', 6, N'BOOKED  ')
INSERT [dbo].[BAN] ([SoHieuBan], [ViTri], [SoGhe], [TinhTrang]) VALUES (N'B8      ', N'D3      ', 6, N'FULL    ')
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
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0100  ', N'NL006   ', 43, 56000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0101  ', N'NL007   ', 52, 23000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0102  ', N'NL008   ', 27, 240000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0103  ', N'NL009   ', 75, 47000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0104  ', N'NL010   ', 32, 150000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0105  ', N'NL011   ', 24, 170000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0106  ', N'NL012   ', 23, 330000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0107  ', N'NL003   ', 15, 465000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0108  ', N'NL004   ', 33, 363000)
GO
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
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0131  ', N'NL001   ', 10, 200000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0132  ', N'NL002   ', 10, 180000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0133  ', N'NL003   ', 5, 300000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0134  ', N'NL004   ', 10, 250000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0135  ', N'NL005   ', 10, 100000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0136  ', N'NL006   ', 5, 10000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0137  ', N'NL007   ', 10, 10000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0138  ', N'NL001   ', 20, 250000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0138  ', N'NL003   ', 10, 300000)
INSERT [dbo].[CHITIETNHAP] ([SoPN], [MaNL], [SoLuong], [DonGia]) VALUES (N'PN0138  ', N'NL004   ', 20, 200000)
GO
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC001   ', N'BR001   ', 2, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC001   ', N'BR002   ', 3, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC002   ', N'NU002   ', 1, 10000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC003   ', N'BR002   ', 3, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC003   ', N'PZ003   ', 3, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC004   ', N'PZ001   ', 2, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC005   ', N'BR002   ', 4, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC006   ', N'BR001   ', 3, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC007   ', N'PZ001   ', 2, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC008   ', N'NU004   ', 9, 30000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC008   ', N'PZ002   ', 1, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC009   ', N'PZ002   ', 4, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC010   ', N'BR003   ', 3, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC011   ', N'BR003   ', 6, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC012   ', N'BR002   ', 5, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC013   ', N'BR001   ', 7, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC014   ', N'BR003   ', 4, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC015   ', N'PZ002   ', 5, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC016   ', N'BR002   ', 3, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC017   ', N'PZ003   ', 4, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC018   ', N'BR001   ', 5, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC019   ', N'BR003   ', 9, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC020   ', N'PZ003   ', 5, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC021   ', N'BR002   ', 11, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC022   ', N'PZ003   ', 5, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC023   ', N'PZ002   ', 4, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC024   ', N'BR001   ', 5, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC025   ', N'BR002   ', 3, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC026   ', N'PZ002   ', 4, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC027   ', N'BR003   ', 5, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC028   ', N'PZ002   ', 6, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC029   ', N'PZ001   ', 5, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC030   ', N'BR001   ', 4, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC031   ', N'PZ002   ', 5, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC032   ', N'NU003   ', 5, 15000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC032   ', N'PZ003   ', 5, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC033   ', N'BR003   ', 8, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC034   ', N'BR002   ', 6, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC035   ', N'PZ002   ', 9, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC036   ', N'BR002   ', 4, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC037   ', N'BR001   ', 5, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC038   ', N'PZ002   ', 7, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC039   ', N'BR001   ', 6, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC040   ', N'PZ003   ', 6, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC041   ', N'BR002   ', 9, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC042   ', N'PZ003   ', 5, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC043   ', N'BR001   ', 6, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC044   ', N'PZ001   ', 4, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC045   ', N'BR001   ', 5, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC046   ', N'BR003   ', 7, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC047   ', N'PZ001   ', 6, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC048   ', N'PZ002   ', 7, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC049   ', N'NU001   ', 8, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC050   ', N'BR002   ', 5, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC051   ', N'PZ003   ', 5, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC052   ', N'BR003   ', 12, 45000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC053   ', N'PZ002   ', 3, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC054   ', N'NU003   ', 8, 15000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC055   ', N'BR003   ', 5, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC056   ', N'BR002   ', 6, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC057   ', N'PZ001   ', 10, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC058   ', N'PZ003   ', 6, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC060   ', N'BR001   ', 2, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC060   ', N'BR003   ', 2, 110000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC061   ', N'BR003   ', 1, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC062   ', N'BR001   ', 2, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC062   ', N'NU001   ', 2, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC063   ', N'BR001   ', 10, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC064   ', N'BR001   ', 1, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC064   ', N'BR003   ', 5, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC064   ', N'NU002   ', 1, 10000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC064   ', N'NU003   ', 1, 15000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC065   ', N'PZ001   ', 2, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC066   ', N'PZ001   ', 2, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC066   ', N'PZ002   ', 1, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC067   ', N'NU004   ', 1, 30000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC067   ', N'PZ001   ', 1, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC067   ', N'PZ002   ', 1, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC068   ', N'NU004   ', 1, 30000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC068   ', N'PZ001   ', 1, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC068   ', N'PZ002   ', 0, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC069   ', N'BR001   ', 2, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC069   ', N'BR002   ', 2, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC069   ', N'NU001   ', 4, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC070   ', N'NU001   ', 2, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC070   ', N'NU003   ', 1, 15000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC070   ', N'PZ001   ', 1, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC071   ', N'PZ003   ', 1, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC072   ', N'PZ003   ', 2, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC073   ', N'PZ001   ', 10, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC073   ', N'PZ002   ', 10, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC073   ', N'PZ003   ', 10, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC074   ', N'BR001   ', 2, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC074   ', N'NU001   ', 1, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC074   ', N'NU002   ', 1, 10000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC075   ', N'BR002   ', 2, 70000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC075   ', N'BR003   ', 1, 55000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC075   ', N'NU001   ', 2, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC075   ', N'NU002   ', 1, 10000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC076   ', N'BR002   ', 1, 70000)
GO
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC076   ', N'NU001   ', 2, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC076   ', N'PZ003   ', 1, 360000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC077   ', N'NU004   ', 1, 30000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC077   ', N'PZ002   ', 1, 300000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC078   ', N'NU001   ', 2, 20000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC078   ', N'PZ001   ', 1, 350000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC079   ', N'BR001   ', 7, 65000)
INSERT [dbo].[CHITIETPYC] ([SoPYC], [MaMonAn], [SoLuong], [DonGia]) VALUES (N'YC079   ', N'BR002   ', 7, 70000)
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
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL008   ', N'PX0107  ', 17, 0)
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
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0022  ', 12, 350000)
GO
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0032  ', 15, 340000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0042  ', 16, 370000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0052  ', 23, 376000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0062  ', 22, 375000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0084  ', 26, 377000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0094  ', 23, 373000)
INSERT [dbo].[CHITIETXUAT] ([MaNL], [SoPX], [SoLuong], [DonGia]) VALUES (N'NL012   ', N'PX0104  ', 27, 374000)
GO
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD001   ', CAST(N'2022-02-06' AS Date), 1234000, N'NV003   ', N'KH001   ', N'YC001   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD002   ', CAST(N'2022-02-06' AS Date), 1234000, N'NV004   ', N'KH001   ', N'YC002   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD003   ', CAST(N'2022-02-06' AS Date), 123400, N'NV009   ', N'KH002   ', N'YC003   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD004   ', CAST(N'2022-02-06' AS Date), 1234000, N'NV009   ', N'KH003   ', N'YC004   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD005   ', CAST(N'2022-02-07' AS Date), 1234000, N'NV012   ', N'KH004   ', N'YC005   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD006   ', CAST(N'2022-02-10' AS Date), 1234000, N'NV013   ', N'KH005   ', N'YC006   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD007   ', CAST(N'2022-02-13' AS Date), 1234000, N'NV003   ', N'KH005   ', N'YC007   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD008   ', CAST(N'2022-02-18' AS Date), 1234000, N'NV004   ', N'KH006   ', N'YC008   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD009   ', CAST(N'2022-02-19' AS Date), 1234000, N'NV008   ', N'KH007   ', N'YC009   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD010   ', CAST(N'2022-02-19' AS Date), 1234000, N'NV009   ', N'KH008   ', N'YC010   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD011   ', CAST(N'2022-02-20' AS Date), 1234000, N'NV012   ', N'KH009   ', N'YC011   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD012   ', CAST(N'2022-02-21' AS Date), 1234000, N'NV013   ', N'KH010   ', N'YC012   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD013   ', CAST(N'2022-02-25' AS Date), 1234000, N'NV003   ', N'KH011   ', N'YC013   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD014   ', CAST(N'2022-02-27' AS Date), 1234000, N'NV004   ', N'KH012   ', N'YC014   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD015   ', CAST(N'2022-02-28' AS Date), 1234000, N'NV008   ', N'KH002   ', N'YC015   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD016   ', CAST(N'2022-02-28' AS Date), 1234000, N'NV009   ', N'KH013   ', N'YC016   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD017   ', CAST(N'2022-03-01' AS Date), 1234000, N'NV012   ', N'KH014   ', N'YC017   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD018   ', CAST(N'2022-03-02' AS Date), 1234000, N'NV013   ', N'KH015   ', N'YC018   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD019   ', CAST(N'2022-03-03' AS Date), 1234000, N'NV003   ', N'KH010   ', N'YC019   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD020   ', CAST(N'2022-03-04' AS Date), 1234000, N'NV004   ', N'KH012   ', N'YC020   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD021   ', CAST(N'2022-03-04' AS Date), 1234000, N'NV003   ', N'KH018   ', N'YC021   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD022   ', CAST(N'2022-03-05' AS Date), 1234000, N'NV004   ', N'KH004   ', N'YC022   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD023   ', CAST(N'2022-03-06' AS Date), 1234000, N'NV008   ', N'KH008   ', N'YC023   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD024   ', CAST(N'2022-03-11' AS Date), 1234000, N'NV009   ', N'KH020   ', N'YC024   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD025   ', CAST(N'2022-03-15' AS Date), 1234000, N'NV012   ', N'KH021   ', N'YC025   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD026   ', CAST(N'2022-03-15' AS Date), 1234000, N'NV013   ', N'KH022   ', N'YC026   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD027   ', CAST(N'2022-03-16' AS Date), 1234000, N'NV003   ', N'KH023   ', N'YC027   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD028   ', CAST(N'2022-03-19' AS Date), 1234000, N'NV004   ', N'KH024   ', N'YC028   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD029   ', CAST(N'2022-03-19' AS Date), 1234000, N'NV008   ', N'KH025   ', N'YC029   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD030   ', CAST(N'2022-03-20' AS Date), 1234000, N'NV009   ', N'KH026   ', N'YC030   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD031   ', CAST(N'2022-03-28' AS Date), 1234000, N'NV012   ', N'KH027   ', N'YC031   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD032   ', CAST(N'2022-03-29' AS Date), 1234000, N'NV013   ', N'KH028   ', N'YC032   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD033   ', CAST(N'2022-03-30' AS Date), 1234000, N'NV003   ', N'KH016   ', N'YC033   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD034   ', CAST(N'2022-03-30' AS Date), 1234000, N'NV004   ', N'KH017   ', N'YC034   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD035   ', CAST(N'2022-04-02' AS Date), 1234000, N'NV008   ', N'KH029   ', N'YC035   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD036   ', CAST(N'2022-04-05' AS Date), 1234000, N'NV009   ', N'KH030   ', N'YC036   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD037   ', CAST(N'2022-04-06' AS Date), 1234000, N'NV012   ', N'KH031   ', N'YC037   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD038   ', CAST(N'2022-04-07' AS Date), 1234000, N'NV013   ', N'KH004   ', N'YC038   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD039   ', CAST(N'2022-04-09' AS Date), 1234000, N'NV003   ', N'KH032   ', N'YC039   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD040   ', CAST(N'2022-04-09' AS Date), 1234000, N'NV004   ', N'KH033   ', N'YC040   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD041   ', CAST(N'2022-04-09' AS Date), 1234000, N'NV003   ', N'KH034   ', N'YC041   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD042   ', CAST(N'2022-04-10' AS Date), 1234000, N'NV004   ', N'KH017   ', N'YC042   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD043   ', CAST(N'2022-04-12' AS Date), 1234000, N'NV008   ', N'KH035   ', N'YC043   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD044   ', CAST(N'2022-04-13' AS Date), 1234000, N'NV009   ', N'KH036   ', N'YC044   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD045   ', CAST(N'2022-04-14' AS Date), 1234000, N'NV012   ', N'KH037   ', N'YC045   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD046   ', CAST(N'2022-04-15' AS Date), 1234000, N'NV013   ', N'KH038   ', N'YC046   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD047   ', CAST(N'2022-04-16' AS Date), 1234000, N'NV003   ', N'KH039   ', N'YC047   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD048   ', CAST(N'2022-04-17' AS Date), 1234000, N'NV004   ', N'KH009   ', N'YC048   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD049   ', CAST(N'2022-04-18' AS Date), 1234000, N'NV008   ', N'KH040   ', N'YC049   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD050   ', CAST(N'2022-04-21' AS Date), 1234000, N'NV009   ', N'KH041   ', N'YC050   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD051   ', CAST(N'2022-04-22' AS Date), 1234000, N'NV012   ', N'KH042   ', N'YC051   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD052   ', CAST(N'2022-04-23' AS Date), 1234000, N'NV013   ', N'KH043   ', N'YC052   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD053   ', CAST(N'2022-04-25' AS Date), 1234000, N'NV003   ', N'KH044   ', N'YC053   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD054   ', CAST(N'2022-04-26' AS Date), 1234000, N'NV004   ', N'KH045   ', N'YC054   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD055   ', CAST(N'2022-04-28' AS Date), 1234000, N'NV008   ', N'KH046   ', N'YC055   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD056   ', CAST(N'2022-04-29' AS Date), 1234000, N'NV009   ', N'KH047   ', N'YC056   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD057   ', CAST(N'2022-04-29' AS Date), 1234000, N'NV012   ', N'KH048   ', N'YC057   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD058   ', CAST(N'2022-04-25' AS Date), 335000, N'NV013   ', N'KH049   ', N'YC058   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD059   ', CAST(N'2022-04-19' AS Date), 545000, N'NV012   ', N'KH050   ', N'YC059   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD060   ', CAST(N'2022-04-25' AS Date), 1300000, N'NV012   ', N'KH040   ', N'YC059   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD061   ', CAST(N'2022-06-06' AS Date), 51700, N'NV013   ', N'KH054   ', N'YC061   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD062   ', CAST(N'2022-06-07' AS Date), 159800, N'NV001   ', N'KH051   ', N'YC062   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD063   ', CAST(N'2022-06-07' AS Date), 630500, N'NV001   ', N'KH054   ', N'YC063   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD064   ', CAST(N'2022-06-06' AS Date), 339450, N'NV001   ', N'KH054   ', N'YC064   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD065   ', CAST(N'2022-06-05' AS Date), 644000, N'NV001   ', N'KH054   ', N'YC065   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD066   ', CAST(N'2022-06-04' AS Date), 632400, N'NV001   ', N'KH054   ', N'YC067   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD067   ', CAST(N'2022-06-03' AS Date), 323000, N'NV002   ', N'KH054   ', N'YC068   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD068   ', CAST(N'2022-06-03' AS Date), 322000, N'NV003   ', N'KH054   ', N'YC069   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD069   ', CAST(N'2022-06-03' AS Date), 368550, N'NV002   ', N'KH054   ', N'YC070   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD070   ', CAST(N'2022-06-02' AS Date), 349200, N'NV001   ', N'KH054   ', N'YC071   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD071   ', CAST(N'2022-06-01' AS Date), 612000, N'NV001   ', N'KH054   ', N'YC072   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD072   ', CAST(N'2022-05-18' AS Date), 9797000, N'NV003   ', N'KH054   ', N'YC073   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD073   ', CAST(N'2022-06-07' AS Date), 160000, N'NV008   ', N'KH045   ', N'YC074   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD074   ', CAST(N'2022-06-07' AS Date), 230300, N'NV008   ', N'KH055   ', N'YC075   ')
INSERT [dbo].[HOADON] ([MaHD], [NgayThu], [TongTien], [MaNV], [MaKH], [SoPYC]) VALUES (N'HD075   ', CAST(N'2022-06-07' AS Date), 470000, N'NV009   ', N'KH056   ', N'YC076   ')
GO
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH001   ', N'Nguyễn Ngọc Anh', N'0345551232 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH002   ', N'Trần Văn Nam', N'0949145902 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH003   ', N'Trương Thanh Hà', N'0293847713 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH004   ', N'Hoàng Thành Nam', N'0949876234 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH005   ', N'Trần Văn Quyết', N'0898534762 ', N'Hoàng Mai, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH006   ', N'Đỗ Hồng Ngọc', N'0989347269 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH007   ', N'Trương Thị La', N'0983674326 ', N'Pleiku, Gia Lai')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH008   ', N'Trần Văn Minh', N'0898592762 ', N'Hoàng Mai, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH009   ', N'Trương Thảo Nhi', N'0980468209 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH010   ', N'Hoàng Mỹ Linh', N'0987234678 ', N'Hai Bà Trưng, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH011   ', N'Đỗ Hoàng Hải', N'0347861290 ', N'Hòa An, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH012   ', N'Trần Ngọc Anh', N'0298675238 ', N'Phủ Lý, Hà Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH013   ', N'Đỗ Phan Lâm', N'0983762847 ', N'Đức Cơ, Gia Lai')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH014   ', N'Nguyễn Thảo Ngân', N'0983678935 ', N'Thạch An, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH015   ', N'Nguyễn Thanh Phong ', N'0967482657 ', N'Thanh Ba, Phú Thọ')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH016   ', N'Trịnh Thúy Quỳnh', N'0347892971 ', N'Nam Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH017   ', N'Đậu Thị Lan', N'0987654363 ', N'Thanh Xuân, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH018   ', N'Hồ Thị Dung', N'0983746252 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH019   ', N'Chu Thị Huyền', N'0936251725 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH020   ', N'Đào Hồng Vy', N'0897863948 ', N'Ba Vì, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH021   ', N'An Thanh Tú', N'0983737383 ', N'Bắc Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH022   ', N'Nguyễn Tùng Lâm', N'0944478976 ', N'Lâm Thao, Phú Thọ')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH023   ', N'Trần Duy Mạnh', N'0388978465 ', N'Ba Đình, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH024   ', N'Đỗ Phan Long', N'0898776543 ', N'Hoàng Mai, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH025   ', N'Phạm Đình Khương Duy', N'0354689726 ', N'Đô Lương, Nghệ An')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH026   ', N'Hoàng Đình Huy', N'0984763523 ', N'Thanh Sơn, Phú Thọ')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH027   ', N'Trương Anh Duy', N'0987363524 ', N'Kim Bảng, Hà Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH028   ', N'Hoàng Văn Thao', N'0983535678 ', N'Lục Ngạn, Bắc Giang')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH029   ', N'Nông Thị Trang', N'0367489065 ', N'Bảo Lạc, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH030   ', N'Trần Thị Tới', N'0987653546 ', N'Tiên Lữ, Hưng Yên')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH031   ', N'Hồ Nguyễn Ngọc', N'0463738292 ', N'Thạch An, Cao Bằng')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH032   ', N'Trần Văn Quân', N'0367826265 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH033   ', N'Phan Thanh Lam', N'0786869535 ', N'Đống Đa, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH034   ', N'Đinh Thị Mai', N'0989046475 ', N'Hai Bà Trưng, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH035   ', N'Lê Thị Linh Chi', N'0987467584 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH036   ', N'Nguyễn Ngọc Hoài', N'0983736283 ', N'Nam Từ Liêm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH037   ', N'Hoàng Văn Biên', N'0467352936 ', N'Hoàn Kiếm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH038   ', N'Lê Phúc Hưng', N'0987936352 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH039   ', N'Hoàng Lin Phương', N'0983636475 ', N'Đống Đa, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH040   ', N'Trịnh Văn Tú', N'0987476758 ', N'Ba Đình, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH041   ', N'Mai Ngọc Sơn', N'0238746351 ', N'Long Biên, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH042   ', N'Bế Quốc Khánh', N'0983647352 ', N'Cầu Giấy, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH043   ', N'Đinh Xuân Hải', N'0473826563 ', N'Ba Vì, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH044   ', N'Hoàng Xuân Nam', N'0987463821 ', N'Việt Yên, Bắc Giang')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH045   ', N'Đỗ Lê Huy', N'0347879765 ', N'Thanh Xuân, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH046   ', N'Đào Việt Hà', N'0989373625 ', N'Hai Bà Trưng, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH047   ', N'Dương Huy Hoàng', N'0893838472 ', N'Hà Đông, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH048   ', N'Lưu Đình Kiệt', N'0345678293 ', N'Hoàn Kiếm, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH049   ', N'Phan Văn Đức', N'0938372648 ', N'Ba Đình, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH050   ', N'Bùi Duy Hoàng', N'0364758391 ', N'Hòa Lạc, Hà Nội')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH051   ', N'Ðào Hà', N'0942700021 ', N'Ðô Lương, Nghệ An')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH052   ', N'Ðào Giáp', N'0345123678 ', N'Huong Khê, Thanh Hóa')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH053   ', NULL, NULL, NULL)
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH054   ', N'Hà Công Quốc Bảo', N'123456789  ', N'Nông Cống, Thanh Hóa')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH055   ', N'Trịnh Thị Thanh', N'0789456123 ', N'Thanh Chương, Nghệ An')
INSERT [dbo].[KHACHHANG] ([MaKH], [TenKH], [SoDienThoai], [DiaChi]) VALUES (N'KH056   ', N'Lưu Đình Kiệt', N'0147258369 ', N'Đồng Xoài, Bình Phước')
GO
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0105  ', N'Quốc tế lao động', CAST(N'2022-07-10' AS Date), N'7       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0106  ', N'Quốc tế thiếu nhi', CAST(N'2022-06-10' AS Date), N'6       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0209  ', N'Quốc khánh', CAST(N'2022-09-03' AS Date), N'15      ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM0302  ', N'Thành lập Đảng', CAST(N'2022-06-30' AS Date), N'8       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM1003  ', N'Giỗ tổ', CAST(N'2022-06-11' AS Date), N'7       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM123   ', N'KMHM', CAST(N'2022-06-25' AS Date), N'3       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM1402  ', N'Lễ tình nhân', CAST(N'2022-06-15' AS Date), N'5       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM2003  ', N'Quốc tế hạnh phúc', CAST(N'2022-10-20' AS Date), N'5       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM2022  ', N'Tết', CAST(N'2022-08-06' AS Date), N'9       ')
INSERT [dbo].[KHUYENMAI] ([MaKM], [TenKM], [Han], [MucGiam]) VALUES (N'KM2511  ', N'Black Friday', CAST(N'2022-11-25' AS Date), N'9       ')
GO
INSERT [dbo].[LOAIMON] ([MaLM], [TenLM]) VALUES (N'BR      ', N'Burger')
INSERT [dbo].[LOAIMON] ([MaLM], [TenLM]) VALUES (N'NU      ', N'Nuoc')
INSERT [dbo].[LOAIMON] ([MaLM], [TenLM]) VALUES (N'PZ      ', N'Pizza')
GO
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'BR001   ', N'Burger Bò', 65000, N'VND', N'BR      ', N'D:\food\beef-burger.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'BR002   ', N'Burger Cá hồi', 70000, N'VND', N'BR      ', N'D:\food\burger-ca-hoi.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'BR003   ', N'Burger Thịt viên', 55000, N'VND', N'BR      ', N'D:\food\burger-ga.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU001   ', N'Pepsi', 20000, N'VND', N'NU      ', N'D:\food\pepsi.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU002   ', N'Nước suối', 10000, N'VND', N'NU      ', N'D:\food\dasani.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU003   ', N'Trà đen', 15000, N'VND', N'NU      ', N'D:\food\cheden.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'NU004   ', N'Nước cam', 30000, N'VND', N'NU      ', N'D:\food\cam.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'PZ001   ', N'Pizza Tôm', 350000, N'VND', N'PZ      ', N'D:\food\pizza tom.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'PZ002   ', N'Pizza Rau củ', 300000, N'VND', N'PZ      ', N'D:\food\banh-pizza-chay-600x375.jpg')
INSERT [dbo].[MONAN] ([MaMonAn], [TenMon], [DonGia], [DVT], [MaLM], [pathimage]) VALUES (N'PZ003   ', N'Pizza Phô mai', 360000, N'VND', N'PZ      ', N'D:\food\Pizza-phô-mai.jpg')
GO
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL001   ', 130, N'Thịt bò', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL002   ', 60, N'Thịt lợn', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL003   ', 65, N'Cá hồi', N'Con')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL004   ', 80, N'Tôm', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL005   ', 45, N'Phomai', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL006   ', 95, N'Dứa', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL007   ', 110, N'Xà lách', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL008   ', 3, N'Nấm', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL009   ', 200, N'Bột mì', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL010   ', 10, N'Sốt cà chua', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL011   ', 60, N'Olive', N'Kg')
INSERT [dbo].[NGUYENLIEU] ([MaNL], [SoLuong], [TenNL], [DonVi]) VALUES (N'NL012   ', 20, N'Mực', N'Kg')
GO
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC01   ', N'0283947239 ', 79070000, N'Gia Lâm, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC02   ', N'0365473950 ', 64960000, N'Thạch Thất, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC03   ', N'0362937495 ', 80880000, N'Long Biên, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC04   ', N'0325444666 ', 69750000, N'Hà Đông, Hà Nội')
INSERT [dbo].[NHACUNGCAP] ([MaNCC], [SoDienThoai], [TongTien], [DiaChi]) VALUES (N'NCC05   ', N'0245385022 ', 72860000, N'Cầu Giấy, Hà Nội')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV001   ', N'Hà Công Quốc Bảo', CAST(N'2001-08-15' AS Date), N'Nam     ', N'Bắc Từ Liêm, Hà Nội', N'0936772839 ', N'Administrator', 20000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV002   ', N'Đào Việt Hà', CAST(N'2001-03-18' AS Date), N'Nu      ', N'Đô Lương, Nghệ An', N'0942700012 ', N'Warehouse Manager', 10000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV003   ', N'Nguyễn Phan Như Quỳnh', CAST(N'2001-08-11' AS Date), N'Nu      ', N'Pleiku, Gia Lai', N'0846231674 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV004   ', N'Nông Phương Trang', CAST(N'2001-02-06' AS Date), N'Nu      ', N'Sông Hiến, Cao Bằng', N'0846696888 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV005   ', N'Đỗ Đức Mạnh', CAST(N'2003-04-13' AS Date), N'Nam     ', N'Cầu Giấy, Hà Nội', N'0342859683 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV006   ', N'Phương Khánh Dũng', CAST(N'2000-01-04' AS Date), N'Nam     ', N'Hai Bà Trưng, Hà Nội', N'0348293472 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV007   ', N'Lý Minh Anh', CAST(N'2002-05-23' AS Date), N'Nam     ', N'Yên Thành, Nghệ An', N'0938774652 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV008   ', N'Phùng Khánh Linh', CAST(N'2003-02-16' AS Date), N'Nu      ', N'Hoằng Hóa, Thanh Hóa', N'0243573899 ', N'Cashier', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV009   ', N'Khổng Thanh Trà', CAST(N'2002-07-24' AS Date), N'Nu      ', N'Phổ Yên, Thái Nguyên', N'0452664859 ', N'Cashier', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV010   ', N'Tô Diệu Linh', CAST(N'2000-12-23' AS Date), N'Nu      ', N'Cầu Giấy, Hà Nội', N'0327492642 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV011   ', N'Thạch Huệ Anh', CAST(N'2001-11-23' AS Date), N'Nu      ', N'Vĩnh Yên, Vĩnh Phúc', N'0127384682 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV012   ', N'Lâm Minh Thu', CAST(N'2001-10-23' AS Date), N'Nu      ', N'Cầu Giấy, Hà Nội', N'0192475930 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV013   ', N'Thẩm Thu Trà', CAST(N'2001-10-05' AS Date), N'Nu      ', N'Long Biên, Hà Nội', N'0128465823 ', N'Cashier', 7000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SoDienThoai], [ChucVu], [Luong], [matkhau]) VALUES (N'NV014   ', N'Lý Thảo My', CAST(N'2001-05-30' AS Date), N'Nu      ', N'Hoàn Kiếm, Hà Nội', N'0482940240 ', N'Warehouse Staff', 5000000, N'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb')
GO
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM0105  ', N'YC058   ', 2)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM0105  ', N'YC059   ', 2)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1003  ', N'YC039   ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1003  ', N'YC041   ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1003  ', N'YC042   ', 2)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM1402  ', N'YC007   ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2003  ', N'YC028   ', 2)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2003  ', N'YC029   ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2003  ', N'YC030   ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2022  ', N'YC001   ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2022  ', N'YC002   ', 1)
INSERT [dbo].[PHIEUKM] ([MaKM], [SoPYC], [SoLuong]) VALUES (N'KM2022  ', N'YC004   ', 1)
GO
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0001  ', CAST(N'2022-02-06' AS Date), 2000000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0002  ', CAST(N'2022-02-06' AS Date), 5000000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0003  ', CAST(N'2022-02-06' AS Date), 3620000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0004  ', CAST(N'2022-02-06' AS Date), 1500000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0005  ', CAST(N'2022-02-07' AS Date), 1000000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0006  ', CAST(N'2022-02-07' AS Date), 2100000, N'NV014   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0007  ', CAST(N'2022-02-07' AS Date), 4350000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0008  ', CAST(N'2022-02-07' AS Date), 3240000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0009  ', CAST(N'2022-02-08' AS Date), 1340000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0010  ', CAST(N'2022-02-08' AS Date), 2340000, N'NV014   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0011  ', CAST(N'2022-02-08' AS Date), 1440000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0012  ', CAST(N'2022-02-08' AS Date), 4350000, N'NV014   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0013  ', CAST(N'2022-02-09' AS Date), 2420000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0014  ', CAST(N'2022-02-09' AS Date), 2450000, N'NV010   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0015  ', CAST(N'2022-02-09' AS Date), 3510000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0016  ', CAST(N'2022-02-10' AS Date), 2450000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0017  ', CAST(N'2022-02-10' AS Date), 1350000, N'NV014   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0018  ', CAST(N'2022-02-10' AS Date), 1240000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0019  ', CAST(N'2022-02-10' AS Date), 5420000, N'NV014   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0020  ', CAST(N'2022-02-12' AS Date), 2450000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0021  ', CAST(N'2022-02-12' AS Date), 2340000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0022  ', CAST(N'2022-02-12' AS Date), 2110000, N'NV005   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0023  ', CAST(N'2022-02-12' AS Date), 2140000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0024  ', CAST(N'2022-02-13' AS Date), 1240000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0025  ', CAST(N'2022-02-13' AS Date), 5340000, N'NV014   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0026  ', CAST(N'2022-02-13' AS Date), 2520000, N'NV014   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0027  ', CAST(N'2022-02-13' AS Date), 2510000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0028  ', CAST(N'2022-02-14' AS Date), 3560000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0029  ', CAST(N'2022-02-15' AS Date), 1250000, N'NV010   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0030  ', CAST(N'2022-02-15' AS Date), 2520000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0031  ', CAST(N'2022-02-15' AS Date), 1440000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0032  ', CAST(N'2022-02-16' AS Date), 4350000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0033  ', CAST(N'2022-02-17' AS Date), 1340000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0034  ', CAST(N'2022-02-17' AS Date), 2450000, N'NV014   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0035  ', CAST(N'2022-02-17' AS Date), 3140000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0036  ', CAST(N'2022-02-17' AS Date), 2450000, N'NV010   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0037  ', CAST(N'2022-02-18' AS Date), 2450000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0038  ', CAST(N'2022-02-19' AS Date), 1240000, N'NV005   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0039  ', CAST(N'2022-02-19' AS Date), 5420000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0040  ', CAST(N'2022-02-15' AS Date), 2340000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0041  ', CAST(N'2022-02-19' AS Date), 2340000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0042  ', CAST(N'2022-02-19' AS Date), 2110000, N'NV005   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0043  ', CAST(N'2022-02-20' AS Date), 2240000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0044  ', CAST(N'2022-02-20' AS Date), 1240000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0045  ', CAST(N'2022-02-20' AS Date), 5340000, N'NV014   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0046  ', CAST(N'2022-02-21' AS Date), 1340000, N'NV014   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0047  ', CAST(N'2022-02-22' AS Date), 2530000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0048  ', CAST(N'2022-02-22' AS Date), 3560000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0049  ', CAST(N'2022-02-22' AS Date), 1250000, N'NV010   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0050  ', CAST(N'2022-02-19' AS Date), 2450000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0051  ', CAST(N'2022-02-23' AS Date), 1440000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0052  ', CAST(N'2022-02-23' AS Date), 4350000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0053  ', CAST(N'2022-02-24' AS Date), 1340000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0054  ', CAST(N'2022-02-24' AS Date), 2450000, N'NV014   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0055  ', CAST(N'2022-02-24' AS Date), 3140000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0056  ', CAST(N'2022-02-24' AS Date), 2450000, N'NV010   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0057  ', CAST(N'2022-02-24' AS Date), 3520000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0058  ', CAST(N'2022-02-25' AS Date), 2560000, N'NV005   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0059  ', CAST(N'2022-02-26' AS Date), 5420000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0060  ', CAST(N'2022-02-23' AS Date), 2340000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0061  ', CAST(N'2022-02-27' AS Date), 5310000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0062  ', CAST(N'2022-02-27' AS Date), 2110000, N'NV005   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0063  ', CAST(N'2022-02-28' AS Date), 2240000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0064  ', CAST(N'2022-02-28' AS Date), 1530000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0065  ', CAST(N'2022-03-01' AS Date), 3560000, N'NV014   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0066  ', CAST(N'2022-03-01' AS Date), 1340000, N'NV014   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0067  ', CAST(N'2022-03-02' AS Date), 2510000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0068  ', CAST(N'2022-03-02' AS Date), 3560000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0069  ', CAST(N'2022-03-02' AS Date), 3230000, N'NV010   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0070  ', CAST(N'2022-02-27' AS Date), 2450000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0071  ', CAST(N'2022-03-03' AS Date), 1440000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0072  ', CAST(N'2022-03-03' AS Date), 4350000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0073  ', CAST(N'2022-03-04' AS Date), 1340000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0074  ', CAST(N'2022-03-04' AS Date), 2450000, N'NV014   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0075  ', CAST(N'2022-03-05' AS Date), 3140000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0076  ', CAST(N'2022-03-06' AS Date), 2450000, N'NV010   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0077  ', CAST(N'2022-03-08' AS Date), 3520000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0078  ', CAST(N'2022-03-09' AS Date), 2560000, N'NV005   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0079  ', CAST(N'2022-03-09' AS Date), 5420000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0080  ', CAST(N'2022-03-03' AS Date), 2340000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0081  ', CAST(N'2022-03-09' AS Date), 5310000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0082  ', CAST(N'2022-03-09' AS Date), 2110000, N'NV005   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0083  ', CAST(N'2022-03-13' AS Date), 2240000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0084  ', CAST(N'2022-03-15' AS Date), 1530000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0085  ', CAST(N'2022-03-15' AS Date), 3560000, N'NV014   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0086  ', CAST(N'2022-03-15' AS Date), 1340000, N'NV014   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0087  ', CAST(N'2022-03-16' AS Date), 2510000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0088  ', CAST(N'2022-03-17' AS Date), 3560000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0089  ', CAST(N'2022-03-20' AS Date), 3230000, N'NV010   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0090  ', CAST(N'2022-03-09' AS Date), 2450000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0091  ', CAST(N'2022-03-20' AS Date), 2430000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0092  ', CAST(N'2022-03-23' AS Date), 4350000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0093  ', CAST(N'2022-03-24' AS Date), 2310000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0094  ', CAST(N'2022-03-24' AS Date), 2450000, N'NV014   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0095  ', CAST(N'2022-03-25' AS Date), 4350000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0096  ', CAST(N'2022-03-26' AS Date), 3530000, N'NV010   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0097  ', CAST(N'2022-03-28' AS Date), 3520000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0098  ', CAST(N'2022-03-29' AS Date), 2340000, N'NV005   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0099  ', CAST(N'2022-03-29' AS Date), 5420000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0100  ', CAST(N'2022-03-20' AS Date), 2340000, N'NV010   ', N'NCC01   ')
GO
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0101  ', CAST(N'2022-03-29' AS Date), 5310000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0102  ', CAST(N'2022-03-29' AS Date), 2110000, N'NV005   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0103  ', CAST(N'2022-03-30' AS Date), 3420000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0104  ', CAST(N'2022-04-02' AS Date), 1530000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0105  ', CAST(N'2022-04-02' AS Date), 2440000, N'NV014   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0106  ', CAST(N'2022-04-02' AS Date), 1340000, N'NV014   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0107  ', CAST(N'2022-04-02' AS Date), 4230000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0108  ', CAST(N'2022-04-03' AS Date), 3560000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0109  ', CAST(N'2022-04-03' AS Date), 2420000, N'NV010   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0110  ', CAST(N'2022-03-29' AS Date), 2450000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0111  ', CAST(N'2022-04-04' AS Date), 2430000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0112  ', CAST(N'2022-04-04' AS Date), 4350000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0113  ', CAST(N'2022-04-04' AS Date), 2310000, N'NV014   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0114  ', CAST(N'2022-04-04' AS Date), 2450000, N'NV014   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0115  ', CAST(N'2022-04-05' AS Date), 4350000, N'NV005   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0116  ', CAST(N'2022-04-06' AS Date), 3530000, N'NV010   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0117  ', CAST(N'2022-04-06' AS Date), 3520000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0118  ', CAST(N'2022-04-07' AS Date), 2340000, N'NV005   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0119  ', CAST(N'2022-04-08' AS Date), 5420000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0120  ', CAST(N'2022-04-04' AS Date), 2340000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0121  ', CAST(N'2022-04-09' AS Date), 5310000, N'NV005   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0122  ', CAST(N'2022-04-09' AS Date), 2110000, N'NV005   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0123  ', CAST(N'2022-04-10' AS Date), 3420000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0124  ', CAST(N'2022-04-11' AS Date), 1530000, N'NV005   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0125  ', CAST(N'2022-04-12' AS Date), 2440000, N'NV014   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0126  ', CAST(N'2022-04-12' AS Date), 1340000, N'NV014   ', N'NCC02   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0127  ', CAST(N'2022-04-12' AS Date), 4230000, N'NV010   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0128  ', CAST(N'2022-04-12' AS Date), 3560000, N'NV010   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0129  ', CAST(N'2022-04-12' AS Date), 2420000, N'NV010   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0130  ', CAST(N'2022-04-09' AS Date), 2450000, N'NV010   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0131  ', CAST(N'2022-06-01' AS Date), 2000000, N'NV001   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0132  ', CAST(N'2022-06-02' AS Date), 1800000, N'NV001   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0133  ', CAST(N'2022-06-03' AS Date), 1500000, N'NV001   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0134  ', CAST(N'2022-06-04' AS Date), 2500000, N'NV001   ', N'NCC01   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0135  ', CAST(N'2022-06-05' AS Date), 1000000, N'NV001   ', N'NCC05   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0136  ', CAST(N'2022-06-06' AS Date), 50000, N'NV001   ', N'NCC04   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0137  ', CAST(N'2022-06-07' AS Date), 100000, N'NV001   ', N'NCC03   ')
INSERT [dbo].[PHIEUNHAP] ([SoPN], [NgayNhap], [TongTien], [MaNV], [MaNCC]) VALUES (N'PN0138  ', CAST(N'2022-05-07' AS Date), 12000000, N'NV002   ', N'NCC01   ')
GO
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0001  ', CAST(N'2022-02-07' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0002  ', CAST(N'2022-02-07' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0003  ', CAST(N'2022-02-08' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0004  ', CAST(N'2022-02-08' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0005  ', CAST(N'2022-02-08' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0006  ', CAST(N'2022-02-09' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0007  ', CAST(N'2022-02-09' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0008  ', CAST(N'2022-02-09' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0009  ', CAST(N'2022-02-09' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0010  ', CAST(N'2022-02-09' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0011  ', CAST(N'2022-02-10' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0012  ', CAST(N'2022-02-11' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0013  ', CAST(N'2022-02-11' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0014  ', CAST(N'2022-02-11' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0015  ', CAST(N'2022-02-13' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0016  ', CAST(N'2022-02-14' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0017  ', CAST(N'2022-02-14' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0018  ', CAST(N'2022-02-14' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0019  ', CAST(N'2022-02-14' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0020  ', CAST(N'2022-02-15' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0021  ', CAST(N'2022-02-17' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0022  ', CAST(N'2022-02-17' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0023  ', CAST(N'2022-02-18' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0024  ', CAST(N'2022-02-18' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0025  ', CAST(N'2022-02-18' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0026  ', CAST(N'2022-02-19' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0027  ', CAST(N'2022-02-20' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0028  ', CAST(N'2022-02-20' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0029  ', CAST(N'2022-02-22' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0030  ', CAST(N'2022-02-22' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0031  ', CAST(N'2022-02-23' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0032  ', CAST(N'2022-02-24' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0033  ', CAST(N'2022-02-24' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0034  ', CAST(N'2022-02-24' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0035  ', CAST(N'2022-02-25' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0036  ', CAST(N'2022-02-25' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0037  ', CAST(N'2022-02-26' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0038  ', CAST(N'2022-02-26' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0039  ', CAST(N'2022-02-28' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0040  ', CAST(N'2022-02-28' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0041  ', CAST(N'2022-03-02' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0042  ', CAST(N'2022-03-02' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0043  ', CAST(N'2022-03-03' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0044  ', CAST(N'2022-03-04' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0045  ', CAST(N'2022-03-05' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0046  ', CAST(N'2022-03-09' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0047  ', CAST(N'2022-03-10' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0048  ', CAST(N'2022-03-10' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0049  ', CAST(N'2022-03-12' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0050  ', CAST(N'2022-03-12' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0051  ', CAST(N'2022-03-13' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0052  ', CAST(N'2022-03-14' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0053  ', CAST(N'2022-03-14' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0054  ', CAST(N'2022-03-14' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0055  ', CAST(N'2022-03-15' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0056  ', CAST(N'2022-03-15' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0057  ', CAST(N'2022-03-16' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0058  ', CAST(N'2022-03-16' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0059  ', CAST(N'2022-03-17' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0060  ', CAST(N'2022-03-17' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0061  ', CAST(N'2022-03-18' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0062  ', CAST(N'2022-03-18' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0063  ', CAST(N'2022-03-19' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0064  ', CAST(N'2022-03-20' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0065  ', CAST(N'2022-03-21' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0066  ', CAST(N'2022-03-21' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0067  ', CAST(N'2022-03-21' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0068  ', CAST(N'2022-03-22' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0069  ', CAST(N'2022-03-22' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0070  ', CAST(N'2022-03-12' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0071  ', CAST(N'2022-03-23' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0072  ', CAST(N'2022-03-24' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0073  ', CAST(N'2022-03-24' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0074  ', CAST(N'2022-03-25' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0075  ', CAST(N'2022-03-25' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0076  ', CAST(N'2022-03-26' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0077  ', CAST(N'2022-03-27' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0078  ', CAST(N'2022-03-28' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0079  ', CAST(N'2022-03-28' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0080  ', CAST(N'2022-03-30' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0081  ', CAST(N'2022-03-30' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0082  ', CAST(N'2022-03-30' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0083  ', CAST(N'2022-04-01' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0084  ', CAST(N'2022-04-01' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0085  ', CAST(N'2022-04-02' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0086  ', CAST(N'2022-04-03' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0087  ', CAST(N'2022-04-03' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0088  ', CAST(N'2022-04-04' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0089  ', CAST(N'2022-04-04' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0090  ', CAST(N'2022-04-05' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0091  ', CAST(N'2022-04-05' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0092  ', CAST(N'2022-04-06' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0093  ', CAST(N'2022-04-07' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0094  ', CAST(N'2022-04-07' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0095  ', CAST(N'2022-04-07' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0096  ', CAST(N'2022-04-07' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0097  ', CAST(N'2022-04-09' AS Date), N'NV007   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0098  ', CAST(N'2022-04-09' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0099  ', CAST(N'2022-04-10' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0100  ', CAST(N'2022-04-10' AS Date), N'NV007   ')
GO
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0101  ', CAST(N'2022-04-11' AS Date), N'NV010   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0102  ', CAST(N'2022-04-11' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0103  ', CAST(N'2022-04-11' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0104  ', CAST(N'2022-04-12' AS Date), N'NV011   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0105  ', CAST(N'2022-04-12' AS Date), N'NV005   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0106  ', CAST(N'2022-04-12' AS Date), N'NV006   ')
INSERT [dbo].[PHIEUXUAT] ([SoPX], [NgayXuat], [MaNV]) VALUES (N'PX0107  ', CAST(N'2022-06-07' AS Date), N'NV010   ')
GO
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC001   ', CAST(N'2022-02-06' AS Date), N'07:45:12            ', N'1                   ', N'KH001   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC002   ', CAST(N'2022-02-06' AS Date), N'08:15:14            ', N'1                   ', N'KH001   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC003   ', CAST(N'2022-02-06' AS Date), N'08:18:25            ', N'1                   ', N'KH002   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC004   ', CAST(N'2022-02-06' AS Date), N'09:05:39            ', N'1                   ', N'KH003   ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC005   ', CAST(N'2022-02-07' AS Date), N'09:30:32            ', N'1                   ', N'KH004   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC006   ', CAST(N'2022-02-10' AS Date), N'09:55:19            ', N'1                   ', N'KH005   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC007   ', CAST(N'2022-02-13' AS Date), N'10:20:17            ', N'1                   ', N'KH005   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC008   ', CAST(N'2022-02-18' AS Date), N'11:15:28            ', N'1                   ', N'KH006   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC009   ', CAST(N'2022-02-19' AS Date), N'12:00:12            ', N'1                   ', N'KH007   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC010   ', CAST(N'2022-02-19' AS Date), N'12:53:09            ', N'1                   ', N'KH008   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC011   ', CAST(N'2022-02-20' AS Date), N'14:07:17            ', N'1                   ', N'KH009   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC012   ', CAST(N'2022-02-21' AS Date), N'15:07:20            ', N'1                   ', N'KH010   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC013   ', CAST(N'2022-02-25' AS Date), N'17:03:92            ', N'1                   ', N'KH011   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC014   ', CAST(N'2022-02-27' AS Date), N'08:30:00            ', N'1                   ', N'KH012   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC015   ', CAST(N'2022-02-28' AS Date), N'09:40:12            ', N'1                   ', N'KH002   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC016   ', CAST(N'2022-02-28' AS Date), N'10:20:17            ', N'1                   ', N'KH013   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC017   ', CAST(N'2022-03-01' AS Date), N'08:13:42            ', N'1                   ', N'KH014   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC018   ', CAST(N'2022-03-02' AS Date), N'08:02:10            ', N'1                   ', N'KH015   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC019   ', CAST(N'2022-03-03' AS Date), N'09:15:23            ', N'1                   ', N'KH010   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC020   ', CAST(N'2022-03-04' AS Date), N'07:43:23            ', N'1                   ', N'KH012   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC021   ', CAST(N'2022-03-04' AS Date), N'10:12:15            ', N'1                   ', N'KH018   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC022   ', CAST(N'2022-03-05' AS Date), N'14:15:20            ', N'1                   ', N'KH004   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC023   ', CAST(N'2022-03-06' AS Date), N'09:12:09            ', N'1                   ', N'KH008   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC024   ', CAST(N'2022-03-11' AS Date), N'12:05:10            ', N'1                   ', N'KH020   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC025   ', CAST(N'2022-03-15' AS Date), N'14:03:26            ', N'1                   ', N'KH021   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC026   ', CAST(N'2022-03-15' AS Date), N'18:23:12            ', N'1                   ', N'KH022   ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC027   ', CAST(N'2022-03-16' AS Date), N'08:16:18            ', N'1                   ', N'KH023   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC028   ', CAST(N'2022-03-19' AS Date), N'07:12:05            ', N'1                   ', N'KH024   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC029   ', CAST(N'2022-03-19' AS Date), N'08:11:21            ', N'1                   ', N'KH025   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC030   ', CAST(N'2022-03-20' AS Date), N'07:14:39            ', N'1                   ', N'KH026   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC031   ', CAST(N'2022-03-28' AS Date), N'08:12:34            ', N'1                   ', N'KH027   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC032   ', CAST(N'2022-03-29' AS Date), N'08:00:16            ', N'1                   ', N'KH028   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC033   ', CAST(N'2022-03-30' AS Date), N'08:00:15            ', N'1                   ', N'KH016   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC034   ', CAST(N'2022-03-30' AS Date), N'09:04:35            ', N'1                   ', N'KH017   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC035   ', CAST(N'2022-04-02' AS Date), N'07:02:11            ', N'1                   ', N'KH029   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC036   ', CAST(N'2022-04-05' AS Date), N'07:06:18            ', N'1                   ', N'KH030   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC037   ', CAST(N'2022-04-06' AS Date), N'08:06:30            ', N'1                   ', N'KH031   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC038   ', CAST(N'2022-04-07' AS Date), N'07:45:12            ', N'1                   ', N'KH004   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC039   ', CAST(N'2022-04-09' AS Date), N'08:15:20            ', N'1                   ', N'KH032   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC040   ', CAST(N'2022-04-09' AS Date), N'10:14:30            ', N'1                   ', N'KH033   ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC041   ', CAST(N'2022-04-09' AS Date), N'12:13:16            ', N'1                   ', N'KH034   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC042   ', CAST(N'2022-04-10' AS Date), N'14:15:30            ', N'1                   ', N'KH017   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC043   ', CAST(N'2022-04-12' AS Date), N'16:23:65            ', N'1                   ', N'KH035   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC044   ', CAST(N'2022-04-13' AS Date), N'08:12:32            ', N'1                   ', N'KH036   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC045   ', CAST(N'2022-04-14' AS Date), N'09:14:24            ', N'1                   ', N'KH037   ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC046   ', CAST(N'2022-04-15' AS Date), N'12:45:28            ', N'1                   ', N'KH038   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC047   ', CAST(N'2022-04-16' AS Date), N'08:17:11            ', N'1                   ', N'KH039   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC048   ', CAST(N'2022-04-17' AS Date), N'09:00:10            ', N'1                   ', N'KH009   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC049   ', CAST(N'2022-04-18' AS Date), N'09:10:14            ', N'1                   ', N'KH040   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC050   ', CAST(N'2022-04-21' AS Date), N'10:15:14            ', N'1                   ', N'KH041   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC051   ', CAST(N'2022-04-22' AS Date), N'11:15:23            ', N'1                   ', N'KH042   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC052   ', CAST(N'2022-04-23' AS Date), N'12:11:34            ', N'1                   ', N'KH043   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC053   ', CAST(N'2022-04-25' AS Date), N'13:34:23            ', N'1                   ', N'KH044   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC054   ', CAST(N'2022-04-26' AS Date), N'14:05:43            ', N'1                   ', N'KH045   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC055   ', CAST(N'2022-04-28' AS Date), N'15:13:35            ', N'1                   ', N'KH046   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC056   ', CAST(N'2022-04-29' AS Date), N'07:55:14            ', N'1                   ', N'KH047   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC057   ', CAST(N'2022-04-29' AS Date), N'08:15:39            ', N'1                   ', N'KH048   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC058   ', CAST(N'2022-04-30' AS Date), N'09:19:29            ', N'1                   ', N'KH049   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC059   ', CAST(N'2022-05-01' AS Date), N'07:45:33            ', N'1                   ', N'KH050   ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC060   ', CAST(N'2022-06-06' AS Date), N'21:52:17.4430956    ', N'1                   ', N'KH051   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC061   ', CAST(N'2022-06-06' AS Date), N'23:32:25.3205603    ', N'1                   ', N'KH054   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC062   ', CAST(N'2022-06-06' AS Date), N'23:38:20.3646050    ', N'1                   ', N'KH051   ', N'B6      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC063   ', CAST(N'2022-06-07' AS Date), N'08:06:29.2862112    ', N'1                   ', N'KH054   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC064   ', CAST(N'2022-06-07' AS Date), N'08:08:08.1568687    ', N'1                   ', N'KH054   ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC065   ', CAST(N'2022-06-07' AS Date), N'08:10:05.0823564    ', N'1                   ', N'KH054   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC066   ', CAST(N'2022-06-07' AS Date), N'08:10:15.2880377    ', N'1                   ', N'KH054   ', N'B3      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC067   ', CAST(N'2022-06-07' AS Date), N'08:10:33.5015969    ', N'1                   ', N'KH054   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC068   ', CAST(N'2022-06-07' AS Date), N'08:11:06.3583030    ', N'1                   ', N'KH054   ', N'B5      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC069   ', CAST(N'2022-06-07' AS Date), N'08:14:10.3549483    ', N'1                   ', N'KH054   ', N'B7      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC070   ', CAST(N'2022-06-07' AS Date), N'08:16:25.0008517    ', N'1                   ', N'KH054   ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC071   ', CAST(N'2022-06-07' AS Date), N'08:21:58.4027495    ', N'1                   ', N'KH054   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC072   ', CAST(N'2022-06-07' AS Date), N'08:22:10.9296342    ', N'1                   ', N'KH054   ', N'B10     ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC073   ', CAST(N'2022-06-07' AS Date), N'08:34:55.5222629    ', N'1                   ', N'KH054   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC074   ', CAST(N'2022-06-07' AS Date), N'11:26:05.3598632    ', N'1                   ', N'KH045   ', N'B9      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC075   ', CAST(N'2022-06-07' AS Date), N'11:52:48.6351247    ', N'1                   ', N'KH055   ', N'B4      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC076   ', CAST(N'2022-06-07' AS Date), N'11:54:47.6555542    ', N'1                   ', N'KH056   ', N'B2      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC077   ', CAST(N'2022-06-07' AS Date), N'11:56:53.2711756    ', N'2                   ', N'KH051   ', N'B8      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC078   ', CAST(N'2022-06-07' AS Date), N'12:03:37.3032407    ', N'2                   ', N'KH041   ', N'B1      ')
INSERT [dbo].[PHIEUYEUCAU] ([SoPYC], [NgayXuat], [NgayGioYC], [LOAI], [MaKH], [SoHieuBan]) VALUES (N'YC079   ', CAST(N'2022-06-07' AS Date), N'14:00:23.8382674    ', N'2                   ', N'KH054   ', N'B10     ')
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
/****** Object:  StoredProcedure [dbo].[add_CTPyc]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[Add_HD]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[add_KH]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[add_KM]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[add_NV]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[add_Pyc]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BanAn_Load]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDNam]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDNam_Chi]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDNam_Thu]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDNgay_Chi]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDNgay_Thu]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDThang]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDThang_Chi]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[BDThang_Thu]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[book_table]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[Cancel_ban]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietNhap_ChinhSua]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietNhap_Load]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietNhap_Xoa]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietXuat_ChinhSua]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietXuat_Load]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ChiTietXuat_Xoa]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[delete_KH]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[delete_KM]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[delete_NV]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[DemPYC]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_dataTable]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_MaMonAn]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_MucGiam]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_preMoney]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_preTT]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_Pyc2]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_Shb]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[get_Status]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[IN_HOA_DON]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[KMofcustomer]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[MonAn_Load]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[MonAn_TimKiem]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NCC_max]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_ItSD]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_Load]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_MoiNhap]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_SapHet]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_ThuongXuyen]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_TimKiem]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_TonKho]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[NguyenLieu_VuaXuat]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[PhieuNhap_Load]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[PhieuNhap_TimKiem]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[PhieuXuat_Load]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[PhieuXuat_TimKiem]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[proc_xemKH]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[SearchFood]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[Them_HD]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ThemNguyenLieu_ThemNL]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[ThemNguyenLieu_ThemPN]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐnam_CHI]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐnam_THU]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐnam1_CHI]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐnam1_THU]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐngay_CHI]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐngay_THU]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐngay1_CHI]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐngay1_THU]    Script Date: 08/06/2022 2:34:08 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐthang_CHI]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐthang_THU]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐthang1_CHI]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKBĐthang1_THU]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_CHI]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_KH]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_MonDT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_MonYT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_NV]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_SoHD]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_SoPN]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_SoPX]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKchon_THU]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_CHI]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_KH]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_MonDT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_MonYT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_NV]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_SoHD]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_SoPN]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_SoPX]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKnam_THU]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_CHI]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_KH]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_MonDT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_MonYT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_NV]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_SoHD]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_SoPN]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_SoPX]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKngay_THU]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_CHI]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_KH]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_MonDT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_MonYT]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_NV]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_SoHD]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_SoPN]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_SoPX]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[TKthang_THU]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_ban]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_BanTrong]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_HD]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_Kh]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_KH1]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_KM]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_NV]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[update_PYC]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[Xoa_MonAn]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[XuatNguyenLieu_XuatNL]    Script Date: 08/06/2022 2:34:09 CH ******/
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
/****** Object:  StoredProcedure [dbo].[XuatNguyenLieu_XuatPX]    Script Date: 08/06/2022 2:34:09 CH ******/
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
