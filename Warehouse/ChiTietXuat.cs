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
using Microsoft.Reporting.WinForms;

namespace QLnhahang_anhttt.Warehouse
{
    public partial class ChiTietXuat : Form
    {
        public ChiTietXuat()
        {
            InitializeComponent();
        }
        public string soPX;
        public string ngayXuat;
        public string maNV;
        public string hoTen;

        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        private void connect(string query)
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvInChiTietXuat.DataSource = dtb;
            dtgvInChiTietXuat.AutoGenerateColumns = false;
            dtgvInChiTietXuat.AllowUserToAddRows = false;
            dtgvInChiTietXuat.AutoResizeColumns();
            sqlCon.Close();
        }

        private void CapNhat(string query)
        {
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand(query + soPX + "'", sqlCon);
            cmd.ExecuteNonQuery();
            sqlCon.Close();
        }
        private void btIn_Click(object sender, EventArgs e)
        {
            InPhieuXuat inPhieuXuat = new InPhieuXuat();
            inPhieuXuat.sopx = soPX;
            inPhieuXuat.ShowDialog();
        }

        private void ChiTietXuat_Load(object sender, EventArgs e)
        {
            txtSPX.Text = soPX;
            txtNgayXuat.Text = ngayXuat;
            txtMaNV.Text = maNV;
            txtHoTen.Text = hoTen;
            string query = "SELECT NGUYENLIEU.MaNL AS N'Mã nguyên liệu', TenNL AS N'Tên nguyên liệu', CHITIETXUAT.SoLuong AS N'Số lượng', DonGia AS N'Đơn giá' FROM NGUYENLIEU, CHITIETXUAT WHERE NGUYENLIEU.MaNL = CHITIETXUAT.MaNL AND CHITIETXUAT.SoPX = '";
            connect(query + soPX + "'");
        }

        private void btChinhSua_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime dateEdit = Convert.ToDateTime(ngayXuat);
                string query = "UPDATE PHIEUXUAT SET SoPX = '" + txtSPX.Text + "', NgayXuat = '" + dateEdit.ToString("yyyy-MM-dd") + "', MaNV = '" + txtMaNV.Text + "' WHERE soPX = '";
                CapNhat(query);
                MessageBox.Show("Bạn đã chỉnh sửa thành công phiếu xuất", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Chỉnh sửa không thành công", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void txtXoa_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Bạn có thục sự muốn xóa phiếu nhập?", "Thông báo", MessageBoxButtons.OKCancel) == System.Windows.Forms.DialogResult.OK)
            {
                string query = "DELETE FROM CHITIETXUAT WHERE SoPX = '";
                CapNhat(query);
                query = "DELETE FROM PHIEUXUAT WHERE SoPX = '";
                CapNhat(query);
                MessageBox.Show("Xóa thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtSPX.Text = string.Empty;
                txtMaNV.Text = string.Empty;
                txtNgayXuat.Text = string.Empty;
                txtHoTen.Text = string.Empty;
            }
        }
    }
}
