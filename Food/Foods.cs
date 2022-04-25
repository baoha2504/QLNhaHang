using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using QLnhahang_anhttt.Data;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Runtime.CompilerServices;
using System.Runtime.Remoting.Channels;
using System.IO;

namespace QLnhahang_anhttt.Food
{
    public partial class Foods : UserControl
    {
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        static string workingDirectory = Environment.CurrentDirectory;
        string rootDir = Directory.GetParent(workingDirectory).Parent.Parent.FullName;
        public static Payment[] paymentlist = new Payment[100];
        public static Menu[] menu;
        public string pyc;
        public static long tongtam = 0;
        public static long tong = 0;
        public static string sdt;
        public static string tenkm = "NONE", mucgiam = "0";
        public Foods()
        {
            InitializeComponent();
        }
        public static int index = 0;
        public void populateItems_2()
        {
            flowLayoutPanelMENU.Controls.Clear();
           // flowLayoutPanel3.Controls.Clear();
        }


        private void Foods_Load(object sender, EventArgs e)
        {

        }

        

    }
}
