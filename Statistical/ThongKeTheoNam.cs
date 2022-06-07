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

namespace QLnhahang_anhttt.Statistical
{
    public partial class ThongKeTheoNam : UserControl
    {
        public ThongKeTheoNam()
        {
            InitializeComponent();
            guna2DateTimePicker1.Format = DateTimePickerFormat.Custom;
            guna2DateTimePicker1.CustomFormat = "yyyy";
            guna2DateTimePicker1.Value = DateTime.Now;
        }

        string text;
        private string HienThi(string Sql)
        {

            string constr = Data_Provider.connectionSTR;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(Sql, conn);
                SqlDataReader DR = cmd.ExecuteReader();

                while (DR.Read())
                {
                    //txtMaNCC.Items.Add(DR[0]);
                    text = DR[0].ToString();
                }
                DR.Close();
                conn.Close();

            }
            return text;
        }

        private void ThongKeTheoNam_Load(object sender, EventArgs e)
        {
            //DateTime dt1 = guna2DateTimePicker1.Value;
            //DateTime dt2 = guna2DateTimePicker1.Value;

            string query1 = "TKnam_MonYT'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label9.Text = HienThi(query1);

            string query2 = "TKnam_MonDT'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label10.Text = HienThi(query2);

            string query3 = "TKnam_SoPN'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label11.Text = HienThi(query3);

            string query4 = "TKnam_SoPX'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label12.Text = HienThi(query4);

            string query5 = "TKnam_SoHD'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label13.Text = HienThi(query5);


            string query6 = "TKnam_NV'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label14.Text = HienThi(query6);

            string query7 = "TKnam_KH'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label15.Text = HienThi(query7);

            string query8 = "TKnam_CHI'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label19.Text = HienThi(query8) + " VNĐ";

            string query9 = "TKnam_THU'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label18.Text = HienThi(query9) + " VNĐ";

            if (label9.Text == string.Empty)
            {
                label9.Text = "Không đủ dữ liệu để thống kê!";
            }
            if (label10.Text == string.Empty)
            {
                label10.Text = "Không đủ dữ liệu để thống kê!";
            }
            if (label18.Text == " VNĐ")
            {
                label18.Text = "0 VNĐ";
            }
            if (label19.Text == " VNĐ")
            {
                label19.Text = "0 VNĐ";
            }
        }

        private void start_Click(object sender, EventArgs e)
        {
            ThongKeTheoNam_Load(sender, e);
        }
    }
}
