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
    public partial class ThongKeLuaChon : UserControl
    {
        public ThongKeLuaChon()
        {
            InitializeComponent();
            guna2DateTimePicker1.Value = DateTime.Now;
            guna2DateTimePicker2.Value = DateTime.Now;
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


        private void ThongKeLuaChon_Load(object sender, System.EventArgs e)
        {
            string query1 = "TKchon_MonYT'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '"+guna2DateTimePicker2.Value.ToString("yyyy - MM - dd")+"'";
            label9.Text = HienThi(query1);

            string query2 = "TKchon_MonDT'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
            label10.Text = HienThi(query2);

            string query3 = "TKchon_SoPN'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
            label11.Text = HienThi(query3);

            string query4 = "TKchon_SoPX'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
            label12.Text = HienThi(query4);

            string query5 = "TKchon_SoHD'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
            label13.Text = HienThi(query5);


            string query6 = "TKchon_NV'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
            label14.Text = HienThi(query6);

            string query7 = "TKchon_KH'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
            label15.Text = HienThi(query7);

            string query8 = "TKchon_CHI'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
            label2.Text = HienThi(query8) + " VNĐ";

            string query9 = "TKchon_THU'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "' , '" + guna2DateTimePicker2.Value.ToString("yyyy - MM - dd") + "'";
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
            if (label2.Text == " VNĐ")
            {
                label2.Text = "0 VNĐ";
            }
        }

        private void start_Click(object sender, EventArgs e)
        {
            ThongKeLuaChon_Load(sender, e);
        }
    }
}
