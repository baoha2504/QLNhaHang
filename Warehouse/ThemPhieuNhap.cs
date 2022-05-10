using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt.Warehouse
{
    public partial class ThemPhieuNhap : Form
    {
        public ThemPhieuNhap()
        {
            InitializeComponent();
        }

        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        string manlnhap;
        private void connect(string query)
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dtgvThemNL.DataSource = dtb;
            dtgvThemNL.AutoGenerateColumns = false;
            dtgvThemNL.AllowUserToAddRows = false;
            dtgvThemNL.AutoResizeColumns();
            sqlCon.Close();
        }

        private void CapNhat(string query)
        {
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand(query, sqlCon);
            cmd.ExecuteNonQuery();
            sqlCon.Close();
        }

        private void ThemPhieuNhap_Load(object sender, EventArgs e)
        {
            NgayNhap.Value = DateTime.Now;
            txtTongTien.Text = "0";
            txtTongTien.Enabled = false;
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
                conn.Open();
                Sql = "select tennl from nguyenlieu";
                SqlCommand cmd3 = new SqlCommand(Sql, conn);
                SqlDataReader DR3 = cmd3.ExecuteReader();

                while (DR3.Read())
                {
                    txtTenNL.Items.Add(DR3[0]);
                }
                DR.Close();
                conn.Close();
            }
        }

        private void btThemNL_Click(object sender, EventArgs e)
        {
            txtSoPN.Enabled = false;
            txtMaNV.Enabled = false;
            txtMaNCC.Enabled = false;
            if (txtTenNL.Text != string.Empty && txtSoLuong.Text != string.Empty && txtDonVi.Text != string.Empty && txtDonGia.Text != string.Empty)
            {
                try
                {
                    int soluong = int.Parse(txtSoLuong.Text);
                    int dongia = int.Parse(txtDonGia.Text);
                    int sum = (int.Parse(txtTongTien.Text) + int.Parse(txtSoLuong.Text) * int.Parse(txtDonGia.Text));
                    txtTongTien.Text = sum.ToString();
                    string constr = Data_Provider.connectionSTR;
                    string Sql = "select manl from nguyenlieu where tennl = N'" + txtTenNL.Text + "'";
                    using (SqlConnection conn = new SqlConnection(constr))
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand(Sql, conn);
                        SqlDataReader DR = cmd.ExecuteReader();

                        while (DR.Read())
                        {
                            manlnhap = DR[0].ToString();
                        }
                        DR.Close();
                        conn.Close();
                    }
                    DataGridViewRow row = new DataGridViewRow(); //Khai bao row
                    dtgvThemNL.Rows.Add(manlnhap, txtTenNL.Text, txtSoLuong.Text, txtDonVi.Text, txtDonGia.Text);
                }
                catch
                {
                    MessageBox.Show("Dữ liệu thêm vào chưa đúng yêu cầu!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void btXoa_Click(object sender, EventArgs e)
        {
            dtgvThemNL.Rows.Clear();
        }

        private void btThemPN_Click(object sender, EventArgs e)
        {
            if (txtSoPN.Text != string.Empty && txtMaNV.Text != string.Empty && txtMaNCC.Text != string.Empty)
            {
                try
                {
                    string query1 = $"insert into phieunhap values ('{txtSoPN.Text}', '{NgayNhap.Value.ToString("yyyy-MM-dd")}', '{txtTongTien.Text}', '{txtMaNV.Text}', '{txtMaNCC.Text}')";
                    CapNhat(query1);
                    for (int i = 0; i < dtgvThemNL.Rows.Count - 1; i++)
                    {
                        string manl = dtgvThemNL.Rows[i].Cells[0].Value.ToString();
                        string tennl = dtgvThemNL.Rows[i].Cells[1].Value.ToString();
                        string soluong = dtgvThemNL.Rows[i].Cells[2].Value.ToString();
                        string donvi = dtgvThemNL.Rows[i].Cells[3].Value.ToString();
                        string dongia = dtgvThemNL.Rows[i].Cells[4].Value.ToString();
                        string sumSoLuong = "0";
                        string query2 = $"insert into chitietnhap values ('{txtSoPN.Text}', '{manl}', '{soluong}', '{dongia}')";
                        CapNhat(query2);
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
                            int sum = int.Parse(soluong) + int.Parse(sumSoLuong);
                            sumSoLuong = sum.ToString();
                            string query3 = $"update nguyenlieu set soluong = '{sumSoLuong}' where manl = '{manl}'";
                            CapNhat(query3);
                        }
                    }
                    MessageBox.Show("Thêm phiếu nhập thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch
                {
                    MessageBox.Show("Kiểm tra lại phiếu nhập", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }
    }
}
