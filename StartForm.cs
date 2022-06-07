using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt
{
    public partial class StartForm : Form
    {
        public StartForm()
        {
            InitializeComponent();
            toolTip1.ShowAlways = true;
            toolTip1.SetToolTip(guna2PictureBox2, "Tìm kiếm");
            toolTip1.SetToolTip(btnSignOut, "Đăng nhập vào hệ thống quản lý nhà hàng");
        }

        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        int newLocationX;
        int newLocationY;

        void connectTable()
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("select * from BAN", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);

            dtgvTable.DataSource = dtb;
            dtgvTable.AutoGenerateColumns = false;
            dtgvTable.AllowUserToAddRows = false;
            dtgvTable.AutoResizeColumns();

            sqlCon.Close();
        }

        private void loadban()
        {
            //  pnlBook.Controls.Clear();
            // lấy data lên bảng datatable
            DataTable dsBan = Data_Provider.GetDataTable("select * from BAN");
            //add các button với thông tin của bàn vào form, set màu cho các bàn đã có ng và chưa có ng
            foreach (DataRow item in dsBan.Rows)
            {
                // set độ lớn cho button
                Button btn = new Button() { Width = 110, Height = 110 };
                // hiển thị thông tin bàn từ csdl lên button
                btn.Text = "Bàn " + item["SoHieuBan"] + " ( " + item["SoGhe"] + " ghế )" + Environment.NewLine + item["TinhTrang"];

                btn.BackgroundImage = Image.FromFile(@"D:\QLNhaHang\Food\\food\pngtree-white-restaurant-table-image_2234080-removebg-preview.png");

                int newSize = 10;
                btn.Font = new Font(btn.Font.FontFamily, newSize);
                btn.ForeColor = Color.Black;
                btn.BackgroundImageLayout = ImageLayout.Stretch;
                btn.Cursor = Cursors.Hand;
                //gắn tag để xđ id bàn
                btn.Tag = item["soHieuBan"]; // so hieu ban

                btn.Click += btn_Click;


                btn.FlatStyle = FlatStyle.Flat;
                btn.FlatAppearance.BorderColor = Color.DarkGray;
                btn.FlatAppearance.BorderSize = 3;

                // màu cho bàn có ng
                if (item["tinhTrang"].ToString().Trim() == "FULL")
                {
                    btn.FlatStyle = FlatStyle.Flat;
                    btn.FlatAppearance.BorderColor = Color.Red;
                    btn.ForeColor = Color.Red;
                    btn.FlatAppearance.BorderSize = 3;
                    btn.BackColor = Color.Red;
                }
                else if (item["tinhTrang"].ToString().Trim() == "BOOKED")
                {
                    btn.FlatStyle = FlatStyle.Flat;
                    btn.FlatAppearance.BorderColor = Color.Blue;
                    btn.ForeColor = Color.Blue;
                    btn.FlatAppearance.BorderSize = 3;
                    btn.BackColor = Color.Blue;
                }
                //  set màu cho bàn trống
                else
                {
                    btn.BackColor = Color.Silver;
                }

                flowLayoutTable.Controls.Add(btn);
            }
            dtgvTable.AllowUserToAddRows = false;
            dtgvTable.AutoGenerateColumns = true;
            dtgvTable.DataSource = dsBan;
        }

        public static FoodMenu[] menu;
        public static int index;
        public void HienThiMon()
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM MONAN", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            sqlCon.Close();

            int rows = dtb.Rows.Count;
            index = 0;
            menu = new FoodMenu[rows];
            foreach (DataRow row in dtb.Rows)
            {
                menu[index] = new FoodMenu(this);
                menu[index].Price = row["DonGia"].ToString();
                menu[index].name = row["TenMon"].ToString();
                string path = row["pathimage"].ToString();
                try
                {
                    if (path == "")
                        menu[index].Background = Image.FromFile(@"D:\QLNhaHang\Food\food\menufood.png"); // Chỉnh tùy máy
                    else
                        menu[index].Background = Image.FromFile(path);
                }
                catch
                {
                }

                if (flowLayoutPnlMenu.Controls.Count < 0)
                {
                    flowLayoutPnlMenu.Controls.Clear();
                }
                else
                {
                    flowLayoutPnlMenu.Controls.Add(menu[index]);
                    flowLayoutPnlMenu.Controls.SetChildIndex(menu[index], index); // set index of added Menu
                }
                index += 1;
            }
        }

        public void HienThiMon(string query)
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter(query, sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            sqlCon.Close();

            int rows = dtb.Rows.Count;
            index = 0;
            menu = new FoodMenu[rows];
            foreach (DataRow row in dtb.Rows)
            {
                menu[index] = new FoodMenu(this);
                menu[index].Price = row["DonGia"].ToString();
                menu[index].name = row["TenMon"].ToString();
                string path = row["pathimage"].ToString();
                try
                {
                    if (path == "")
                        menu[index].Background = Image.FromFile(@"D:\QLNhaHang\Food\food\menufood.png"); // Chỉnh tùy máy
                    else
                        menu[index].Background = Image.FromFile(path);
                }
                catch
                {
                }

                if (flowLayoutPnlMenu.Controls.Count < 0)
                {
                    flowLayoutPnlMenu.Controls.Clear();
                }
                else
                {
                    flowLayoutPnlMenu.Controls.Add(menu[index]);
                    flowLayoutPnlMenu.Controls.SetChildIndex(menu[index], index); // set index of added Menu
                }
                index += 1;
            }
        }

        string query;
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

        void btn_Click(object sender, EventArgs e)
        {
            string id_Ban = Convert.ToString((sender as Button).Tag);
            query = "Select tinhtrang from ban where sohieuban = '" + id_Ban + "'";

            if (HienThi(query).Contains("FULL"))
            {
                MessageBox.Show("Bàn đã có người ngồi", "Thông tin", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            if (HienThi(query).Contains("BOOKED"))
            {
                MessageBox.Show("Bàn đã có người đặt", "Thông tin", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            if (HienThi(query).Contains("NONE"))
            {

            }
        }

        private void StartForm_Load(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnIntroduce.Height;
            sidePanel.Top = guna2GradientTileBtnIntroduce.Top;
            introduce1.BringToFront();
        }

        private void guna2GradientTileBtnIntroduce_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnIntroduce.Height;
            sidePanel.Top = guna2GradientTileBtnIntroduce.Top;
            introduce1.BringToFront();
        }

        private void guna2GradientTileBtnFood_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnFood.Height;
            sidePanel.Top = guna2GradientTileBtnFood.Top;
            flowLayoutPnlMenu.Controls.Clear();
            guna2PanelTable.SendToBack();
            guna2PanelFood.BringToFront();
            HienThiMon();
        }

        private void guna2GradientTileBtnHome_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnHome.Height;
            sidePanel.Top = guna2GradientTileBtnHome.Top;
            mainPage1.BringToFront();
        }

        private void guna2TextBoxSearch_TextChanged(object sender, EventArgs e)
        {
            guna2TextBoxSearch.Text = String.Empty;
        }

        private void guna2Table_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2Table.Height;
            sidePanel.Top = guna2Table.Top;
            flowLayoutTable.Controls.Clear();
            guna2PanelFood.SendToBack();
            guna2PanelTable.BringToFront();
            connectTable();
            loadban();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            flowLayoutTable.Controls.Clear();
            loadban();
        }

        private void btnSignOut_Click(object sender, EventArgs e)
        {
            loginform frm = new loginform();
            this.Hide();
            frm.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            flowLayoutPnlMenu.Controls.Clear();
            index = 0;
            HienThiMon();
        }

        private void guna2PictureBox2_Click(object sender, EventArgs e)
        {
            flowLayoutPnlMenu.Controls.Clear();
            index = 0;
            query = "SELECT * FROM MONAN WHERE 1 = 1 ";
            if (cbbMon.Text == "Pizza")
            {
                query += " and mamonan LIKE '%pz%'";
            }
            if (cbbMon.Text == "Humberger")
            {
                query += " and mamonan LIKE '%br%'";
            }
            if (cbbMon.Text == "Cake")
            {
                query += " and mamonan LIKE '%cake%'";
            }
            if (cbbMon.Text == "Drink")
            {
                query += " and mamonan LIKE '%nu%'";
            }
            if (cbbGia.Text == "0-100k")
            {
                query += " and dongia > 0 and dongia <= 100000";
            }
            if (cbbGia.Text == "100-200k")
            {
                query += " and dongia > 100000 and dongia <= 200000";
            }
            if (cbbGia.Text == ">200k")
            {
                query += " and dongia > 200000";
            }
            HienThiMon(query);
        }

        private void pnl1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button != MouseButtons.Left)
                return;
            newLocationX = e.X;
            newLocationY = e.Y;
        }

        private void pnl1_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button != MouseButtons.Left)
                return;

            Left = Left + (e.X - newLocationX);
            Top = Top + (e.Y - newLocationY);
        }
    }
}
