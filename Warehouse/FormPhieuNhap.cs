using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLnhahang_anhttt.Warehouse
{
    public partial class FormPhieuNhap : Form
    {
        public FormPhieuNhap()
        {
            InitializeComponent();
        }

        private void guna2Button2_Click(object sender, EventArgs e)
        {
            ChiTietNhap chiTietNhap = new ChiTietNhap();
            chiTietNhap.ShowDialog();
        }

        private void guna2Button3_Click(object sender, EventArgs e)
        {
            ThemPhieuNhap them = new ThemPhieuNhap();
            them.ShowDialog();
        }
    }
}
