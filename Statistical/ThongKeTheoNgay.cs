using System.Windows.Forms;

namespace QLnhahang_anhttt.Statistical
{
    public partial class ThongKeTheoNgay : UserControl
    {
        public ThongKeTheoNgay()
        {
            InitializeComponent();
        }

        private void HienThi()
        {
            /*string constr = Data_Provider.connectionSTR;
            string Sql = "select mancc from nhacungcap";
            using (SqlConnection conn = new SqlConnection(constr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(Sql, conn);
                SqlDataReader DR = cmd.ExecuteReader();

                while (DR.Read())
                {
                    txtMaNCC.Items.Add(DR[0]);

                }
                DR.Close();
                conn.Close();
                conn.Open();
                Sql = "select manv from nhanvien";
                SqlCommand cmd2 = new SqlCommand(Sql, conn);
                SqlDataReader DR2 = cmd2.ExecuteReader();

                while (DR2.Read())
                {
                    txtMaNV.Items.Add(DR2[0]);

                }
                DR.Close();
                conn.Close();
                conn.Open();
                Sql = "select tennl from nguyenlieu";
                SqlCommand cmd3 = new SqlCommand(Sql, conn);
                SqlDataReader DR3 = cmd3.ExecuteReader();

                while (DR3.Read())
                {
                    txtTenNL.Items.Add(DR3[0]);
                }
                DR.Close();
                conn.Close();*/
        }
    }
}
