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
    public partial class InPhieuXuat : Form
    {
        public InPhieuXuat()
        {
            InitializeComponent();
        }

        private void InPhieuXuat_Load(object sender, EventArgs e)
        {

            this.reportViewer1.RefreshReport();
        }
    }
}
