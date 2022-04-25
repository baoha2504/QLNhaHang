using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QLnhahang_anhttt.Data;



namespace QLnhahang_anhttt.Food
{
    public partial class Foods : UserControl
    {

        

        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        static string workingDirectory = Environment.CurrentDirectory;
        string rootDir = Directory.GetParent(workingDirectory).Parent.Parent.FullName;

        //   public static payment[] paymentlist = new payment[100];

        public static Menu[] menu;
        public string pyc;
        public static long tongtam = 0;
        public static long tong = 0;
        public static string sdt;
        public static string tenkm = "Không", mucgiam = "0";
        private int index;

       


        public Foods()
        {
            InitializeComponent();
            sildePanelFood.Height = btnCallFood.Height;
            sildePanelFood.Top = btnCallFood.Top;
            pnlBill.Visible = false;
            pnlOrder.Visible = true;
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


        //Booking


        private void btnBooking_Click(object sender, EventArgs e)
        {
            sildePanelFood.Height = btnBooking.Height;
            sildePanelFood.Top = btnBooking.Top;
            pnlBill.Visible = false;
            pnlOrder.Visible = false;
            pnlBook.Visible = true;
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
        }

        private void guna2VScrollBar3_Scroll(object sender, ScrollEventArgs e)
        {

        }

        private void btnCheck_Order_Click(object sender, EventArgs e)
        {
            sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM KHACHHANG where soDienThoai='" + txtPhone_Order.Text + "'", sqlCon);
            DataTable dtb = new DataTable();
            sqlDa.Fill(dtb);
            sqlCon.Close();

            if (dtb.Rows.Count > 0) // đã có thông tin 
            {
                int rows = dtb.Rows.Count;
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
                    MessageBox.Show("Xin vui lòng đăng ký thông tin để đặt bàn và gọi món");
                }
            }
        }

        private void btnAdd_Order_Click(object sender, EventArgs e)
        {

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

        private void txtPhone_Order_TextChanged(object sender, EventArgs e)
        {
        }

        private void Foods_Load(object sender, EventArgs e)
        {

        }

        

    }
}
