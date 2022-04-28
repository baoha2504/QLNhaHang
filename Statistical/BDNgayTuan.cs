using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt.Statistical
{
    public partial class BDNgayTuan : UserControl
    {
        public BDNgayTuan()
        {
            InitializeComponent();
        }
        SqlConnection conn = new SqlConnection(Data_Provider.connectionSTR);
        string query;
        string text;
        DateTime datengay1 = DateTime.Now;
        DateTime datengay2 = DateTime.Now.Date.AddDays(-7);
        DateTime datengay3 = DateTime.Now.Date.AddDays(-1);

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
        private void BDNgayTuan_Load(object sender, EventArgs e)
        {
            // thu chi theo ngay
            query = "SELECT NgayThu, SUM(TongTien) as Tong FROM HOADON WHERE NgayThu between '" + datengay2.ToString("yyyy-MM-dd") + "' and '" + datengay1.ToString("yyyy-MM-dd") + "' GROUP BY NgayThu";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            conn.Open();
            da.Fill(dt);
            chart1.Titles.Add("Hoạt động thu chi trong 7 ngày vừa qua");
            chart1.ChartAreas["ChartArea1"].AxisX.Title = "Ngày";
            chart1.ChartAreas["ChartArea1"].AxisY.Title = "Doanh thu";
            chart1.ChartAreas["ChartArea1"].AxisX.Interval = 1;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                chart1.Series["Tổng thu"].Points.AddXY(dt.Rows[i]["NgayThu"], dt.Rows[i]["Tong"]);
            }
            conn.Close();

            query = "SELECT NgayNhap, SUM(TongTien) as Tong FROM PHIEUNHAP WHERE NgayNhap between '" + datengay2.ToString("yyyy-MM-dd") + "' and '" + datengay1.ToString("yyyy-MM-dd") + "' GROUP BY NgayNhap";
            DataTable dt1 = new DataTable();
            SqlDataAdapter da1 = new SqlDataAdapter(query, conn);
            conn.Open();
            da1.Fill(dt1);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                chart1.Series["Tổng chi"].Points.AddXY(dt1.Rows[i]["NgayNhap"], dt1.Rows[i]["Tong"]);
            }
            conn.Close();

            query = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE NgayNhap ='" + datengay1.ToString("yyyy-MM-dd") + "'";
            label11.Text = HienThi(query);

            query = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE NgayThu ='" + datengay1.ToString("yyyy-MM-dd") + "'";
            label9.Text = HienThi(query);

            query = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE NgayNhap ='" + datengay3.ToString("yyyy-MM-dd") + "'";
            label13.Text = HienThi(query);

            query = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE NgayThu ='" + datengay3.ToString("yyyy-MM-dd") + "'";
            label12.Text = HienThi(query);

            if (label11.Text == string.Empty)
            {
                label11.Text = "0";
            }
            if (label9.Text == string.Empty)
            {
                label9.Text = "0";
            }
            if (label12.Text == string.Empty)
            {
                label12.Text = "0";
            }
            if (label13.Text == string.Empty)
            {
                label13.Text = "0";
            }

            int loinhuan1 = int.Parse(label9.Text) - int.Parse(label11.Text);
            label10.Text = loinhuan1.ToString();
            int loinhuan2 = int.Parse(label12.Text) - int.Parse(label13.Text);
            label14.Text = loinhuan2.ToString();

            label9.Text += " VNĐ";
            label10.Text += " VNĐ";
            label11.Text += " VNĐ";
            label12.Text += " VNĐ";
            label13.Text += " VNĐ";
            label14.Text += " VNĐ";

            label3.Text += datengay1.ToString(" dd-MM-yyyy");
        }

        private void guna2PictureBox1_Click(object sender, EventArgs e)
        {
            chart1.Titles.Clear();
            BDNgayTuan_Load(sender, e);
        }
    }
}
