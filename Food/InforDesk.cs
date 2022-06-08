using QLnhahang_anhttt.Data;
using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;

namespace QLnhahang_anhttt.Food
{
    public partial class InforDesk : Form
    {
        Foods food;
        string sohieuban;
        public InforDesk(Foods frm, string id_ban)
        {
            InitializeComponent();
            this.food = frm;
            this.sohieuban = id_ban;
        }
        private void clear()
        {
            guna2TxtCouponNumber.Text = "";
            guna2TxtCode.Text = "";
            guna2TxtCusAddress.Text = "";
            guna2TxtCusName.Text = "";
            guna2TxtCusPhone.Text = "";
        }

        private void loadban()
        {
            food.flowLayoutPnlMenu.Controls.Clear();
            // lấy data lên bảng datatable
            DataTable dsBan = Data_Provider.GetDataTable("select * from BAN");
            //add các button với thông tin của bàn vào form, set màu cho các bàn đã có ng và chưa có ng
            foreach (DataRow item in dsBan.Rows)
            {
                // set độ lớn cho button
                Button btn = new Button() { Width = 110, Height = 110 };
                // hiển thị thông tin bàn từ csdl lên button
                btn.Text = "Bàn " + item["soHieuBan"] + " ( " + item["soGhe"] + " ghế )" + Environment.NewLine + item["tinhTrang"];
                btn.BackgroundImage = Image.FromFile(@"D:\food\pngtree-white-restaurant-table-image_2234080-removebg-preview.png");
                int newSize = 10;
                btn.Font = new Font(btn.Font.FontFamily, newSize);
                btn.ForeColor = Color.Black;
                btn.BackgroundImageLayout = ImageLayout.Stretch;
                btn.Cursor = Cursors.Hand;
                //gắn tag để xđ id bàn
                btn.Tag = item["soHieuBan"]; // so hieu ban
                // thêm sự kiện click button
                btn.Click += btn_Click;
                btn.FlatStyle = FlatStyle.Flat;
                btn.FlatAppearance.BorderColor = Color.Silver;
                btn.FlatAppearance.BorderSize = 3;

                // set màu cho bàn trống
                if (item["tinhTrang"].ToString() == "FULL")
                {
                    btn.FlatStyle = FlatStyle.Flat;
                    btn.FlatAppearance.BorderColor = Color.Red;
                    btn.FlatAppearance.BorderSize = 3;
                    btn.ForeColor = Color.Black;
                    btn.BackColor = Color.Tomato;
                }
                // màu cho bàn có ng
                else
                {
                    btn.BackColor = Color.Silver;
                }

                food.flowLayoutPnlMenu.Controls.Add(btn);
            }
            food.dataGridViewTable.AllowUserToAddRows = false;
            food.dataGridViewTable.AutoGenerateColumns = true;
            food.dataGridViewTable.DataSource = dsBan;
        }
  

        private void btnCloseTable_Click(object sender, EventArgs e)
        {
         // clear();
            food.flowPnlinfortable.SendToBack();

        }
        private void btn_Click(object sender, EventArgs e)
        {
            string id_Ban = Convert.ToString((sender as Button).Tag);
            InforDesk infortable = new InforDesk(food, id_Ban) { TopLevel = false, TopMost = true };
            infortable.StartPosition = FormStartPosition.CenterParent;
            food.flowPnlinfortable.Controls.Add(infortable);
            infortable.Show();
            food.flowPnlinfortable.BringToFront();
        }


        private void InforDesk_Load(object sender, EventArgs e)
        {
            DataTable data = Data_Provider.GetDataTable("select * from getInforCus( '" + sohieuban + "');");
         //   DataTable data = Data_Provider.GetDataTable("select PHIEUYEUCAU.soPYC,KHACHHANG.maKH,tenKH,soDienThoai,diaChi from PHIEUYEUCAU,KHACHHANG, BAN where BAN.SoHieuBan = PHIEUYEUCAU.SoHieuBan and PHIEUYEUCAU.maKH=KHACHHANG.maKH and  PHIEUYEUCAU.LOAI = N'2' and PHIEUYEUCAU.sohieuban = '" + sohieuban + "'");
            foreach (DataRow dr in data.Rows)
            {
                guna2TxtCouponNumber.Text = dr["soPYC"].ToString();
                guna2TxtCode.Text = dr["maKH"].ToString();
                guna2TxtCusName.Text = dr["tenKH"].ToString();
                guna2TxtCusPhone.Text = dr["soDienThoai"].ToString();
                guna2TxtCusAddress.Text = dr["diaChi"].ToString();
            }
        }

        private void guna2BtnCancelTable_Click(object sender, EventArgs e)
        {
            // update lai tinh trang ban;
          /*  Data_Provider.exc("exec update_ban ('" + guna2TxtCouponNumber.Text + "');");
            loadban();
            clear();*/
            food.flowPnlinfortable.SendToBack();
        }

        private void btnShowBill_Click(object sender, EventArgs e)
        {
            try
            {
                food.pnlBill.Visible = true;
            }
            catch
            {
                MessageBox.Show(e.ToString());
            }
           // food.pnlBill.Visible = true;
            //food.pnlBill.BringToFront();
        }
    }
}
