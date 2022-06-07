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
    public partial class Staff : UserControl
    {
       SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);

        string IDEmployee;

        public Staff()
        {
            InitializeComponent();
            connect();  
        }
        private void connect()
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT maNV as 'ID', hoten as 'Name', diachi as 'Address', soDienThoai as 'Phone', chucvu as 'Position' FROM NHANVIEN", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            guna2DataGridViewStaff.DataSource = dtb;
            guna2DataGridViewStaff.AutoGenerateColumns = false;
            guna2DataGridViewStaff.AllowUserToAddRows = false;
            guna2DataGridViewStaff.AutoResizeColumns();
            sqlCon.Close();
        }

        void clear()
        {
            txtID.Text = "";
            txtName.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            txtPosition.Text = "";
        }
        // trong bang information

        // nút Fix : sua thong tin
        private void guna2BtnFix_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                /*String query = "UPDATE NHANVIEN set maNV=N'" + txtID.Text + "',hoTen=N'" + txtName.Text + "',diaChi=N'" + txtAddress.Text + "',soDienThoai='" + txtPhone.Text + "',chucVu=N'" + txtPosition.Text + "'where maNV=N'" + txtID.Text + "'";
                SqlCommand cmd = new SqlCommand(query, sqlCon);
                cmd.ExecuteNonQuery()*/;

                Data_Provider.exc("exec update_NV '" +txtID.Text+ "','" +txtName.Text + "','" + txtAddress.Text + "','" + txtPhone.Text + "','" +txtPosition.Text + "';");

                MessageBox.Show("Update success");
                sqlCon.Close();
                connect();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtID.Focus();
            }
        }


        // nut delete
        private void guna2BtnDelete_Click(object sender, EventArgs e)
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand("delete from NHANVIEN where maNV='" + IDEmployee + "'", sqlCon);
            cmd.ExecuteNonQuery();
            //   Data_Provider.exc("exec delete_NV '" +txtID.Text+ "'; ");
            sqlCon.Close();
            connect();
        }

        private void guna2BtnFind_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtID.Text != "")
                {
                    sqlCon.Close();
                    sqlCon.Open();
                    string query = "SELECT maNV as 'ID', hoten as 'Name', diachi as 'Address', soDienThoai as 'Phone', chucvu as 'Position' FROM NHANVIEN where maNV='" + txtID.Text + "'";
                    SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
                    DataTable dtb = new DataTable();
                    sqlDa.Fill(dtb);
                    guna2DataGridViewStaff.DataSource = dtb;  
                    guna2DataGridViewStaff.AutoGenerateColumns = true;
                    guna2DataGridViewStaff.AutoResizeColumns();
                    sqlCon.Close();
                   
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtID.Focus();
            }
        }

        private void guna2BtnCheck_Click(object sender, EventArgs e)
        {
            connect();
            guna2TextBoxSearch.Text = "";
            clear();
        }
       

        // nut add personel
        private void guna2ButtonAddNV_Click(object sender, EventArgs e)
        {
            Registerform frmRegister = new Registerform(this);
            frmRegister.Show();

        }

        // datagrid view
        private void guna2DataGridViewStaff_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                IDEmployee = guna2DataGridViewStaff.Rows[e.RowIndex].Cells[0].Value.ToString();
                txtID.Text = guna2DataGridViewStaff.Rows[e.RowIndex].Cells[0].Value.ToString();
                txtName.Text = guna2DataGridViewStaff.Rows[e.RowIndex].Cells[1].Value.ToString();
                txtAddress.Text = guna2DataGridViewStaff.Rows[e.RowIndex].Cells[2].Value.ToString();
                txtPhone.Text = guna2DataGridViewStaff.Rows[e.RowIndex].Cells[3].Value.ToString();
                txtPosition.Text = guna2DataGridViewStaff.Rows[e.RowIndex].Cells[4].Value.ToString();
            }
        }
        // tao default cho manv va sdt 
        private void txtID_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[A-Z0-9]{5,8}$");
            string text = txtID.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                txtID.Focus();
                errorProvider1.SetError(txtID, "Only uppercase and numbers!");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtID, null);
            }
        }

        private void txtPhone_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[0-9]{9,11}$");
            string text = txtPhone.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                txtPhone.Focus();
                errorProvider2.SetError(txtPhone, "Only numbers!");
            }
            else
            {
                e.Cancel = false;
                errorProvider2.SetError(txtPhone, null);
            }
        }
        // picture kinh lup tim kiem
        private void guna2PictureBox1_Click(object sender, EventArgs e)
        {
            try
            {
                if (guna2TextBoxSearch.Text != "")
                {
                    sqlCon.Open();
                    string query = "Select * from NHANVIEN where maNV='" + guna2TextBoxSearch.Text + "'";
                    SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
                    DataTable dtb = new DataTable();
                    sqlDa.Fill(dtb);
                    guna2DataGridViewStaff.DataSource = dtb;  
                  
                    guna2DataGridViewStaff.AutoGenerateColumns = true;
                    guna2DataGridViewStaff.AllowUserToAddRows = false;
                    guna2DataGridViewStaff.AutoResizeColumns();
                    sqlCon.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                guna2TextBoxSearch.Focus();
            }
        }

        private void guna2TextBoxSearch_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (guna2TextBoxSearch.Text != "")
                {
                    sqlCon.Close();
                    sqlCon.Open();
                    DataTable dtb = Data_Provider.GetDataTable("select manv as 'ID', hoten as 'Name', diachi as 'Address', sodienthoai as 'Phone', chucvu as 'Position' from SearchNV( N'" + guna2TextBoxSearch.Text + "');");
                    guna2DataGridViewStaff.DataSource = dtb;
                    guna2DataGridViewStaff.AutoGenerateColumns = true ;
                    guna2DataGridViewStaff.AllowUserToAddRows = false ;
                    guna2DataGridViewStaff.AutoResizeColumns();
                    sqlCon.Close();
                }
                else
                {
                    connect();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void s(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
