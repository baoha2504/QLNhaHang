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
    public partial class FormPhieuNhap : Form
    {
        public FormPhieuNhap()
        {
            InitializeComponent();
        }
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        private void connect()
        {
            sqlCon.Open();
            string query = "SELECT SoPN as 'Số phiếu nhập', NgayNhap as 'Ngày nhập', TongTien as 'Tổng tiền', MaNV as 'Mã nhân viên', MaNCC as 'Nhà cung cấp' FROM PHIEUNHAP";
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvPhieuNhap.DataSource = dtb;
            dtgvPhieuNhap.AutoGenerateColumns = false;
            dtgvPhieuNhap.AllowUserToAddRows = false;
            dtgvPhieuNhap.AutoResizeColumns();
            sqlCon.Close();
        }

        private void guna2Button2_Click(object sender, EventArgs e)
        {
            ChiTietNhap chiTietNhap = new ChiTietNhap();
            chiTietNhap.ShowDialog();
        }

        private void guna2Button3_Click(object sender, EventArgs e)
        {
            ThemPhieuNhap them = new ThemPhieuNhap();
            them.ShowDialog();
        }

        private void FormPhieuNhap_Load(object sender, EventArgs e)
        {
            connect();
        }
    }
}
