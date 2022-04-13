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
using System.Text.RegularExpressions;
using QLnhahang_anhttt.Data;
namespace QLnhahang_anhttt
{
    public partial class Registerform : Form
    {
        SqlConnection sqlCon = new SqlConnection(Data_Provider.ConnectionSTR);

        Staff staff;
        public Registerform(Staff fg)
        {
            InitializeComponent();
            this.staff = fg;
        }

        #region Methods
        // be new thong tin cua nguoi muon dang ky
        private void clear()
        {
            txtAddManv.Text = "";
            txtAddName.Text = "";
            txtAddDC.Text = "";
            txtADDsdt.Text = "";
            txtAddChucvu.Text = "";
        }
        // connect database
        private void connect()
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM NHANVIEN", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            staff.guna2DataGridViewStaff.DataSource = dtb;

            staff.guna2DataGridViewStaff.AutoGenerateColumns = false;
            staff.guna2DataGridViewStaff.AllowUserToAddRows = false;
            staff.guna2DataGridViewStaff.AutoResizeColumns();

            sqlCon.Close();
        }

        #endregion
        // nut add
        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                bool check = true;
                foreach (DataGridViewRow row in staff.guna2DataGridViewStaff.Rows)
                {
                    string id = row.Cells[0].Value.ToString();
                    if (txtAddManv.Text == id)
                    {
                        MessageBox.Show("Mã sinh viên đã tồn tại!!! Xin vui lòng nhập lại", "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        check = false;
                        txtAddManv.Focus();
                    }
                }
                if (check == true)
                {
                    sqlCon.Open();
                    String query = "INSERT INTO NHANVIEN (maNV,hoTen,diaChi,soDienThoai,chucVu) VALUES('" + txtAddManv.Text + "',N'" +
                            txtAddName.Text + "',N'" + txtAddDC.Text + "','" + txtADDsdt.Text + "',N'" + txtAddChucvu.Text + "')";
                    SqlCommand sqlDa = new SqlCommand(query, sqlCon);
                    sqlDa.ExecuteNonQuery();
                    sqlCon.Close();
                    connect();
                    clear();
                    this.Hide();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtAddManv.Focus();
            }
        }
        // nut cancel
        private void btnHuy_Click(object sender, EventArgs e)
        {
            clear();
            this.Hide();
        }
    }
}
