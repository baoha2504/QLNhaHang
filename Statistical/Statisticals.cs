using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLnhahang_anhttt.Statistical
{
    public partial class Statisticals : UserControl
    {
        public Statisticals()
        {
            InitializeComponent();
        }

        private void TK_Ngay_Click(object sender, EventArgs e)
        {
        }

        private void TK_Thang_Click(object sender, EventArgs e)
        {
        }

        private void TK_4_Click(object sender, EventArgs e)
        {
        }

        private void TK_TuyChon_Click(object sender, EventArgs e)
        {
        }

        private void BD_NgayTuan_Click(object sender, EventArgs e)
        {
        }

        private void BD_ThangNam_Click(object sender, EventArgs e)
        {
        }

        private void Statisticals_Load(object sender, EventArgs e)
        {

        }

        private void guna2TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            guna2Panel2.BringToFront();
        }

        private void Ngay_Click(object sender, EventArgs e)
        {
            thongKeTheoNgay1.BringToFront();
        }

        private void Thang_Click(object sender, EventArgs e)
        {
            thongKeTheoThang1.BringToFront();
        }

        private void Nam_Click(object sender, EventArgs e)
        {
            thongKeTheoNam1.BringToFront();
        }

        private void LuaChon_Click(object sender, EventArgs e)
        {
            thongKeLuaChon1.BringToFront();
        }

        private void NgayTuan_Click(object sender, EventArgs e)
        {
            bdNgayTuan1.BringToFront();
        }

        private void ThangNam_Click(object sender, EventArgs e)
        {
            bdThangNam1.BringToFront();
        }
    }
}
