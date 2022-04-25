using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt.Warehouse
{
    public partial class ThemPhieuXuat : Form
    {
        public ThemPhieuXuat()
        {
            InitializeComponent();
        }
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        string manlxuat;

        private void CapNhat(string query)
        {
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand(query, sqlCon);
            cmd.ExecuteNonQuery();
            sqlCon.Close();
        }
        private void btXoaTatCa_Click(object sender, EventArgs e)
        {
            dtgvThemPhieuXuat.Rows.Clear();
        }

        private void btThem_Click(object sender, EventArgs e)
        {
            if (txtTenNL.Text != string.Empty && txtSoLuong.Text != string.Empty && txtDonGia.Text != string.Empty)
            {
                try
                {
                    int soluong = int.Parse(txtSoLuong.Text);
                    int dongia = int.Parse(txtDonGia.Text);
                    string constr = Data_Provider.connectionSTR;
                    string Sql = "select manl from nguyenlieu where tennl = N'" + txtTenNL.Text + "'";
                    using (SqlConnection conn = new SqlConnection(constr))
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand(Sql, conn);
                        SqlDataReader DR = cmd.ExecuteReader();

                        while (DR.Read())
                        {
                            manlxuat = DR[0].ToString();
                        }
                        DR.Close();
                        conn.Close();
                    }
                    DataGridViewRow row = new DataGridViewRow(); //Khai bao row
                    dtgvThemPhieuXuat.Rows.Add(manlxuat, txtTenNL.Text, txtSoLuong.Text, txtDonGia.Text);
                }
                catch
                {
                    MessageBox.Show("Dữ liệu thêm vào chưa đúng yêu cầu!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void ThemPhieuXuat_Load(object sender, EventArgs e)
        {
            NgayXuat.Value = DateTime.Now;
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
                conn.Close();
                conn.Open();
                Sql = "select tennl from nguyenlieu";
                SqlCommand cmd2 = new SqlCommand(Sql, conn);
                SqlDataReader DR2 = cmd2.ExecuteReader();

                while (DR2.Read())
                {
                    txtTenNL.Items.Add(DR2[0]);

                }
                DR.Close();
                conn.Close();
            }
        }

        private void btThemPX_Click(object sender, EventArgs e)
        {
            if (txtSoPX.Text != string.Empty && txtMaNV.Text != string.Empty)
            {
                try
                {
                    string query1 = $"insert into phieuxuat values ('{txtSoPX.Text}', '{NgayXuat.Value.ToString("yyyy-MM-dd")}', '{txtMaNV.Text}')";
                    CapNhat(query1);
                    for (int i = 0; i < dtgvThemPhieuXuat.Rows.Count - 1; i++)
                    {
                        string manl = dtgvThemPhieuXuat.Rows[i].Cells[0].Value.ToString();
                        string tennl = dtgvThemPhieuXuat.Rows[i].Cells[1].Value.ToString();
                        string soluong = dtgvThemPhieuXuat.Rows[i].Cells[2].Value.ToString();
                        string dongia = dtgvThemPhieuXuat.Rows[i].Cells[3].Value.ToString();
                        string sumSoLuong = "0";
                        
                        string constr = Data_Provider.connectionSTR;
                        string Sql = "select soluong from nguyenlieu where manl = '" + manl + "'";
                        using (SqlConnection conn = new SqlConnection(constr))
                        {
                            conn.Open();
                            SqlCommand cmd = new SqlCommand(Sql, conn);
                            SqlDataReader DR = cmd.ExecuteReader();

                            while (DR.Read())
                            {
                                sumSoLuong = DR[0].ToString();
                            }
                            DR.Close();
                            conn.Close();
                            int sum = int.Parse(sumSoLuong) - int.Parse(soluong);
                            if (sum >= 0)
                            {
                                sumSoLuong = sum.ToString();
                                string query3 = $"update nguyenlieu set soluong = '{sumSoLuong}' where manl = '{manl}'";
                                CapNhat(query3);
                                string query2 = $"insert into chitietxuat values ('{manl}', '{txtSoPX.Text}', '{soluong}', '{dongia}')";
                                CapNhat(query2);
                            }
                            else
                            {
                                MessageBox.Show("Số lượng xuất không đủ", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            }
                        }
                    }
                    
                    MessageBox.Show("Thêm phiếu xuất thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch
                {
                    MessageBox.Show("Kiểm tra lại phiếu nhập", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    }
}
