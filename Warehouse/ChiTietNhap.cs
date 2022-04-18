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
    public partial class ChiTietNhap : Form
    {
        public ChiTietNhap()
        {
            InitializeComponent();
        }

        private void btInPhieuNhap_Click(object sender, EventArgs e)
        {
            InPhieuNhap inPhieuNhap = new InPhieuNhap();
            inPhieuNhap.ShowDialog();
        }
    }
}
