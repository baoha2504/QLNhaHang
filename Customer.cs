using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using QLnhahang_anhttt.Data;
using System.Text.RegularExpressions;
namespace QLnhahang_anhttt
{
    public partial class Customer : UserControl
    {
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        public Customer()
        {
            InitializeComponent();
            connect();            // customer
            connect2();             // bill
            connect3();          // sale
        }
        private void connect() // khach hang customer
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("select MaKH as 'Customer ID', TenKH as 'Name', SoDienThoai as 'Phone', DiaChi as 'Address' from KHACHHANG", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            guna2DataGridViewCustomer.DataSource = dtb;
            guna2DataGridViewCustomer.AutoGenerateColumns = false;
            guna2DataGridViewCustomer.AllowUserToAddRows = false;
            guna2DataGridViewCustomer.AutoResizeColumns();

            sqlCon.Close();
        }

        private void connect2()  // bill : hoa don
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("select MaHD as 'Bill ID', NgayThu as 'Import date', TongTien as 'Total money', MaNV as 'Employee ID', MaKH as 'Cus ID', SoPYC as 'Request num' from HOADON", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            guna2DataGridViewBill.DataSource = dtb;

            guna2DataGridViewBill.AutoGenerateColumns = false;
            guna2DataGridViewBill.AllowUserToAddRows = false;
            guna2DataGridViewBill.Columns[1].DefaultCellStyle.Format = "dd/MM/yyyy";
            guna2DataGridViewBill.AutoResizeColumns();

            sqlCon.Close();
        }

        private void connect3()   // sale: khuyen mai
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("select MaKM as 'Discount ID', TenKM as 'Name', Han as 'Expiry date', MucGiam as 'Reduce' from KHUYENMAI", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            guna2DataGridViewSAle.DataSource = dtb;

            guna2DataGridViewSAle.AutoGenerateColumns = false;
            guna2DataGridViewSAle.AllowUserToAddRows = false;
            guna2DataGridViewSAle.Columns[2].DefaultCellStyle.Format = "dd/MM/yyyy";
            guna2DataGridViewSAle.AutoResizeColumns();
            sqlCon.Close();
        }

        private void clear()
        {
            guna2TextBoxTotal.Text = "";
            guna2TextBoxBill_ID.Text = "";
            guna2TextBoxEmployID.Text = "";
            guna2TextBoxRequestnumber.Text = "";
            guna2TextBoxCusID.Text = "";
            guna2TextBoxName.Text = "";
            guna2TextBoxPhone.Text = "";
            guna2TextBoxAddress.Text = "";
            guna2TextBoxSaleID.Text = "";
            guna2TextBoxSaleName.Text =
            guna2TextBoxReductionRate.Text = ""; ;
        }

