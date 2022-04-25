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
    public partial class ThongKeTheoNam : UserControl
    {
        public ThongKeTheoNam()
        {
            InitializeComponent();
            guna2DateTimePicker1.Format = DateTimePickerFormat.Custom;
            guna2DateTimePicker1.CustomFormat = "yyyy";
        }
    }
}
