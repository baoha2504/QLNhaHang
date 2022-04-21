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
    public partial class ChiTietNhap : Form
    {
        public string soPN;
        public string ngayNhap;
        public string tongTien;
        public string nhanVien;
        public string nhaCC;
        public ChiTietNhap()
        {
            InitializeComponent();
        }

        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        private void connect(string query)
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvChiTietInPhieuNhap.DataSource = dtb;
            dtgvChiTietInPhieuNhap.AutoGenerateColumns = false;
            dtgvChiTietInPhieuNhap.AllowUserToAddRows = false;
            dtgvChiTietInPhieuNhap.AutoResizeColumns();
            sqlCon.Close();
        }

        private void btInPhieuNhap_Click(object sender, EventArgs e)
        {
            InPhieuNhap inPhieuNhap = new InPhieuNhap();
            inPhieuNhap.ShowDialog();
        }

        private void ChiTietNhap_Load(object sender, EventArgs e)
        {
            txtPhieuNhap.Text = soPN;
            txtNgayNhap.Text = ngayNhap;
            txtTongTien.Text = tongTien;
            txtNhanVien.Text = nhanVien;
            txtNCC.Text = nhaCC;
            string query = "SELECT NL.MaNL AS N'Mã nguyên liệu', NL.TenNL AS N'Tên nguyên liệu', NL.SoLuong AS N'Số lượng', NL.DonVi AS N'Đơn vị', CTN.DonGia AS N'Đơn giá' FROM CHITIETNHAP AS CTN, NGUYENLIEU AS NL WHERE CTN.MaNL = NL.MaNL AND CTN.SoPN = '";
            connect(query + soPN + "'");
        }

        private void btChinhSua_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                DateTime dateEdit = Convert.ToDateTime(ngayNhap);
                string query = "UPDATE PHIEUNHAP SET SoPN = '" + txtPhieuNhap.Text + "', NgayNhap = '" + dateEdit.ToString("yyyy-MM-dd") + "', TongTien = " + txtTongTien.Text + ", MaNV = '" + txtNhanVien.Text + "', MaNCC = '" + txtNCC.Text + "' WHERE soPN = '";
                //connect(query + soPN + "'");
                SqlCommand cmd = new SqlCommand(query + soPN + "'", sqlCon);
                cmd.ExecuteNonQuery();
                sqlCon.Close();
                MessageBox.Show("Bạn đã chỉnh sửa thành công phiếu nhập", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            } catch (Exception ex)
            {
                MessageBox.Show("Chỉnh sửa không thành công", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
