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
    public partial class NguyenLieuMoi : Form
    {
        public NguyenLieuMoi()
        {
            InitializeComponent();
        }
        int newLocationX;
        int newLocationY;
        string query;

        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);

        private void CapNhat(string query)
        {
            sqlCon.Open();
            SqlCommand cmd = new SqlCommand(query, sqlCon);
            cmd.ExecuteNonQuery();
            sqlCon.Close();
        }

        private void btThemNLMoi_Click(object sender, EventArgs e)
        {
            try
            {
                query = $"INSERT INTO NGUYENLIEU VALUES ('{txtMaNLMoi.Text}', 0, '{txtTenNLMoi.Text}', N'{txtDVMoi.Text}')";
                CapNhat(query);
                MessageBox.Show("Thêm nguyên liệu mới thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            } catch
            {
                MessageBox.Show("Vui lòng kiểm tra lại thông tin!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void guna2Panel1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button != MouseButtons.Left)
                return;
            newLocationX = e.X;
            newLocationY = e.Y;
        }

        private void guna2Panel1_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button != MouseButtons.Left)
                return;

            Left = Left + (e.X - newLocationX);
            Top = Top + (e.Y - newLocationY);
        }
    }
}
