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
    public partial class FormPhieuXuat : Form
    {
        public FormPhieuXuat()
        {
            InitializeComponent();
        }

        private void guna2Button1_Click(object sender, EventArgs e)
        {
            ChiTietXuat chiTietXuat = new ChiTietXuat();
            chiTietXuat.ShowDialog();
        }

        private void guna2Button2_Click(object sender, EventArgs e)
        {
            ThemPhieuXuat themPhieuXuat = new ThemPhieuXuat();
            themPhieuXuat.ShowDialog();
        }
    }
}
