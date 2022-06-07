using System;
using System.Data.SqlClient;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt.Statistical
{
    public partial class ThongKeTheoThang : UserControl
    {
        public ThongKeTheoThang()
        {
            InitializeComponent();
            guna2DateTimePicker1.Format = DateTimePickerFormat.Custom;
            guna2DateTimePicker1.CustomFormat = "MM/yyyy";
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

        //public static DateTime GetFirstDayOfMonth(DateTime dtInput)
        //{
        //    DateTime dtResult = dtInput;
        //    dtResult = dtResult.AddDays((-dtResult.Day) + 1);
        //    return dtResult;
        //}
        //public DateTime GetLastDayOfMonth(DateTime dtInput)
        //{
        //    DateTime dtResult = dtInput;
        //    dtResult = dtResult.AddMonths(1);
        //    dtResult = dtResult.AddDays(-(dtResult.Day));
        //    return dtResult;
        //}

        private void ThongKeTheoThang_Load(object sender, System.EventArgs e)
        {

            //DateTime dt1 = GetFirstDayOfMonth(guna2DateTimePicker1.Value);
            //DateTime dt2 = GetLastDayOfMonth(guna2DateTimePicker1.Value);

            string query1 = "TKthang_MonYT'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label9.Text = HienThi(query1);

            string query2 = "TKthang_MonDT'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label10.Text = HienThi(query2);

            string query3 = "TKthang_SoPN'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label11.Text = HienThi(query3);

            string query4 = "TKthang_SoPX'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label12.Text = HienThi(query4);

            string query5 = "TKthang_SoHD'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label13.Text = HienThi(query5);


            string query6 = "TKthang_NV'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label14.Text = HienThi(query6);

            string query7 = "TKthang_KH'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label15.Text = HienThi(query7);

            string query8 = "TKthang_CHI'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
            label19.Text = HienThi(query8) + " VNĐ";

            string query9 = "TKthang_THU'" + guna2DateTimePicker1.Value.ToString("yyyy - MM - dd") + "'";
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
            ThongKeTheoThang_Load(sender, e);
        }
    }
}
