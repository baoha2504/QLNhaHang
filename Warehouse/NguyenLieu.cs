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
    public partial class NguyenLieu : UserControl
    {
        public NguyenLieu()
        {
            InitializeComponent();
        }

        private void NhapNguyenLieu_Click(object sender, EventArgs e)
        {
            FormPhieuNhap form = new FormPhieuNhap();
            form.ShowDialog();
        }

        private void XuatNguyenLieu_Click(object sender, EventArgs e)
        {
            FormPhieuXuat form = new FormPhieuXuat();
            form.ShowDialog();
        }
    }
}
