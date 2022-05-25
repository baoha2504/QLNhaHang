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
            //string query = "SELECT SoPN as 'Số phiếu nhập', NgayNhap as 'Ngày nhập', TongTien as 'Tổng tiền', MaNV as 'Mã nhân viên', MaNCC as 'Nhà cung cấp' FROM PHIEUNHAP";
            string query = "PhieuNhap_Load";
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvPhieuNhap.DataSource = dtb;
            dtgvPhieuNhap.AutoGenerateColumns = false;
            dtgvPhieuNhap.AllowUserToAddRows = false;
            dtgvPhieuNhap.AutoResizeColumns();
            sqlCon.Close();
        }

        private void connect(string query)
        {
            sqlCon.Open();
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
            chiTietNhap.soPN = dtgvPhieuNhap.SelectedRows[0].Cells[0].Value.ToString();
            chiTietNhap.ngayNhap = dtgvPhieuNhap.SelectedRows[0].Cells[1].Value.ToString();
            chiTietNhap.tongTien = dtgvPhieuNhap.SelectedRows[0].Cells[2].Value.ToString();
            chiTietNhap.nhanVien = dtgvPhieuNhap.SelectedRows[0].Cells[3].Value.ToString();
            chiTietNhap.nhaCC = dtgvPhieuNhap.SelectedRows[0].Cells[4].Value.ToString();
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
            string constr = Data_Provider.connectionSTR;
            string Sql = "select mancc from nhacungcap";
            using (SqlConnection conn = new SqlConnection(constr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(Sql, conn);
                SqlDataReader DR = cmd.ExecuteReader();

                while (DR.Read())
                {
                    txtMaNCC.Items.Add(DR[0]);

                }
                DR.Close();
                conn.Close();
                conn.Open();
                Sql = "select manv from nhanvien";
                SqlCommand cmd2 = new SqlCommand(Sql, conn);
                SqlDataReader DR2 = cmd2.ExecuteReader();

                while (DR2.Read())
                {
                    txtMaNV.Items.Add(DR2[0]);

                }
                DR.Close();
                conn.Close();
            }
            time1.Value = DateTime.Now;
            time2.Value = DateTime.Now;
        }

        private void btTimKiem_Click(object sender, EventArgs e)
        {
            string query = "SELECT SoPN as 'Số phiếu nhập', NgayNhap as 'Ngày nhập', TongTien as 'Tổng tiền', MaNV as 'Mã nhân viên', MaNCC as 'Nhà cung cấp' from Phieunhap where phieunhap.mancc = phieunhap.mancc";
            string date1 = time1.Value.ToString("yyyy-MM-dd");
            string date2 = time2.Value.ToString("yyyy-MM-dd");

            if (checkSPN.Checked == true && txtSoPhieuNhap.Text != String.Empty)
            {
                query += " and SOPN = '" + txtSoPhieuNhap.Text + "' ";
            }
            if (checkThoiGian.Checked == true)
            {
                query += " and ngaynhap between '" + date1 + "' and '" + date2 + "'";
            }
            if (checkTongTien.Checked == true && txtTongTien.Text != string.Empty)
            {
                if (checkLon.Checked == true)
                {
                    query += " and tongtien > " + txtTongTien.Text;
                }
                if (checkBang.Checked == true)
                {
                    query += " and tongtien = " + txtTongTien.Text;
                }
                if (checkBe.Checked == true)
                {
                    query += " and tongtien < " + txtTongTien.Text;
                }
            }
            if (checkNV.Checked == true && txtMaNV.Text != string.Empty)
            {
                query += " and manv = '" + txtMaNV.Text + "' ";
            }
            if (checkNCC.Checked == true && txtMaNCC.Text != string.Empty)
            {
                query += " and mancc = '" + txtMaNCC.Text + "' ";
            }
            connect(query);
        }
    }
}
