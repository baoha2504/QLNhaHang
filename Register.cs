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
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);

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
        string gender;
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
                        // mã nv đã tồn tại 
                        MessageBox.Show("Employee ID already exists!!! Please re-enter ", "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        check = false;
                        txtAddManv.Focus();
                    }
                }
                if (check == true)
                {
                    if (guna2RadioBtnNam.Checked == true)
                    {
                        gender = "Nam";
                    }
                    else gender = "Nu";
                    sqlCon.Open();
                    String query = "INSERT INTO NHANVIEN (maNV,hoTen,NgaySinh,GioiTinh,diaChi,soDienThoai,chucVu, Luong) VALUES('" + txtAddManv.Text + "',N'" +
                            txtAddName.Text + "',N'" + guna2DateTimePickerBirth.Value.Date + "','" + gender + "','" + txtAddDC.Text + "','" + txtADDsdt.Text + "',N'" + txtAddChucvu.Text + "','" +txtAddSalary.Text + "' )";
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
        // position 
        private void txtAddChucvu_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                try
                {
                    bool check = true;
                    foreach (DataGridViewRow row in staff.guna2DataGridViewStaff.Rows)
                    {
                        string id = row.Cells[0].Value.ToString();
                        if (txtAddManv.Text == id)
                        {
                            MessageBox.Show("Employee ID already exists!!! Please re-enter", "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            check = false;
                            txtAddManv.Focus();
                        }
                    }
                    if (check == true)
                    {
                        sqlCon.Open();
                        String query = "INSERT INTO NHANVIEN (maNV,hoTen,diaChi,soDienThoai,chucVu) VALUES('" + txtAddManv.Text + "',N'" +
                                txtAddName.Text + "','" + txtAddDC.Text + "','" + txtADDsdt.Text + "',N'" + txtAddChucvu.Text + "')";
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
        }

        private void txtAddManv_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[A-Z0-9]{5,8}$");
            string text = txtAddManv.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                txtAddManv.Focus();
                errorProvider1.SetError(txtAddManv, "Only uppercase and numbers!");  // chi co chu in hoa va so
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtAddManv, null);
            }
        }

        private void txtADDsdt_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[0-9]{9,11}$");
            string text = txtADDsdt.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                txtADDsdt.Focus();
                errorProvider2.SetError(txtADDsdt, "Only number!");
            }
            else
            {
                e.Cancel = false;
                errorProvider2.SetError(txtADDsdt, null);
            }
        }

        private void txtAddSalary_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[0-9]{9,11}$");
            string text = txtAddSalary.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                txtAddSalary.Focus();
                errorProvider2.SetError(txtAddSalary, "Only number!");
            }
            else
            {
                e.Cancel = false;
                errorProvider2.SetError(txtAddSalary, null);
            }
        }
    }
}
