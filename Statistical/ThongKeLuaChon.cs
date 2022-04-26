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
            string query1 = "select ma.TenMon from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p where ma.MaMonAn = pyc.MaMonAn and pyc.SoPYC = p.SoPYC and p.NgayXuat between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "' group by ma.TenMon having count(pyc.SoPYC) >= all(select count(pyc.SoPYC) from MONAN as ma, CHITIETPYC as pyc, PHIEUYEUCAU as p where ma.MaMonAn = pyc.MaMonAn and pyc.SoPYC = p.SoPYC and p.NgayXuat between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "' group by ma.TenMon)";
            label9.Text = HienThi(query1);

            string query2 = "SELECT M.TenMon FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC WHERE NgayXuat between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "' GROUP BY M.TenMon, M.DonGia, P.SoLuong HAVING (M.DonGia *P.SoLuong) >= ALL (SELECT (M.DonGia *P.SoLuong) FROM MONAN M JOIN CHITIETPYC  P ON M.MAMonAn = P.MaMonAn JOIN PHIEUYEUCAU P2 ON P.SoPYC = P2.SoPYC WHERE NgayXuat between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "')";
            label10.Text = HienThi(query2);

            string query3 = "SELECT COUNT(SoPN) SoLuotPN FROM PHIEUNHAP WHERE NgayNhap between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "'";
            label11.Text = HienThi(query3);

            string query4 = "SELECT COUNT(SoPX) SoLuotPX FROM PHIEUXUAT WHERE NgayXuat between'" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "'";
            label12.Text = HienThi(query4);

            string query5 = "SELECT COUNT(MaHD) FROM HOADON WHERE NgayThu between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "'";
            label13.Text = HienThi(query5);


            string query6 = "select nv.HoTen from NHANVIEN as nv, HOADON as hd  where (nv.MaNV = hd.MaNV and hd.NgayThu between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "') group by nv.HoTen having (count(hd.MaHD)) >=  all (select count(hd.MaHD) from NHANVIEN as nv, HOADON as hd where (nv.MaNV = hd.MaNV and hd.NgayThu between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "') group by nv.HoTen)";
            label14.Text = HienThi(query6);

            string query7 = "SELECT K.TenKH FROM KHACHHANG K, HOADON H WHERE K.MaKH = H.MaKH AND NgayThu between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "' GROUP BY K.TenKH HAVING SUM(TONGTIEN)>= ALL (SELECT (SUM(TONGTIEN)) FROM  KHACHHANG A, HOADON B WHERE A.MaKH = B.MaKH AND NgayThu between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "' GROUP BY A.TenKH)";
            label15.Text = HienThi(query7);

            string query8 = "SELECT SUM(TongTien) FROM PHIEUNHAP WHERE NgayNhap between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "'";
            label2.Text = HienThi(query8) + " VNĐ";

            string query9 = "SELECT SUM(TongTien) TongTien FROM HOADON WHERE NgayThu between '" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "' and '" + guna2DateTimePicker2.Value.ToString("yyyy-MM-dd") + "'";
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
