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
    public partial class FormPhieuXuat : Form
    {
        public FormPhieuXuat()
        {
            InitializeComponent();
        }
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        private void connect()
        {
            sqlCon.Open();
            string query = "SELECT SoPX as 'Số phiếu nhập', NgayXuat as 'Ngày nhập', PHIEUXUAT.MaNV as 'Mã nhân viên',NHANVIEN.HoTen as 'Tên nhân viên' FROM PHIEUXUAT, NHANVIEN WHERE PHIEUXUAT.MaNV = NHANVIEN.MaNV";
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvPhieuXuat.DataSource = dtb;
            dtgvPhieuXuat.AutoGenerateColumns = false;
            dtgvPhieuXuat.AllowUserToAddRows = false;
            dtgvPhieuXuat.AutoResizeColumns();
            sqlCon.Close();
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            ChiTietXuat chiTietXuat = new ChiTietXuat();
            chiTietXuat.ShowDialog();
        }

        private void guna2Button2_Click(object sender, EventArgs e)
        {
            ThemPhieuXuat themPhieuXuat = new ThemPhieuXuat();
            themPhieuXuat.ShowDialog();
        }

        private void FormPhieuXuat_Load(object sender, EventArgs e)
        {
            connect();
        }
    }
}
