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

        public static DateTime GetFirstDayOfMonth(DateTime dtInput)
        {
            DateTime dtResult = dtInput;
            dtResult = dtResult.AddDays((-dtResult.Day) + 1);
            return dtResult;
        }
        public DateTime GetLastDayOfMonth(DateTime dtInput)
        {
            DateTime dtResult = dtInput;
            dtResult = dtResult.AddMonths(1);
            dtResult = dtResult.AddDays(-(dtResult.Day));
            return dtResult;
        }

        private void ThongKeTheoThang_Load(object sender, System.EventArgs e)
        {

            DateTime dt1 = GetFirstDayOfMonth(guna2DateTimePicker1.Value);
            DateTime dt2 = GetLastDayOfMonth(guna2DateTimePicker1.Value);

            string query1 = "select ma.TenMon from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p where ma.MaMonAn = pyc.MaMonAn and pyc.SoPYC = p.SoPYC and p.NgayXuat between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "' group by ma.TenMon having count(pyc.SoPYC) >= all(select count(pyc.SoPYC) from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p where ma.MaMonAn = pyc.MaMonAn and pyc.SoPYC = p.SoPYC and p.NgayXuat between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "' group by ma.TenMon)";
            label9.Text = HienThi(query1);

            string query2 = "SELECT M.TenMon FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC WHERE NgayXuat between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "' GROUP BY M.TenMon, M.DonGia, P.SoLuong HAVING (M.DonGia *P.SoLuong) >= ALL (SELECT (M.DonGia *P.SoLuong) FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC WHERE NgayXuat between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "')";
            label10.Text = HienThi(query2);

            string query3 = "SELECT COUNT(SoPN) SoLuotPN FROM PHIEUNHAP WHERE NgayNhap between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "'";
            label11.Text = HienThi(query3);

            string query4 = "SELECT COUNT(SoPX) SoLuotPX FROM PHIEUXUAT WHERE NgayXuat between'" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "'";
            label12.Text = HienThi(query4);

            string query5 = "SELECT COUNT(MaHD) FROM HOADON WHERE NgayThu between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "'";
            label13.Text = HienThi(query5);


            string query6 = "select nv.HoTen from NHANVIEN as nv, HOADON as hd  where (nv.MaNV = hd.MaNV and hd.NgayThu between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "') group by nv.HoTen having (count(hd.MaHD)) >=  all (select count(hd.MaHD) from NHANVIEN as nv, HOADON as hd where (nv.MaNV = hd.MaNV and hd.NgayThu between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "') group by nv.HoTen)";
            label14.Text = HienThi(query6);

            string query7 = "SELECT K.TenKH FROM KHACHHANG K, HOADON H WHERE K.MaKH = H.MaKH AND NgayThu between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "' GROUP BY K.TenKH HAVING SUM(TONGTIEN)>= ALL (SELECT (SUM(TONGTIEN)) FROM  KHACHHANG A, HOADON B WHERE A.MaKH = B.MaKH AND NgayThu between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "' GROUP BY A.TenKH)";
            label15.Text = HienThi(query7);

            string query8 = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE NgayNhap between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "'";
            label19.Text = HienThi(query8) + " VNĐ";

            string query9 = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE NgayThu between '" + dt1.ToString("yyyy-MM-dd") + "' and '" + dt2.ToString("yyyy-MM-dd") + "'";
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
