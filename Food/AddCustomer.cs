using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using QLnhahang_anhttt.Data;
using System.Data.SqlClient;


namespace QLnhahang_anhttt.Food
{
    public partial class AddCustomer : Form
    {


        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        public AddCustomer()
        {
            InitializeComponent();
        }
        public bool CheckData()
        {
            if (string.IsNullOrEmpty(txtName_add.Text))
            {
                MessageBox.Show("Bạn chưa nhập tên khách hàng.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtName_add.Focus();
                return false;
            }
            if (string.IsNullOrEmpty(txtAdd_add.Text))
            {
                MessageBox.Show("Bạn chưa nhập địa chỉ khách hàng.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtAdd_add.Focus();
                return false;
            }
            if (string.IsNullOrEmpty(txtPhone_add.Text))
            {
                MessageBox.Show("Bạn chưa nhập số điện thoại khách hàng.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtPhone_add.Focus();
                return false;
            }
            return true;
        }

        private void guna2BtnAddcustomer_Click(object sender, EventArgs e)
        {
            CheckData();
            try
            {
                sqlCon.Open();
                string query = "INSERT INTO KHACHHANG (MaKH,TenKH, DiaChi, SoDienThoai) VALUES (N'" + txtID_add.Text + "',N'" + txtName_add.Text + "', N'" + txtAdd_add.Text + "', '" + txtPhone_add.Text + "')";
                SqlCommand cmd = new SqlCommand(query, sqlCon);
                cmd.ExecuteNonQuery();
                MessageBox.Show("Update success");
                sqlCon.Close();
            }
            catch
            {
                string message = "Lỗi";
                string title = "Thông báo";
                DialogResult dialogResult = MessageBox.Show(message, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }

        private void guna2Button1_Click(object sender, EventArgs e)
        {

            this.Hide();

        }

        private void txtID_add_DoubleClick(object sender, EventArgs e)
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlCommand command = new SqlCommand("Select [dbo].[auto_maKH]()", sqlCon);
            command.ExecuteNonQuery();
            txtID_add.Text = command.ExecuteScalar().ToString();
            sqlCon.Close();
        }
    }
}
