using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt.Warehouse
{
    public partial class NguyenLieu : UserControl
    {
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        public NguyenLieu()
        {
            InitializeComponent();
        }

        private void NhapNguyenLieu_Click(object sender, EventArgs e)
        {
            FormPhieuNhap form = new FormPhieuNhap();
            form.ShowDialog();
        }

        private void XuatNguyenLieu_Click(object sender, EventArgs e)
        {
            FormPhieuXuat form = new FormPhieuXuat();
            form.ShowDialog();
        }

        private void connect()
        {
            sqlCon.Open();
            string query = "NguyenLieu_Load";
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvNguyenLieu.DataSource = dtb;
            dtgvNguyenLieu.AutoGenerateColumns = false;
            dtgvNguyenLieu.AllowUserToAddRows = false;
            dtgvNguyenLieu.AutoResizeColumns();
            sqlCon.Close();
        }

        private void connect(string query)
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvNguyenLieu.DataSource = dtb;
            dtgvNguyenLieu.AutoGenerateColumns = false;
            dtgvNguyenLieu.AllowUserToAddRows = false;
            dtgvNguyenLieu.AutoResizeColumns();
            sqlCon.Close();
        }

        private void NguyenLieu_Load(object sender, EventArgs e)
        {
            connect();
        }

        private void TimKiem_Click(object sender, EventArgs e)
        {
            if (txtMaNL.Text == string.Empty && txtTenNL.Text == string.Empty)
            {
                connect();
            }
            else
            {
                //string query = "SELECT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' FROM NGUYENLIEU WHERE MaNL = N'" + txtMaNL.Text + "' OR TenNL = N'" + txtTenNL.Text + "'";
                string query = "NguyenLieu_TimKiem N'" + txtMaNL.Text + "', N'" + txtTenNL.Text + "'";
                connect(query);
            }
        }

        private void NLThuongXuyen_Click(object sender, EventArgs e)
        {

            //string query = "SELECT DISTINCT NGUYENLIEU.MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', NGUYENLIEU.SoLuong as 'Số lượng', DonVi as 'Đơn vị' FROM CHITIETNHAP, NGUYENLIEU WHERE CHITIETNHAP.MaNL = NGUYENLIEU.MaNL GROUP BY NGUYENLIEU.MaNL, NGUYENLIEU.TenNL, NGUYENLIEU.TenNL, NGUYENLIEU.SoLuong, NGUYENLIEU.DonVi HAVING COUNT(CHITIETNHAP.SoPN) > = ALL(SELECT COUNT(CHITIETNHAP.SoPN) FROM CHITIETNHAP, NGUYENLIEU WHERE CHITIETNHAP.MaNL = NGUYENLIEU.MaNL GROUP BY NGUYENLIEU.MaNL)";
            string query = "NguyenLieu_ThuongXuyen";
            connect(query);
        }

        private void NLSapHet_Click(object sender, EventArgs e)
        {
            //string query = "SELECT DISTINCT MaNL as 'Mã nguyên liệu', TenNL as 'Tên nguyên liệu', SoLuong as 'Số lượng', DonVi as 'Đơn vị' FROM NGUYENLIEU WHERE SoLuong <= 2";
            string query = "NguyenLieu_SapHet";
            connect(query);
        }

        private void NLVuaXuat_Click(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;
            DateTime dt = Convert.ToDateTime(date.AddDays(-3));
            //string query = "SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' FROM NGUYENLIEU AS NL, PHIEUXUAT AS PX, CHITIETXUAT AS CTX WHERE NL.MaNL = CTX.MaNL AND CTX.SoPX = PX.SoPX AND PX.NgayXuat >= '";
            string query = "NguyenLieu_VuaXuat '";
            connect(query + dt.ToString("yyyy-MM-dd") + "'");
        }

        private void NLMoiNhap_Click(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;
            DateTime dt = Convert.ToDateTime(date.AddDays(-3));
            //string query = "SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' FROM NGUYENLIEU AS NL, PHIEUNHAP AS PN, CHITIETNHAP AS CTN WHERE NL.MaNL = CTN.MaNL AND CTN.SoPN = PN.SoPN AND PN.NgayNhap >= '";
            string query = "NguyenLieu_MoiNhap '";
            connect(query + dt.ToString("yyyy-MM-dd") + "'");
        }

        private void btItSD_Click(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;
            DateTime dt = Convert.ToDateTime(date.AddDays(-7));
            //string query = "SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' FROM NGUYENLIEU AS NL, PHIEUXUAT AS PX, CHITIETXUAT AS CTX WHERE NL.MaNL = CTX.MaNL AND CTX.SoPX = PX.SoPX AND PX.NgayXuat <= '";
            string query = "NguyenLieu_ItSD '";
            connect(query + dt.ToString("yyyy-MM-dd") + "'");
        }

        private void btTonKho_Click(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;
            DateTime dt = Convert.ToDateTime(date.AddDays(-7));
            //string query = "SELECT DISTINCT NL.MaNL as 'Mã nguyên liệu', NL.TenNL as 'Tên nguyên liệu', NL.SoLuong as 'Số lượng', NL.DonVi as 'Đơn vị' FROM NGUYENLIEU AS NL, PHIEUNHAP AS PN, CHITIETNHAP AS CTN WHERE NL.MaNL = CTN.MaNL AND CTN.SoPN = PN.SoPN AND PN.NgayNhap <= '";
            string query = "NguyenLieu_TonKho '";
            connect(query + dt.ToString("yyyy-MM-dd") + "'");
        }

        private void btThemNL_Click(object sender, EventArgs e)
        {
            NguyenLieuMoi nguyenLieuMoi =  new NguyenLieuMoi();
            nguyenLieuMoi.Show();
        }
    }
}
