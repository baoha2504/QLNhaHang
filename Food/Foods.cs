using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using System.Linq;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;



namespace QLnhahang_anhttt.Food
{
    public partial class Foods : UserControl
    {
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        public static string workingDirectory = Environment.CurrentDirectory;
        //public string rootDir = Directory.GetParent(workingDirectory).Parent.FullName;

        public static SelectedFood[] paymentlist = new SelectedFood[100];

        public static FoodMenu[] menu;
        public string pyc;
        public static long tongtam = 0;
        public static long tong = 0;
        public static string sdt;
        public static string tenkm = "Không", mucgiam = "0";
        public static int index = 0;

        void connectTable()
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("select * from BAN", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);

            dataGridViewTable.DataSource = dtb;
            dataGridViewTable.AutoGenerateColumns = false;
            dataGridViewTable.AllowUserToAddRows = false;
            dataGridViewTable.AutoResizeColumns();
            
            sqlCon.Close();
        }


        public Foods()
        {
            InitializeComponent();
            sildePanelFood.Height = btnCallFood.Height;
            sildePanelFood.Top = btnCallFood.Top;
            pnlBill.Visible = false;
            pnlOrder.Visible = true;
            //    populateItems();
            HienThi();

        }

        //Order



        private void guna2TileBtnCallFood_Click(object sender, EventArgs e)
        {
            sildePanelFood.Height = btnCallFood.Height;
            sildePanelFood.Top = btnCallFood.Top;
            pnlOrder.BringToFront();
            pnlOrder.Visible = true;
            pnlBill.Visible = false;
        }

        public void HienThi()
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM MONAN", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            sqlCon.Close();

