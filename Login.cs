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

namespace QLnhahang_anhttt
{
    public partial class loginform : Form
    {
       // SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
      //  DataTable dtbl;

        public static string position;
        public static string name;
        public static string manv;
        public loginform()
        {
            InitializeComponent();
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
            /*
            sqlCon.Open();
            string query = "Select * from NHANVIEN where MaNV= '" + textPass.Text.Trim().ToUpper() +
                "' and hoTen=N'" + textUser.Text.Trim() + "'";
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
            */
                MainForm frm = new MainForm();
                frm.Show();
                this.Hide();
      /*      }
            else
            {
                MessageBox.Show("Check your Username and Password!");
            } */ 
        }
    }
}
