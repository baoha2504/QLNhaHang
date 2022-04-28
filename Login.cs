using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;
using System.Security.Cryptography;

namespace QLnhahang_anhttt
{
    public partial class loginform : Form
    {
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        DataTable dtbl;

        public static string position;
        public static string name;
        public static string manv;
        public loginform()
        {
            InitializeComponent();
        }

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

        // close project 
        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        // show password 
        private void picPassword_MouseDown(object sender, MouseEventArgs e)
        {
            textPass.UseSystemPasswordChar = false;
        }

        private void picPassword_MouseUp(object sender, MouseEventArgs e)
        {
            textPass.UseSystemPasswordChar = true;
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {

            sqlCon.Open();
            string query = "Select * from NHANVIEN where matkhau= '" + ComputeSha256Hash(textPass.Text) + "' and manv= N'" + textUser.Text + "'";
            //string query = "Select * from NHANVIEN where matkhau= '" + textPass.Text + "' and manv= N'" + textUser.Text + "'";
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);

            // Create a DataSet.
            dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            if (dtbl.Rows.Count == 1)
            {
                manv = textPass.Text.Trim(); //////////
                foreach (DataRow dr in dtbl.Rows)
                {
                    name = dr["hoTen"].ToString();
                    position = dr["chucVu"].ToString();
                }

                MainForm frm = new MainForm();
                frm.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Check your Username and Password!");
            }
        }
    }
}
