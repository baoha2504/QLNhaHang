# QLNhaHang

push code 15h 26/5/2022

Sử dụng cơ sở dữ liệu database.sql để có thể chạy được chương trình
Chương trình và cơ sở dữ liệu thiết kế nằm trong ổ D:\
clone về ổ D:\ để sử dụng

một số proc cần có ở csdl

CREATE PROC [dbo].[NguyenLieu_Load]
AS
BEGIN
    SELECT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' 
	FROM NGUYENLIEU
END GO

CREATE PROC [dbo].[NguyenLieu_TimKiem] (@manl NVARCHAR(100), @tennl NVARCHAR(100))
AS
BEGIN
    SELECT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' 
	FROM NGUYENLIEU 
	WHERE MaNL = @manl 
	OR TenNL =@tennl
END GO

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
END GO

CREATE PROC [dbo].[NguyenLieu_SapHet] 
AS
BEGIN
    SELECT DISTINCT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' 
	FROM NGUYENLIEU 
	WHERE SoLuong <= 3
END GO

CREATE PROC [dbo].[NguyenLieu_VuaXuat] (@ngayxuat DATE)
AS
BEGIN
    SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUXUAT AS PX, CHITIETXUAT AS CTX 
	WHERE NL.MaNL = CTX.MaNL AND CTX.SoPX = PX.SoPX AND PX.NgayXuat >= @ngayxuat
END GO

CREATE PROC [dbo].[NguyenLieu_MoiNhap] (@ngaynhap NVARCHAR(20))
AS
BEGIN
    SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUNHAP AS PN, CHITIETNHAP AS CTN 
	WHERE NL.MaNL = CTN.MaNL AND CTN.SoPN = PN.SoPN AND PN.NgayNhap >= @ngaynhap
END
GO 

CREATE PROC [dbo].[NguyenLieu_ItSD] (@ngaysd NVARCHAR(20))
AS
BEGIN
    SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUXUAT AS PX, CHITIETXUAT AS CTX 
	WHERE NL.MaNL = CTX.MaNL AND CTX.SoPX = PX.SoPX AND PX.NgayXuat <= @ngaysd
END GO

CREATE PROC [dbo].[NguyenLieu_TonKho] (@ngaysd NVARCHAR(20))
AS
BEGIN
    SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' 
	FROM NGUYENLIEU AS NL, PHIEUNHAP AS PN, CHITIETNHAP AS CTN 
	WHERE NL.MaNL = CTN.MaNL AND CTN.SoPN = PN.SoPN AND PN.NgayNhap <= @ngaysd
END GO

CREATE PROC [dbo].[PhieuNhap_Load] 
AS
BEGIN
    SELECT SoPN as 'Số phiếu nhập', NgayNhap as 'Ngày nhập', TongTien as 'Tổng tiền', MaNV as 'Mã nhân viên', MaNCC as 'Nhà cung cấp' 
	FROM PHIEUNHAP
END GO




