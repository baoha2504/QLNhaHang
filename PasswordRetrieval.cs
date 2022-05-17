using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt
{
    public partial class PasswordRetrieval : Form
    {
        public PasswordRetrieval()
        {
            InitializeComponent();
        }
        DataTable dtbl;

        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);

        static string ComputeSha256Hash(string rawData)
        {
            // Create a SHA256   
            using (SHA256 sha256Hash = SHA256.Create())
            {
                // ComputeHash - returns byte array  
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));

                // Convert byte array to a string   
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void btConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtNewPass.Text == txtConfirm.Text)
                {

                    sqlCon.Open();
                    string query = "Select * from NHANVIEN where matkhau= '" + ComputeSha256Hash(txtPass.Text) + "' and manv= N'" + txtUser.Text + "'";
                    //string query = "Select * from NHANVIEN where matkhau= '" + textPass.Text + "' and manv= N'" + textUser.Text + "'";
                    SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);

                    // Create a DataSet.
                    dtbl = new DataTable();
                    sqlDa.Fill(dtbl);
                    sqlCon.Close();
                    if (dtbl.Rows.Count == 1)
                    {
                        sqlCon.Open();
                        SqlCommand up = new SqlCommand();
                        up.Connection = sqlCon;
                        up.CommandText = "update NHANVIEN set matkhau = '" + ComputeSha256Hash(txtNewPass.Text) + "' where manv = '" + txtUser.Text + "' ";
                        up.ExecuteNonQuery();
                        MessageBox.Show("Thay đổi mật khẩu thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        MessageBox.Show("Kiểm tra lại thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    sqlCon.Close();
                } else
                {
                    MessageBox.Show("Kiểm tra lại thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            catch
            {
                MessageBox.Show("Kiểm tra lại thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
