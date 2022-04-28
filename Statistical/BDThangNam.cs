using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt.Statistical
{
    public partial class BDThangNam : UserControl
    {
        public BDThangNam()
        {
            InitializeComponent();
            label25.Text += datethang1.ToString(" MM-yyyy");
            label26.Text += datenam1.ToString(" yyyy");
        }

        SqlConnection conn = new SqlConnection(Data_Provider.connectionSTR);
        string query;
        string text;
        DateTime datethang1 = DateTime.Now;
        DateTime datethang2 = DateTime.Now.Date.AddMonths(-3);
        DateTime datethang3 = DateTime.Now.Date.AddMonths(-1);

        DateTime datenam1 = DateTime.Now;
        DateTime datenam2 = DateTime.Now.Date.AddYears(-3);
        DateTime datenam3 = DateTime.Now.Date.AddYears(-1);

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

        private void BDThang()
        {
            //bieu do 3 thang gần nhất
            query = "SELECT MONTH(NgayThu) as ThangThu, SUM(TongTien) as Tong FROM HOADON WHERE MONTH(NgayThu) >= " + datethang2.ToString("MM") + " and MONTH(NgayThu) <= " + datethang1.ToString("MM") + " GROUP BY MONTH(NgayThu)";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            conn.Open();
            da.Fill(dt);
            chart1.Titles.Add("Hoạt động thu chi trong 3 tháng vừa qua");
            chart1.ChartAreas["ChartArea1"].AxisX.Title = "Tháng";
            chart1.ChartAreas["ChartArea1"].AxisY.Title = "Doanh thu";
            chart1.ChartAreas["ChartArea1"].AxisX.Interval = 1;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                chart1.Series["Tổng thu"].Points.AddXY(dt.Rows[i]["ThangThu"], dt.Rows[i]["Tong"]);
            }
            conn.Close();

            query = "SELECT MONTH(NgayNhap) as ThangNhap, SUM(TongTien) as Tong FROM PHIEUNHAP WHERE MONTH(NgayNhap) >= " + datethang2.ToString("MM") + " and MONTH(NgayNhap) <= " + datethang1.ToString("MM") + " GROUP BY MONTH(NgayNhap)";
            DataTable dt1 = new DataTable();
            SqlDataAdapter da1 = new SqlDataAdapter(query, conn);
            conn.Open();
            da1.Fill(dt1);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                chart1.Series["Tổng chi"].Points.AddXY(dt1.Rows[i]["ThangNhap"], dt1.Rows[i]["Tong"]);
            }
            conn.Close();
        }

        private void ThongKeThang()
        {
            query = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE MONTH(NgayNhap) = " + datethang1.ToString("MM");
            label11.Text = HienThi(query);

            query = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE MONTH(NgayThu) = " + datethang1.ToString("MM");
            label9.Text = HienThi(query);

            query = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE MONTH(NgayNhap) = " + datethang3.ToString("MM");
            label13.Text = HienThi(query);

            query = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE MONTH(NgayThu) = " + datethang3.ToString("MM");
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


        }

        private void BDNam()
        {
            //bieu do 3 năm gần nhất
            query = "SELECT YEAR(NgayThu) as NamThu, SUM(TongTien) as Tong FROM HOADON WHERE YEAR(NgayThu) >= " + datenam2.ToString("yyyy") + " and YEAR(NgayThu) <= " + datenam1.ToString("yyyy") + " GROUP BY YEAR(NgayThu)";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            conn.Open();
            da.Fill(dt);
            chart2.Titles.Add("Hoạt động thu chi trong 3 năm vừa qua");
            chart2.ChartAreas["ChartArea1"].AxisX.Title = "Năm";
            chart2.ChartAreas["ChartArea1"].AxisY.Title = "Doanh thu";
            chart2.ChartAreas["ChartArea1"].AxisX.Interval = 1;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                chart2.Series["Tổng thu"].Points.AddXY(dt.Rows[i]["NamThu"], dt.Rows[i]["Tong"]);
            }
            conn.Close();

            query = "SELECT YEAR(NgayNhap) as NamNhap, SUM(TongTien) as Tong FROM PHIEUNHAP WHERE YEAR(NgayNhap) >= " + datenam2.ToString("yyyy") + " and YEAR(NgayNhap) <= " + datenam1.ToString("yyyy") + " GROUP BY YEAR(NgayNhap)";
            DataTable dt1 = new DataTable();
            SqlDataAdapter da1 = new SqlDataAdapter(query, conn);
            conn.Open();
            da1.Fill(dt1);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                chart2.Series["Tổng chi"].Points.AddXY(dt1.Rows[i]["NamNhap"], dt1.Rows[i]["Tong"]);
            }
            conn.Close();
        }

        private void ThongKeNam()
        {
            query = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE YEAR(NgayNhap) = " + datenam1.ToString("yyyy");
            label17.Text = HienThi(query);

            query = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE YEAR(NgayThu) = " + datenam1.ToString("yyyy");
            label19.Text = HienThi(query);

            query = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE YEAR(NgayNhap) = " + datenam3.ToString("yyyy");
            label15.Text = HienThi(query);

            query = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE MONTH(NgayThu) = " + datenam3.ToString("yyyy");
            label16.Text = HienThi(query);

            if (label17.Text == string.Empty)
            {
                label17.Text = "0";
            }
            if (label19.Text == string.Empty)
            {
                label19.Text = "0";
            }
            if (label15.Text == string.Empty)
            {
                label15.Text = "0";
            }
            if (label16.Text == string.Empty)
            {
                label16.Text = "0";
            }

            int loinhuan1 = int.Parse(label19.Text) - int.Parse(label17.Text);
            label18.Text = loinhuan1.ToString();
            int loinhuan2 = int.Parse(label16.Text) - int.Parse(label15.Text);
            label3.Text = loinhuan2.ToString();

            label3.Text += " VNĐ";
            label15.Text += " VNĐ";
            label16.Text += " VNĐ";
            label17.Text += " VNĐ";
            label18.Text += " VNĐ";
            label19.Text += " VNĐ";
        }

        private void guna2PictureBox1_Click(object sender, EventArgs e)
        {
            BDThangNam_Load(sender, e);
        }

        private void BDThangNam_Load(object sender, EventArgs e)
        {
            chart1.Titles.Clear();
            BDThang();
            ThongKeThang();

            chart2.Titles.Clear();
            BDNam();
            ThongKeNam();
        }
    }
}