        // Customer
        public static string maKH;
        private void guna2TileBtnCus_Click(object sender, EventArgs e)
        {
            sildePanelCutomer.Height = guna2TileBtnCus.Height;
            sildePanelCutomer.Top = guna2TileBtnCus.Top;
            guna2PanelCus.BringToFront();
            guna2PanelBill.SendToBack();
            guna2PanelSale.SendToBack();
        }
        // datagrid view customer
        #region
        private void guna2DataGridViewCustomer_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                maKH = guna2DataGridViewCustomer.Rows[e.RowIndex].Cells[0].Value.ToString();
                guna2TextBoxCusID.Text = guna2DataGridViewCustomer.Rows[e.RowIndex].Cells[0].Value.ToString();
                guna2TextBoxName.Text = guna2DataGridViewCustomer.Rows[e.RowIndex].Cells[1].Value.ToString();
                guna2TextBoxPhone.Text = guna2DataGridViewCustomer.Rows[e.RowIndex].Cells[2].Value.ToString();
                guna2TextBoxAddress.Text = guna2DataGridViewCustomer.Rows[e.RowIndex].Cells[3].Value.ToString();
            }
        }
        private void guna2DataGridViewCustomer_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            clear();
        }
        #endregion
        // thanh search
        #region
        private void guna2TextBoxSearch_Cus_Click(object sender, EventArgs e)
        {
            guna2TextBoxSearch_Cus.Text = string.Empty;
        }

        private void guna2TextBoxSearch_Cus_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (guna2TextBoxSearch_Cus.Text != "")
                {
                    sqlCon.Close();
                    sqlCon.Open();
                    SqlCommand command = new SqlCommand();
                    command.Connection = sqlCon;

                    if (cbbCus.Text == "Cus ID")
                    {
                        command.CommandText = "SELECT  MaKH as 'Customer ID', TenKH as 'Name', SoDienThoai as 'Phone', DiaChi as 'Address' FROM KHACHHANG WHERE MaKH LIKE N'%" + guna2TextBoxSearch_Cus.Text + "%'; ";
                    }
                    if (cbbCus.Text == "Name")
                    {
                        command.CommandText = "SELECT  MaKH as 'Customer ID', TenKH as 'Name', SoDienThoai as 'Phone', DiaChi as 'Address' FROM KHACHHANG WHERE TenKH LIKE N'%" + guna2TextBoxSearch_Cus.Text + "%'; ";
                    }
                    if (cbbCus.Text == "Phone")
                    {
                        command.CommandText = "SELECT  MaKH as 'Customer ID', TenKH as 'Name', SoDienThoai as 'Phone', DiaChi as 'Address' FROM KHACHHANG WHERE SoDienThoai LIKE '%" + guna2TextBoxSearch_Cus.Text + "%'; ";
                    }
                    if (cbbCus.Text == "Address")
                    {
                        command.CommandText = "SELECT MaKH as 'Customer ID', TenKH as 'Name', SoDienThoai as 'Phone', DiaChi as 'Address' FROM KHACHHANG WHERE DiaChi LIKE '%" + guna2TextBoxSearch_Cus.Text + "%'; ";
                    }
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = command;
                    DataTable dt = new DataTable();
                    command.ExecuteNonQuery();
                    dt.Clear();
                    da.Fill(dt);
                    guna2DataGridViewCustomer.DataSource = dt;
                    guna2DataGridViewCustomer.AutoGenerateColumns = true;

                    sqlCon.Close();
                }
                else
                {
                    connect();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void guna2TextBoxSearch_Cus_Leave(object sender, EventArgs e)
        {
            if (guna2TextBoxSearch_Cus.Text == "")
            {
                guna2TextBoxSearch_Cus.Text = "Search for customer";
                connect();
            }
        }
        private void guna2TextBoxSearch_Cus_Enter(object sender, EventArgs e)
        {
            if (guna2TextBoxSearch_Cus.Text == "Search for customer")
                guna2TextBoxSearch_Cus.Text = null;
        }
        #endregion
        //cotrol button  
        #region
        private void guna2TextBoxCusID_DoubleClick(object sender, EventArgs e)
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlCommand command = new SqlCommand("Select [dbo].[auto_maKH]()", sqlCon);
            command.ExecuteNonQuery();
            guna2TextBoxCusID.Text = command.ExecuteScalar().ToString();
            sqlCon.Close();
        }
        private void guna2BtnAddCus_Click(object sender, EventArgs e)
        {
            try
            {
                bool check = true;
                foreach (DataGridViewRow row in guna2DataGridViewCustomer.Rows)
                {
                    string id = row.Cells[0].Value.ToString();
                    if (guna2TextBoxCusID.Text == id)
                    {
                        MessageBox.Show("Customer ID already exists!!! Please re-enter", "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        check = false;
                        guna2TextBoxCusID.Focus();
                    }
                }
                if (check == true)
                {
                    sqlCon.Close();
                    sqlCon.Open();
                    /*  String query = "INSERT INTO KHACHHANG (maKH,tenKH,soDienThoai,diaChi) VALUES('" + guna2TextBoxCusID.Text + "',N'" +
                              guna2TextBoxName.Text + "','" + guna2TextBoxPhone.Text + "',N'" + guna2TextBoxAddress.Text + "')";
                      SqlCommand sqlDa = new SqlCommand(query, sqlCon);
                      sqlDa.ExecuteNonQuery();*/
                    Data_Provider.exc("exec add_KH '" + guna2TextBoxCusID.Text+ "','" + guna2TextBoxName.Text + "','" + guna2TextBoxPhone.Text + "','" + guna2TextBoxAddress.Text + "';");
                    MessageBox.Show("Add succesfully!", "Infor",MessageBoxButtons.OK, MessageBoxIcon.Information);
                    sqlCon.Close();
                    connect();
                    clear();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                guna2TextBoxCusID.Focus();
            }
        }
        private void guna2BtnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                /* String query = "UPDATE KHACHHANG set maKH='" + guna2TextBoxCusID.Text + "',TenKH=N'" + guna2TextBoxName.Text + "',SoDienThoai=N'" + guna2TextBoxPhone.Text + "',DiaChi=N'" + guna2TextBoxAddress.Text + "'where maKH='" + guna2TextBoxCusID.Text + "'";
                 SqlCommand cmd = new SqlCommand(query, sqlCon);
                 cmd.ExecuteNonQuery();*/
                Data_Provider.exc("exec update_KH '" + guna2TextBoxCusID.Text + "', N'" + guna2TextBoxName.Text + "','" + guna2TextBoxPhone.Text + "',N'" + guna2TextBoxAddress.Text + "';");

                MessageBox.Show("Update success");
                sqlCon.Close();
                connect();
                guna2TextBoxSearch_Cus.Text = "";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                guna2TextBoxCusID.Focus();
            }
        }

        private void guna2btnDelete_Click(object sender, EventArgs e)
        {
            sqlCon.Open();
            // SqlCommand cmd = new SqlCommand("delete from KHACHHANG where maKH='" + guna2TextBoxCusID.Text + "'", sqlCon);
            SqlCommand cmd = new SqlCommand("exec delete_KH'" + guna2TextBoxCusID.Text + "'", sqlCon);
            cmd.ExecuteNonQuery();
            sqlCon.Close();
            connect();
            clear();
        }

        private void guna2BtnCheck_Click(object sender, EventArgs e)
        {
            connect();
            guna2TextBoxSearch_Cus.Text = "";
        }
        #endregion
        //default cus ID and Phone
        #region
        private void guna2TextBoxCusID_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[A-Z0-9]{3,8}$");
       
            string text = guna2TextBoxCusID.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                guna2TextBoxCusID.Focus();
                errorProvider1.SetError(guna2TextBoxCusID, "Only uppercase and numbers!");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(guna2TextBoxCusID, null);
            }
        }
        private void guna2TextBoxPhone_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[0-9]{9,11}$");
            string text = guna2TextBoxPhone.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                guna2TextBoxPhone.Focus();
                errorProvider2.SetError(guna2TextBoxPhone, "Only numbers!");
            }
            else
            {
                e.Cancel = false;
                errorProvider2.SetError(guna2TextBoxPhone, null);
            }
        }
        #endregion

        // Bill
        public static string maHD;
        private void guna2TileBtnBill_Click(object sender, EventArgs e)
        {
            clear();
            sildePanelCutomer.Height = guna2TileBtnBill.Height;
            sildePanelCutomer.Top = guna2TileBtnBill.Top;
            guna2PanelBill.BringToFront();
            guna2PanelCus.SendToBack();
            guna2PanelSale.SendToBack();

        }
        //datagridview Bill
        #region
        private void guna2DataGridViewBill_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            clear();
        }
        private void guna2DataGridViewBill_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                maHD = guna2DataGridViewBill.Rows[e.RowIndex].Cells[0].Value.ToString();
                guna2TextBoxBill_ID.Text = guna2DataGridViewBill.Rows[e.RowIndex].Cells[0].Value.ToString();
                guna2DateTimePicker1.Text = guna2DataGridViewBill.Rows[e.RowIndex].Cells[1].Value.ToString();
                guna2TextBoxTotal.Text = guna2DataGridViewBill.Rows[e.RowIndex].Cells[2].Value.ToString();
                guna2TextBoxEmployID.Text = guna2DataGridViewBill.Rows[e.RowIndex].Cells[3].Value.ToString();
                guna2TextBoxBill_CusID.Text = guna2DataGridViewBill.Rows[e.RowIndex].Cells[4].Value.ToString();
                guna2TextBoxRequestnumber.Text = guna2DataGridViewBill.Rows[e.RowIndex].Cells[5].Value.ToString();
            }
        }
        #endregion

        // thanh search in Bill
        #region
        private void guna2TextBoxSearch_Bill_Click(object sender, EventArgs e)
        {
            guna2TextBoxSearch_Bill.Text = string.Empty;
        }
        private void guna2TextBoxSearch_Bill_Enter(object sender, EventArgs e)
        {
            if (guna2TextBoxSearch_Bill.Text == "Search for bill")
                guna2TextBoxSearch_Bill.Text = null;
        }

        private void guna2TextBoxSearch_Bill_Leave(object sender, EventArgs e)
        {
            if (guna2TextBoxSearch_Bill.Text == "")
            {
                guna2TextBoxSearch_Bill.Text = "Search for bill";
                connect2();
            }
               
        }

        private void guna2TextBoxSearch_Bill_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (guna2TextBoxSearch_Bill.Text != "")
                {
                    sqlCon.Open();
                    SqlCommand command = new SqlCommand();
                    command.Connection = sqlCon;

                    if (cbbBill.Text == "Bill ID")
                    {
                        command.CommandText = "select MaHD as 'Bill ID', NgayThu as 'Import date', TongTien as 'Total money', MaNV as 'Employee ID', MaKH as 'Cus ID', SoPYC as 'Request num' from HOADON WHERE MaHD LIKE N'%" + guna2TextBoxSearch_Bill.Text + "%'; ";
                    }
                    if (cbbBill.Text == "Date")
                    {
                        command.CommandText = "select MaHD as 'Bill ID', NgayThu as 'Import date', TongTien as 'Total money', MaNV as 'Employee ID', MaKH as 'Cus ID', SoPYC as 'Request num' from HOADON WHERE NgayThu LIKE N'%" + guna2TextBoxSearch_Bill.Text + "%'; ";
                    }
                    if (cbbBill.Text == "Money")
                    {
                        command.CommandText = "select MaHD as 'Bill ID', NgayThu as 'Import date', TongTien as 'Total money', MaNV as 'Employee ID', MaKH as 'Cus ID', SoPYC as 'Request num' from HOADON WHERE TongTien LIKE '%" + guna2TextBoxSearch_Bill.Text + "%'; ";
                    }
                    if (cbbBill.Text == "Employee")
                    {
                        command.CommandText = "select MaHD as 'Bill ID', NgayThu as 'Import date', TongTien as 'Total money', MaNV as 'Employee ID', MaKH as 'Cus ID', SoPYC as 'Request num' from HOADON WHERE MaNV LIKE '%" + guna2TextBoxSearch_Bill.Text + "%'; ";
                    }
                    if (cbbBill.Text == "Cus ID")
                    {
                        command.CommandText = "select MaHD as 'Bill ID', NgayThu as 'Import date', TongTien as 'Total money', MaNV as 'Employee ID', MaKH as 'Cus ID', SoPYC as 'Request num' from HOADON WHERE MaKH LIKE '%" + guna2TextBoxSearch_Bill.Text + "%'; ";
                    }
                    if (cbbBill.Text == "Request")
                    {
                        command.CommandText = "select MaHD as 'Bill ID', NgayThu as 'Import date', TongTien as 'Total money', MaNV as 'Employee ID', MaKH as 'Cus ID', SoPYC as 'Request num' from HOADON WHERE soPYC LIKE '%" + guna2TextBoxSearch_Bill.Text + "%'; ";
                    }
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = command;
                    DataTable dt = new DataTable();
                    command.ExecuteNonQuery();
                    dt.Clear();
                    da.Fill(dt);
                    guna2DataGridViewBill.DataSource = dt;
                    guna2DataGridViewBill.AutoGenerateColumns = true;

                    sqlCon.Close();
                }
                else
                {
                    connect2();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        #endregion

        //them hoa don  add bill 
        #region
      
        private void guna2TextBoxBill_ID_DoubleClick(object sender, EventArgs e)
        {
            sqlCon.Close();
            sqlCon.Open();
            SqlCommand command = new SqlCommand("Select [dbo].[auto_MaHD]()", sqlCon);
            command.ExecuteNonQuery();
            guna2TextBoxBill_ID.Text = command.ExecuteScalar().ToString();
            sqlCon.Close();
        }
        private void guna2BtnAddBill_Click(object sender, EventArgs e)
        {
            try
            {
                bool check = true;
                foreach (DataGridViewRow row in guna2DataGridViewBill.Rows)
                {
                    string id = row.Cells[0].Value.ToString();
                    if (guna2TextBoxBill_ID.Text == id)
                    {
                        MessageBox.Show("Bill ID already exists!!! Please re-enter", "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        check = false;
                        guna2TextBoxBill_ID.Focus();
                    }
                }
                if (check == true)
                {
                    sqlCon.Close();
                    sqlCon.Open();
                    /* String query = "INSERT INTO HOADON (maHD,ngayThu,tongTien,maNV,maKH,soPYC) VALUES('" + guna2TextBoxBill_ID.Text + "','" +
                             guna2DateTimePicker1.Value.Date + "','" + long.Parse(guna2TextBoxTotal.Text) + "','" + guna2TextBoxEmployID.Text + "','" + guna2TextBoxBill_CusID.Text + "','"  + guna2TextBoxRequestnumber.Text + "')";
                     SqlCommand sqlDa = new SqlCommand(query, sqlCon);
                     sqlDa.ExecuteNonQuery();*/
                    Data_Provider.exc("exec add_HD '" + guna2TextBoxBill_ID.Text + "','" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "','" + guna2TextBoxTotal.Text + "','" + guna2TextBoxEmployID.Text + "','"+ guna2TextBoxBill_CusID.Text+ "','" + guna2TextBoxRequestnumber.Text+ "';");
                   
                    sqlCon.Close();
                    connect2();
                    clear();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                guna2TextBoxBill_ID.Focus();
            }
        }
        #endregion

        // fix bill update hoa don
        #region
        private void guna2BtnFix_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Close();
                sqlCon.Open();
                /*   String query = "UPDATE HOADON set  ngayThu = '" + guna2DateTimePicker1.Value.Date + "',tongTien = '" + long.Parse(guna2TextBoxTotal.Text) + "',maNV ='" + guna2TextBoxEmployID.Text + "',soPYC='" + guna2TextBoxRequestnumber.Text + "', MaKH ='" + guna2TextBoxBill_CusID.Text + "' where maHD = '" + guna2TextBoxBill_ID.Text + "'";
                   SqlCommand cmd = new SqlCommand(query, sqlCon);
                   cmd.ExecuteNonQuery();*/
                Data_Provider.exc("exec update_HD '" + guna2TextBoxBill_ID.Text + "','" + guna2DateTimePicker1.Value.ToString("yyyy-MM-dd") + "','" + guna2TextBoxTotal.Text + "','" + guna2TextBoxEmployID.Text + "','" + guna2TextBoxBill_CusID.Text + "','" + guna2TextBoxRequestnumber.Text + "';");

                MessageBox.Show("Update success");
                sqlCon.Close();
                connect2();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                guna2TextBoxBill_ID.Focus();
            }
        }
        #endregion





        //Discount
        public static string maKM;
        private void guna2TileBtnSale_Click(object sender, EventArgs e)
        {
            clear();
            sildePanelCutomer.Height = guna2TileBtnSale.Height;
            sildePanelCutomer.Top = guna2TileBtnSale.Top;
            guna2PanelSale.BringToFront();
            guna2PanelBill.SendToBack();
            guna2PanelCus.SendToBack();
        }
        //thanh search

        #region
        private void guna2TextBoxSale_Click(object sender, EventArgs e)
        {
            guna2TextBoxSale.Text = string.Empty;
        }
        private void guna2TextBoxSale_Leave(object sender, EventArgs e)
        {
            if (guna2TextBoxSale.Text == "") {
                guna2TextBoxSale.Text = "Search for Customer";
                connect3();
            }
        }

        private void guna2TextBoxSale_Enter(object sender, EventArgs e)
        {
            if (guna2TextBoxSale.Text == "Search for Customer")
                guna2TextBoxSale.Text = null;
        }

        private void guna2TextBoxSale_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (guna2TextBoxSale.Text != "")
                {
                    sqlCon.Open();
                    SqlCommand command = new SqlCommand();
                    command.Connection = sqlCon;

                    if (cbbDiscount.Text == "Discount ID")
                    {
                        command.CommandText = "select MaKM as 'Sale ID', TenKM as 'Name', Han as 'Expiry date', MucGiam as 'Reduce' from KHUYENMAI WHERE MaKM LIKE N'%" + guna2TextBoxSale.Text + "%'; ";
                    }
                    if (cbbDiscount.Text == "Name")
                    {
                        command.CommandText = "select MaKM as 'Sale ID', TenKM as 'Name', Han as 'Expiry date', MucGiam as 'Reduce' from KHUYENMAI WHERE TenKM LIKE N'%" + guna2TextBoxSale.Text + "%'; ";
                    }
                    if (cbbDiscount.Text == "Expired date")
                    {
                        command.CommandText = "select MaKM as 'Sale ID', TenKM as 'Name', Han as 'Expiry date', MucGiam as 'Reduce' from KHUYENMAI WHERE Han LIKE '%" + guna2TextBoxSale.Text + "%'; ";
                    }
                    if (cbbDiscount.Text == "Reduction")
                    {
                        command.CommandText = "select MaKM as 'Sale ID', TenKM as 'Name', Han as 'Expiry date', MucGiam as 'Reduce' from KHUYENMAI WHERE MucGiam LIKE '%" + guna2TextBoxSale.Text + "%'; ";
                    }

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = command;
                    DataTable dt = new DataTable();
                    command.ExecuteNonQuery();
                    dt.Clear();
                    da.Fill(dt);
                    guna2DataGridViewSAle.DataSource = dt;
                    guna2DataGridViewSAle.AutoGenerateColumns = true;

                    sqlCon.Close();
                }
                else
                {
                    connect3();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion

        //control button Sale
        #region
        // add button
        private void guna2BtnAddsale_Click(object sender, EventArgs e)
        {
            try
            {
                bool check = true;
                foreach (DataGridViewRow row in guna2DataGridViewSAle.Rows)
                {
                    string id = row.Cells[0].Value.ToString();
                    if (guna2TextBoxSaleID.Text == id)
                    {
                        MessageBox.Show("Sale ID already exists!!! Please re-enter", "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        check = false;
                        guna2TextBoxSaleID.Focus();
                    }
                }
                if (check == true)
                {
                    sqlCon.Close();
                    sqlCon.Open();
                    /*String query = "INSERT INTO KHUYENMAI (maKM,tenKM,han,mucGiam) VALUES('" + guna2TextBoxSaleID.Text + "','" +
                            guna2TextBoxSaleName.Text + "','" + guna2DateTimePickerSale.Value.Date + "','" + guna2TextBoxReductionRate.Text + "')";
                    SqlCommand sqlDa = new SqlCommand(query, sqlCon);
                    sqlDa.ExecuteNonQuery();*/
                    Data_Provider.exc("exec add_KM '" + guna2TextBoxSaleID.Text + "','" + guna2TextBoxSaleName.Text + "','" + guna2DateTimePickerSale.Value.ToString("yyyy-MM-dd") + "','"  + guna2TextBoxReductionRate.Text + "';");

                    sqlCon.Close();
                    connect3();
                    clear();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                guna2TextBoxSaleID.Focus();
            }
        }

        // fix btn
        private void guna2BtnFixSale_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Close();
                sqlCon.Open();
                /*   String query = "UPDATE KHUYENMAI set tenKM = N'" + guna2TextBoxSaleName.Text + "',han = '" + guna2DateTimePickerSale.Value.Date + "',MucGiam= N'" + guna2TextBoxReductionRate.Text + "' where maKM = '" + guna2TextBoxSaleID.Text + "'";
                   SqlCommand cmd = new SqlCommand(query, sqlCon);
                   cmd.ExecuteNonQuery();*/
                Data_Provider.exc("exec update_KM '" + guna2TextBoxSaleID.Text + "', N'" + guna2TextBoxSaleName.Text + "','" + guna2DateTimePickerSale.Value.ToString("yyyy-MM-dd") + "','" + guna2TextBoxReductionRate.Text + "';");

                MessageBox.Show("Update success");
                sqlCon.Close();
                connect3();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "An error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
                guna2TextBoxSaleID.Focus();
            }
        }
        // delete btn
        private void guna2BtnDeleteSale_Click(object sender, EventArgs e)
        {
            sqlCon.Close();
            sqlCon.Open();
            /*SqlCommand cmd = new SqlCommand("delete from PHIEUKM where maKM='" + guna2TextBoxSaleID.Text + "'", sqlCon);
            cmd.ExecuteNonQuery();
            SqlCommand cmd_2 = new SqlCommand("delete from KHUYENMAI where maKM='" + guna2TextBoxSaleID.Text + "'", sqlCon);
            cmd_2.ExecuteNonQuery();*/
            Data_Provider.exc("exec delete_KM '" + guna2TextBoxSaleID.Text+ "';");

            sqlCon.Close();
            connect3();
            clear();
        }
        // check btn
        private void guna2BtnCheckSale_Click(object sender, EventArgs e)
        {
            connect3();
            guna2TextBoxSale.Text = "";
            guna2TextBoxSaleID.Focus();
        }

        // default reduction rate text box
        private void guna2TextBoxReductionRate_Validating(object sender, CancelEventArgs e)
        {
            Regex CharRegex = new Regex(@"^[A-Z0-9]{3,8}$");//   @"^[0-9%]{2,4}$"
            string text = guna2TextBoxReductionRate.Text;
            bool result = CharRegex.IsMatch(text);
            if (result == false)
            {
                e.Cancel = true;
                guna2TextBoxReductionRate.Focus();
                errorProvider3.SetError(guna2TextBoxReductionRate, "Only uppercase and numbers!");
            }
            else
            {
                e.Cancel = false;
                errorProvider3.SetError(guna2TextBoxReductionRate, null);
            }
        }
        #endregion

        // datagridview Sale
        #region
        private void guna2DataGridViewSAle_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                maKM = guna2DataGridViewSAle.Rows[e.RowIndex].Cells[0].Value.ToString();
                guna2TextBoxSaleID.Text = guna2DataGridViewSAle.Rows[e.RowIndex].Cells[0].Value.ToString();
                guna2TextBoxSaleName.Text = guna2DataGridViewSAle.Rows[e.RowIndex].Cells[1].Value.ToString();
                guna2DateTimePickerSale.Text = guna2DataGridViewSAle.Rows[e.RowIndex].Cells[2].Value.ToString();
                guna2TextBoxReductionRate.Text = guna2DataGridViewSAle.Rows[e.RowIndex].Cells[3].Value.ToString();
            }
        }
        private void guna2DataGridViewSAle_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            clear();
        }


        #endregion

    }
}