            int rows = dtb.Rows.Count;
            menu = new FoodMenu[rows];
            index = 0;
            foreach (DataRow row in dtb.Rows)
            {
                menu[index] = new FoodMenu(this);
                menu[index].Price = row["DonGia"].ToString();
                menu[index].name = row["TenMon"].ToString();
                string path = row["pathimage"].ToString();

                if (path == "")
                    menu[index].Background = Image.FromFile(@"D:\QLNhaHang\Food\food\menufood.png"); // Chỉnh tùy máy
                else
                    menu[index].Background = Image.FromFile(path);
                /*try
                {
                    if (path == "")
                        menu[index].Background = Image.FromFile(@"D:\food\menufood.png"); // Chỉnh tùy máy
                    else
                        menu[index].Background = Image.FromFile(path);
                }
                catch (Exception ex)
                {
                    menu[index].Background = Image.FromFile(rootDir + @"D:\food\menufood.png"); // Chỉnh tùy máy
                }*/

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

        private void reset_panel()
        {
            flowLayoutPnl_Selected.Controls.Clear(); // payment
            FoodMenu.count = 0;

            // Enable LinePanel correspond
            for (int j = 0; j < index; j++)
            {
                menu[j].guna2Panel2_valid.Visible = false;
                menu[j].panel2_valid.Visible = false;
            }
            lblSub_menu.Text = "0";

        }


        //Booking


        private void btnBooking_Click(object sender, EventArgs e)
        {
            sildePanelFood.Height = btnBooking.Height;
            sildePanelFood.Top = btnBooking.Top;
            pnlBill.Visible = false;
            pnlOrder.Visible = false;
            pnlBook.Visible = true;
            
            connectTable();
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

                btn.BackgroundImage = Image.FromFile(@"D:\QLNhaHang\Food\food\pngtree-white-restaurant-table-image_2234080-removebg-preview.png");

                int newSize = 10;
                btn.Font = new Font(btn.Font.FontFamily, newSize);
                btn.ForeColor = Color.Black;
                btn.BackgroundImageLayout = ImageLayout.Stretch;
                btn.Cursor = Cursors.Hand;
                //gắn tag để xđ id bàn
                btn.Tag = item["soHieuBan"]; // so hieu ban

                // thêm sự kiện click button
                //btn.MouseHover += new EventHandler(btn_MouseHover);

                btn.Click += btn_Click;

                btn.FlatStyle = FlatStyle.Flat;
                btn.FlatAppearance.BorderColor = Color.Gray;
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
            dataGridViewTable.AllowUserToAddRows = false;
            dataGridViewTable.AutoGenerateColumns = true;
            dataGridViewTable.DataSource = dsBan;
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
            textBox1.Text = HienThi(query);

            if (textBox1.Text.Contains("FULL"))
            {
                DialogResult result = MessageBox.Show("Thanh toán bàn này?","Thông báo",MessageBoxButtons.YesNo,MessageBoxIcon.Question);
                if (result == DialogResult.Yes)
                {
                    sildePanelFood.Height = btnHD.Height;
                    sildePanelFood.Top = btnHD.Top;
                    pnlBill.BringToFront();
                    pnlOrder.Visible = false;
                    pnlBill.Visible = true;
                    pnlBook.Visible = false;
                    cbbDiscount.Enabled = false;
                    btnPayment_Bill.Enabled = false;
                    button1.Enabled = false;
                    loaddata(id_Ban);
                }
                else
                {
                    InforDesk infortable = new InforDesk(this, id_Ban) { TopLevel = false, TopMost = true };
                    // infortable.StartPosition = FormStartPosition.CenterScreen;
                    flowPnlinfortable.Controls.Add(infortable);
                    infortable.FormBorderStyle = FormBorderStyle.None;
                    flowPnlinfortable.BringToFront();
                    infortable.Show();
                }
               
            }
            if (textBox1.Text.Contains("NONE") || textBox1.Text.Contains("BOOKED"))
            {
                sildePanelFood.Height = btnCallFood.Height;
                sildePanelFood.Top = btnCallFood.Top;
                pnlOrder.BringToFront();
                pnlOrder.Visible = true;
                cbbTableID_Order.Text = id_Ban;
                sqlCon.Close();
                sqlCon.Open();
                SqlCommand command = new SqlCommand("Select dbo.Auto_SoPYC()", sqlCon);
                command.ExecuteNonQuery();
                txtOrderID_Order.Text = command.ExecuteScalar().ToString();
                sqlCon.Close();
                pnlBook.SendToBack();
                pnlBill.SendToBack();
            }

        }
     
        //Bill

        private void btnHD_Click(object sender, EventArgs e)
        {
            sildePanelFood.Height = btnHD.Height;
            sildePanelFood.Top = btnHD.Top;
            pnlBill.BringToFront();
            pnlOrder.Visible = false;
            pnlBill.Visible = true;
            pnlBook.Visible = false;
            cbbDiscount.Enabled = false;
            btnPayment_Bill.Enabled = false;
            button1.Enabled = false;
            loaddata();
        }

        public void loaddata(string sohieuban)
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("select * from PHIEUYEUCAU where loai='2' and sohieuban = '" + sohieuban + "'", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dsyc.DataSource = dtb;
            dsyc.AutoGenerateColumns = false;
            dsyc.AllowUserToAddRows = false;
            sqlCon.Close();
        }

        public void loaddata()
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("select * from PHIEUYEUCAU where loai='2'", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            dsyc.DataSource = dtb;
            dsyc.AutoGenerateColumns = false;
            dsyc.AllowUserToAddRows = false;
            sqlCon.Close();
        }

        public void Load_cbbTableID()
        {
          /*  sqlCon.Open();
            SqlDataReader myReader = null;
            SqlCommand myCommand = new SqlCommand("select SoHieuBan from BAN where tinhtrang='X'", sqlCon);
            myReader = myCommand.ExecuteReader();
            while (myReader.Read())
            {
                cbbTableID_Order.Text = myReader["SoHieuBan"].ToString();
                cbbTableID_Order.Enabled = false;
            }
            sqlCon.Close();
            if (cbbTableID_Order.Text == "")*/
            {
                sqlCon.Open();
                cbbTableID_Order.Enabled = true;
                SqlDataAdapter ban = new SqlDataAdapter("select SoHieuBan from BAN where tinhtrang='NONE'", sqlCon);
                DataTable b = new DataTable();
                ban.Fill(b);
                cbbTableID_Order.DataSource = b;
                cbbTableID_Order.DisplayMember = "SoHieuBan";
                cbbTableID_Order.ValueMember = "SoHieuBan";
                cbbTableID_Order.Text = "Chọn bàn";
                sqlCon.Close();
            }
           
            
        }


        //something

        private void btnAddFood_Click(object sender, EventArgs e)
        {
            sildePanelFood.Height = btnAddFood.Height;
            sildePanelFood.Top = btnAddFood.Top;
            Form frmAdd = new AddFood();
            frmAdd.ShowDialog();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            sildePanelFood.Height = btnDelete.Height;
            sildePanelFood.Top = btnDelete.Top;
            try
            {
                if (FoodMenu.sttclicked < 0)
                {
                    MessageBox.Show("Bạn hãy chọn món muôn xóa!!!");
                }
                else
                {
                    // Tạo trigger xóa các món kế thừa trc r mới xóa món ăn đc
                    
                    DialogResult dlr = MessageBox.Show("Xóa món đã chọn?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                    if (dlr == DialogResult.OK)
                    {
                        sqlCon.Open();
                        SqlCommand cmd = new SqlCommand("delete from MONAN where tenMon=N'" + menu[FoodMenu.sttclicked].name + "'and donGia='" + menu[FoodMenu.sttclicked].Price + "'", sqlCon);
                        cmd.ExecuteNonQuery();
                        sqlCon.Close();
                    }
                    menu = menu.Where((source, index) => index != FoodMenu.sttclicked).ToArray(); // xoa phan tu khoi array
                    flowLayoutPnlMenu.Controls.Clear();
                    index = 0; /// set lai gia tri index
                    HienThi();
                }
            } catch (Exception)
            {
                MessageBox.Show("Không thể xóa món", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.None);
            }
        }

        private void guna2VScrollBar3_Scroll(object sender, ScrollEventArgs e)
        {

        }

        private void btnCheck_Order_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM KHACHHANG where soDienThoai='" + txtPhone_Order.Text + "'", sqlCon);
                DataTable dtb = new DataTable();
                sqlDa.Fill(dtb);
                sqlCon.Close();

                if (dtb.Rows.Count > 0) // đã có thông tin 
                {
                    foreach (DataRow row in dtb.Rows)
                    {
                        lblName_Order.Text = row["TenKH"].ToString();
                        lblID_Order.Text = row["MaKH"].ToString();
                    }
                }
                else
                {
                    DialogResult dlr = MessageBox.Show("Không có thông tin khách hàng!!! \nBạn có muốn đăng ký thông tin không?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Question);
                    if (dlr == DialogResult.OK)
                    {
                        AddCustomer add = new AddCustomer();
                        add.ShowDialog();
                    }
                    else
                    {
                        MessageBox.Show("Xin vui lòng đăng ký thông tin để gọi món");
                    }
                }
            } catch
            {
                MessageBox.Show(e.ToString());
            }
        }

        private void btnAdd_Order_Click(object sender, EventArgs e)
        {
            DateTime dt = DateTime.Now;
            TimeSpan time = dt.TimeOfDay;
            string mamon = "";
            if (flowLayoutPnl_Selected.Controls.Count > 0)
            {
                if (!String.IsNullOrEmpty(txtPhone_Order.Text) && !string.IsNullOrEmpty(txtOrderID_Order.Text) && cbbTableID_Order.Text != "Chọn bàn")
                {
                    try
                    {
                        sqlCon.Open();

                        SqlCommand up = new SqlCommand();
                        up.Connection = sqlCon;
                        up.CommandText = "update BAN set tinhtrang = 'FULL' where SoHieuBan = '" + cbbTableID_Order.Text + "' ";
                        up.ExecuteNonQuery();


                        SqlCommand add1 = new SqlCommand();
                        add1.Connection = sqlCon;
                        add1.CommandText = "INSERT INTO PHIEUYEUCAU (SOPYC, NGAYXUAT, NGAYGIOYC, LOAI, MAKH, SOHIEUBAN) VALUES ('" + txtOrderID_Order.Text + "','" + dt.ToString("yyyy-MM-dd") + "','" + time.ToString() + "','2','" + lblID_Order.Text + "','" + cbbTableID_Order.Text + "')";
                        add1.ExecuteNonQuery();
                        sqlCon.Close();
                        for (int i = 0; i < FoodMenu.count; i++)
                        {
                            sqlCon.Open();
                            if (flowLayoutPnl_Selected.Controls[i].Name == "SelectedFood")
                            {
                                try
                                {
                                    SqlDataReader ma = null;
                                    SqlCommand macmd = new SqlCommand("select MaMonAn from MonAn where tenmon=N'" + paymentlist[i].lbl_name.Text + "'", sqlCon);
                                    ma = macmd.ExecuteReader();
                                    while (ma.Read())
                                    {
                                        mamon = ma["MaMonAn"].ToString();
                                    }
                                }
                                catch (Exception)
                                {
                                    MessageBox.Show(e.ToString());
                                }
                                sqlCon.Close();

                                sqlCon.Open();
                                SqlCommand add2 = new SqlCommand();
                                add2.Connection = sqlCon;
                                add2.CommandText = "INSERT INTO CHITIETPYC (SOPYC, MAMONAN, SOLUONG, DONGIA) VALUES('" + txtOrderID_Order.Text + "','" + mamon + "','" + paymentlist[i].guna2NumericUpDown1.Value + "','" + paymentlist[i].lbl_price.Text + "')";
                                add2.ExecuteNonQuery();
                                sqlCon.Close();
                                //MessageBox.Show("Order Successfully!!");
                            }
                        }
                        MessageBox.Show("Order Successfully!!");
                    } catch
                    {
                        MessageBox.Show("Vui lòng kiểm tra thông tin khách hàng trước khi gọi món", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                }
                else if (String.IsNullOrEmpty(txtPhone_Order.Text))
                {
                    MessageBox.Show("Vui lòng kiểm tra thông tin khách hàng trước khi gọi món", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    txtPhone_Order.Focus();
                }
                else if (string.IsNullOrEmpty(txtOrderID_Order.Text))
                {
                    MessageBox.Show("Vui lòng nhập số phiếu yêu cầu", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    txtOrderID_Order.Focus();
                }
                else if (cbbTableID_Order.Text == "Chọn bàn")
                {
                    MessageBox.Show("Vui lòng chọn bàn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
                else
                {
                    MessageBox.Show("Vui lòng nhập đầy đủ thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    txtPhone_Order.Focus();
                }
            }
            else
            {
                MessageBox.Show("Chưa có thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            /*try
            {
                if (flowLayoutPnl_Selected.Controls.Count > 0)
                {
                    if (!String.IsNullOrEmpty(txtPhone_Order.Text) && !string.IsNullOrEmpty(txtOrderID_Order.Text) && cbbTableID_Order.Text != "Chọn bàn")
                    {
                        sqlCon.Open();

                        SqlCommand up = new SqlCommand();
                        up.Connection = sqlCon;
                        up.CommandText = "update BAN set tinhtrang='FULL' where SoHieuBan='" + lblTableID_Bill.Text + "' ";
                        up.ExecuteNonQuery();


                        SqlCommand add1 = new SqlCommand();
                        add1.Connection = sqlCon;
                        add1.CommandText = "INSERT INTO PHIEUYEUCAU (SOPYC, NGAYXUAT, NGAYGIOYC, LOAI, MAKH, SOHIEUBAN) VALUES ('" + txtOrderID_Order.Text + "','" + dt.ToString() + "','" + time.ToString() + "','2','" + lblID_Order.Text + "','" + cbbTableID_Order.Text + "')";
                        add1.ExecuteNonQuery();
                        sqlCon.Close();
                        for (int i = 0; i < FoodMenu.count; i++)
                        {
                            sqlCon.Open();
                            if (flowLayoutPnl_Selected.Controls[i].Name == "SelectedFood")
                            {
                                try
                                {
                                    SqlDataReader ma = null;
                                    SqlCommand macmd = new SqlCommand("select MaMonAn from MonAn where tenmon=N'" + paymentlist[i].lbl_name.Text + "'", sqlCon);
                                    ma = macmd.ExecuteReader();
                                    while (ma.Read())
                                    {
                                        mamon = ma["MaMonAn"].ToString();
                                    }
                                }
                                catch (Exception)
                                {
                                    MessageBox.Show(e.ToString());
                                }
                                sqlCon.Close();

                                sqlCon.Open();
                                SqlCommand add2 = new SqlCommand();
                                add2.Connection = sqlCon;
                                add2.CommandText = "INSERT INTO CHITIETPYC (SOPYC, MAMONAN, SOLUONG, DONGIA) VALUES('" + txtOrderID_Order.Text + "','" + mamon + "','" + paymentlist[i].guna2NumericUpDown1.Value + "','" + paymentlist[i].lbl_price.Text + "')";
                                add2.ExecuteNonQuery();
                                sqlCon.Close();
                            }
                        }
                        MessageBox.Show("Order Successfully!!");


                        if (tinhtrang == "FULL")
                        {

                        }
                    }
                    else if (String.IsNullOrEmpty(txtPhone_Order.Text))
                    {
                        MessageBox.Show("Vui lòng kiểm tra thông tin khách hàng trước khi gọi món", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        txtPhone_Order.Focus();
                    }
                    else if (string.IsNullOrEmpty(txtOrderID_Order.Text))
                    {
                        MessageBox.Show("Vui lòng nhập số phiếu yêu cầu", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        txtOrderID_Order.Focus();
                    }
                    else if (cbbTableID_Order.Text == "Chọn bàn")
                    {
                        MessageBox.Show("Vui lòng chọn bàn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                    else
                    {
                        MessageBox.Show("Vui lòng nhập đầy đủ thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        txtPhone_Order.Focus();
                    }
                }
                else
                {
                    MessageBox.Show("Chưa có thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            } catch
            {
                MessageBox.Show("Kiểm tra thông tin", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }*/



            /* try
             {
                 sqlCon.Open();
                 SqlCommand add1 = new SqlCommand();
                 add1.Connection = sqlCon;
                 add1.CommandText = "INSERT INTO PHIEUYEUCAU (SOPYC, NGAYXUAT, NGAYGIOYC, LOAI, MAKH, SOHIEUBAN) VALUES ('" + txtOrderID_Order.Text + "','" + dt.ToString() + "','" + time.ToString() + "','" + type + "','" + lblID_Order.Text + "','" + cbbTableID_Order.Text + "')";
                 add1.ExecuteNonQuery();

               *//*  SqlCommand add2 = new SqlCommand();
                 add2.Connection = sqlCon;
                 add2.CommandText = "INSERT INTO CHITIETPYC (SOPYC, MAMON, SOLUONG, DONGIA) VALUES ('" + txtOrderID_Order.Text + "','" + dt.ToString() + "','" + time.ToString() + "','" + type + "','" + lblID_Order.Text + "','" + cbbTableID_Order.Text + "')";
                 add2.ExecuteNonQuery();*//*

                 sqlCon.Close();
                 MessageBox.Show("Order submitted");
             }
             catch (Exception)
             {
                 MessageBox.Show("Lỗi", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
             }
 */
        }

        private void label18_Click(object sender, EventArgs e)
        {

        }
        //   public static int index = 0;
        public void populateItems_2()
        {
            flowLayoutPanelMENU.Controls.Clear();
            // flowLayoutPanel3.Controls.Clear();
        }

        private void dsyc_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            btnPayment_Bill.Enabled = true;
            int i;
            i = dsyc.CurrentRow.Index;
            lblOrderID_Bill.Text = dsyc.Rows[i].Cells[0].Value.ToString();
            lblDay_OBill.Text = dsyc.Rows[i].Cells[1].Value.ToString();
            lblTime_OBill.Text = dsyc.Rows[i].Cells[2].Value.ToString();
            lblTableID_Bill.Text = dsyc.Rows[i].Cells[5].Value.ToString();
            lblID_Bill.Text = dsyc.Rows[i].Cells[4].Value.ToString();

            //lay ten khach 
            try
            {
                sqlCon.Open();
                SqlDataReader myReader = null;
                SqlCommand myCommand = new SqlCommand("select tenKH from khachhang where maKH='" + lblID_Bill.Text + "'", sqlCon);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    lblName_Bill.Text = myReader["TenKH"].ToString();
                }
                sqlCon.Close();
            }
            catch (Exception)
            {
                MessageBox.Show(e.ToString());
            }



            //chi tiet pyc
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT MONAN.MaMonAn, MONAN.TenMon, CHITIETPYC.SoLuong, CHITIETPYC.DonGia FROM CHITIETPYC, MONAN where CHITIETPYC.MaMonAn = MONAN.MaMonAn and SoPYC='" + lblOrderID_Bill.Text + "'", sqlCon);
                DataTable dtb = new DataTable();
                sqlDa.Fill(dtb);
                dataGridViewBill1.DataSource = dtb;
                sqlCon.Close();
            } catch {
                MessageBox.Show(e.ToString());
            }


            //khuyen mai
            if (cckDis_Bill.Checked == false)
            {
                cbbDiscount.Enabled = false;
                button1.Enabled = false;
            }
            else
            {
                button1.Enabled = true;
                sqlCon.Open();
                SqlDataAdapter km = new SqlDataAdapter("select makm from khuyenmai", sqlCon);
                DataTable bkm = new DataTable();
                km.Fill(bkm);
                cbbDiscount.DataSource = bkm;
                cbbDiscount.DisplayMember = "makm";
                cbbDiscount.Text = "Chọn KM";
                sqlCon.Close();
            }



            //nhan vien
            sqlCon.Open();
            SqlDataAdapter nv = new SqlDataAdapter("select manv from nhanvien", sqlCon);
            DataTable bnv = new DataTable();
            nv.Fill(bnv);
            cbbNV_Bill.DataSource = bnv;
            cbbNV_Bill.DisplayMember = "manv";
            cbbNV_Bill.Text = "Mã NV";
            sqlCon.Close();


            //tong tien tam
            sqlCon.Open();
            try
            {
                SqlDataReader subtt = null;
                SqlCommand subcmd = new SqlCommand("select Sum((Soluong)*(Dongia)) from CHITIETPYC where sopyc = '" + dsyc.Rows[i].Cells[0].Value.ToString() + "'", sqlCon);
                subtt = subcmd.ExecuteReader();
                while (subtt.Read())
                {
                    lblTotal_Bill.Text = subtt[""].ToString();

                }
            }
            catch (Exception)
            {
                MessageBox.Show(e.ToString());
            }
            sqlCon.Close();

            //tong tien

            tongtam = int.Parse(lblTotal_Bill.Text);
            tong = tongtam * (100 - int.Parse(lblDis_Bill.Text)) / 100;
            lblTotal1_Bill.Text = tong.ToString();

            // ma HD
            sqlCon.Open();
            SqlCommand command = new SqlCommand("Select dbo.auto_MaHD()", sqlCon);
            command.ExecuteNonQuery();
            txtIDHD.Text = command.ExecuteScalar().ToString();
            sqlCon.Close();


        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {
            sqlCon.Open();
            SqlCommand command = new SqlCommand();
            command.Connection = sqlCon;
            if (cbbTim.Text == "Mã yêu cầu")
            {
                command.CommandText = "SELECT * FROM PHIEUYEUCAU WHERE SoPYC LIKE N'%" + txtTim_Bill.Text + "%'; ";
            }
            if (cbbTim.Text == "Ngày")
            {
                command.CommandText = "SELECT * FROM PHIEUYEUCAU WHERE NgayXuat LIKE '%" + txtTim_Bill.Text + "%'; ";
            }
            if (cbbTim.Text == "Mã khách hàng")
            {
                command.CommandText = "SELECT * FROM PHIEUYEUCAU WHERE MaKH LIKE '%" + txtTim_Bill.Text + "%'; ";
            }
            if (cbbTim.Text == "Số hiệu bàn")
            {
                command.CommandText = "SELECT * FROM PHIEUYEUCAU WHERE SoHieuBan LIKE '%" + txtTim_Bill.Text + "%'; ";
            }
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = command;
            DataTable dt = new DataTable();
            command.ExecuteNonQuery();
            dt.Clear();
            da.Fill(dt);
            dsyc.DataSource = dt;
            sqlCon.Close();
        }

        private void cbbTim_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtTim_Bill.Focus();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (cckDis_Bill.Checked == true)
            {
                cbbDiscount.Enabled = true;
                button1.Enabled = true;
            }
            if (cckDis_Bill.Checked == false)
            {
                cbbDiscount.Enabled = false;
                button1.Enabled = false;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            sqlCon.Close();

            sqlCon.Open();
            SqlDataReader muc = null;
            SqlCommand pt = new SqlCommand("select mucgiam from khuyenmai where makm='" + cbbDiscount.Text + "'", sqlCon);
            muc = pt.ExecuteReader();
            while (muc.Read())
            {
                lblDis_Bill.Text = muc["mucgiam"].ToString();
            }
            sqlCon.Close();


            tongtam = int.Parse(lblTotal_Bill.Text);
            tong = tongtam * (100 - int.Parse(lblDis_Bill.Text)) / 100;
            lblTotal1_Bill.Text = tong.ToString();

        }

        private void btnPayment_Bill_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                SqlCommand del = new SqlCommand();
                del.Connection = sqlCon;
                del.CommandText = "update phieuyeucau set loai='1' where sopyc='" + lblOrderID_Bill.Text + "' ";
                del.ExecuteNonQuery();
                sqlCon.Close();

                sqlCon.Open();
                SqlCommand up = new SqlCommand();
                up.Connection = sqlCon;
                up.CommandText = "update BAN set tinhtrang='NONE' where SoHieuBan='" + lblTableID_Bill.Text + "' ";
                up.ExecuteNonQuery();
                sqlCon.Close();

                sqlCon.Open();
                SqlCommand add = new SqlCommand();
                add.Connection = sqlCon;
                DateTime date = Convert.ToDateTime(dateTimePicker1.Text);
                add.CommandText = "INSERT INTO HOADON (MAHD, NGAYTHU, TONGTIEN, MANV, MAKH, SOPYC) VALUES ('" + txtIDHD.Text + "',N'" + date.ToString("yyyy-MM-dd") + "','" + lblTotal1_Bill.Text + "','" + cbbNV_Bill.Text + "','" + lblID_Bill.Text + "','" + lblOrderID_Bill.Text + "')";
                add.ExecuteNonQuery();
                sqlCon.Close();
                DialogResult result = MessageBox.Show("Đã thanh toán thành công!\nBạn có muốn in hóa đơn không?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Information);
                if (result == DialogResult.Yes)
                {
                    btnPrint_Bill_Click(sender, e);
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Lỗi", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

      
        private void button2_Click(object sender, EventArgs e)
        {
            lblOrderID_Bill.Text = "ID";
            lblName_Bill.Text = "Name";
            lblID_Bill.Text = "ID";
            lblTableID_Bill.Text = "Table ID";
            lblTotal_Bill.Text = "Total";
            lblTotal1_Bill.Text = "Total";
            lblDay_OBill.Text = "day";
            lblTime_OBill.Text = "time";
            dataGridViewBill1.DataSource = "";
            loaddata();
            btnPayment_Bill.Enabled = false;
        }

        private void txtPhone_Order_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[0-9]{9,11}$");
            string text = txtPhone_Order.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                txtPhone_Order.Focus();
                errorProvider1.SetError(txtPhone_Order, "Chỉ có số!");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtPhone_Order, null);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            flowLayoutPnlMenu.Controls.Clear();
            index = 0;
            HienThi();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            flowLayoutTable.Controls.Clear();
            loadban();
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
                        menu[index].Background = Image.FromFile(@"D:\food\menufood.png"); // Chỉnh tùy máy
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

        private void picSearchFood_Click(object sender, EventArgs e)
        {
            flowLayoutPnlMenu.Controls.Clear();
            index = 0;
            query = "SELECT * FROM MONAN WHERE 1 = 1 ";
            if (cbbFood.Text.Contains("Pizza"))
            {
                query += " and mamonan LIKE '%pz%'";
            }
            if (cbbFood.Text.Contains("Humberger"))
            {
                query += " and mamonan LIKE '%br%'";
            }

            if (cbbFood.Text.Contains("Drink"))
            {
                query += " and mamonan LIKE '%nu%'";
            }
            if (cbbPrice.Text.Contains("0-100k"))
            {
                query += " and dongia > 0 and dongia <= 100000";
            }
            if (cbbPrice.Text.Contains("100-200k"))
            {
                query += " and dongia > 100000 and dongia <= 200000";
            }
            if (cbbPrice.Text.Contains(">200k"))
            {
                query += " and dongia > 200000";
            }
            HienThiMon(query);
        }

        private void btnBookTable_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                SqlCommand table = new SqlCommand();
                table.Connection = sqlCon;
                table.CommandText = "update ban set tinhtrang = 'BOOKED' where sohieuban ='" + txtTableID.Text + "' ";
                table.ExecuteNonQuery();
                sqlCon.Close();
                MessageBox.Show("This table is booked!");
            }
            catch
            {
                MessageBox.Show(e.ToString());
            }
         }

        private void guna2Button2_Click(object sender, EventArgs e)
        {
            // update lai tinh trang ban;
            sqlCon.Open();
            //Data_Provider.exc("update ban set tinhtrang = 'NONE' where '" + txtTableID.Text.Trim() + "'");
            SqlCommand table = new SqlCommand();
            table.Connection = sqlCon;
            table.CommandText = "update ban set tinhtrang = 'NONE' where sohieuban = '" + txtTableID.Text.Trim() + "'";
            table.ExecuteNonQuery();
            //loadban();
            MessageBox.Show("This table is NONE!");
            sqlCon.Close();
            //Data_Provider.exc("exec update_ban ('" + txtTableID.Text + "');");
            
        }

        private void btnPrint_Bill_Click(object sender, EventArgs e)
        {
            InHoaDon inHoaDon  = new InHoaDon();
            inHoaDon.sopyc = lblOrderID_Bill.Text.Trim();
            inHoaDon.tongtien = lblTotal1_Bill.Text.Trim();
            inHoaDon.giamgia = lblDis_Bill.Text.Trim();
            inHoaDon.tongtam = lblTotal_Bill.Text.Trim();
            inHoaDon.ShowDialog();
        }

        private void Foods_Load(object sender, EventArgs e)
        {
            this.Load_cbbTableID();
            loadban();
            pnlOrder.BringToFront();
            pnlBill.SendToBack();
            pnlBook.SendToBack();
            flowPnlinfortable.SendToBack();
            guna2VScrollBar2.SendToBack();
            guna2VScrollBar1.BringToFront();
            guna2VScrollBar3.SendToBack();
        }

    }
}
