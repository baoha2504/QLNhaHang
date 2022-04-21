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
            string query = "SELECT SoPX as 'Số phiếu xuất', NgayXuat as 'Ngày xuất', PHIEUXUAT.MaNV as 'Mã nhân viên',NHANVIEN.HoTen as 'Tên nhân viên' FROM PHIEUXUAT, NHANVIEN WHERE PHIEUXUAT.MaNV = NHANVIEN.MaNV";
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvPhieuXuat.DataSource = dtb;
            dtgvPhieuXuat.AutoGenerateColumns = false;
            dtgvPhieuXuat.AllowUserToAddRows = false;
            dtgvPhieuXuat.AutoResizeColumns();
            sqlCon.Close();
        }

        private void connect(string query)
        {
            sqlCon.Open();
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
            chiTietXuat.soPX = dtgvPhieuXuat.SelectedRows[0].Cells[0].Value.ToString();
            chiTietXuat.ngayXuat = dtgvPhieuXuat.SelectedRows[0].Cells[1].Value.ToString();
            chiTietXuat.maNV = dtgvPhieuXuat.SelectedRows[0].Cells[2].Value.ToString();
            chiTietXuat.hoTen = dtgvPhieuXuat.SelectedRows[0].Cells[3].Value.ToString();
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
            string constr = Data_Provider.connectionSTR;
            string Sql = "select manv from nhanvien";
            using (SqlConnection conn = new SqlConnection(constr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(Sql, conn);
                SqlDataReader DR = cmd.ExecuteReader();

                while (DR.Read())
                {
                    txtMaNV.Items.Add(DR[0]);

                }
                DR.Close();
            }
            date1.Value = DateTime.Now;
            date2.Value = DateTime.Now;
        }

        private void TimKiem_Click(object sender, EventArgs e)
        {
            string dt1 = date1.Value.ToString("yyyy-MM-dd");
            string dt2 = date2.Value.ToString("yyyy-MM-dd");
            string query = "SELECT SoPX as 'Số phiếu xuất', NgayXuat as 'Ngày xuất', PHIEUXUAT.MaNV as 'Mã nhân viên',NHANVIEN.HoTen as 'Tên nhân viên' FROM PHIEUXUAT, NHANVIEN WHERE PHIEUXUAT.MaNV = NHANVIEN.MaNV";
            if (checkSPX.Checked == true && txtSPX.Text != string.Empty)
            {
                query += " and SoPX = '" + txtSPX.Text + "'";
            }
            if(checkDate.Checked == true)
            {
                query += " and ngayxuat between '" + dt1 + "' and '" + dt2 + "'";
            }
            if (checkNhanVien.Checked == true && txtMaNV.Text != string.Empty)
            {
                query += " and PHIEUXUAT.MaNV = '" + txtMaNV.Text + "'";
            }
            connect(query);
        }
    }
}
