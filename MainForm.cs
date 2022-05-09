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
using QLnhahang_anhttt.Statistical;
using QLnhahang_anhttt.Warehouse;
using QLnhahang_anhttt.Introduce;

namespace QLnhahang_anhttt
{
    public partial class MainForm : Form
    {
        public int permission;
        //1: quản lý nhà hàng
        //2: nhân viên quản lý kho
        //3: đối tượng còn lại

        public MainForm()
        {
            InitializeComponent();
            sidePanel.Height = guna2GradientTileBtnHome.Height;  // sidePanel la thanh truot ben nut menu
            sidePanel.Top = guna2GradientTileBtnHome.Top;
            MainPage.BringToFront();  //mainpage
            // hien thong tin user 
            lbName.Text = loginform.name;
            lbPosition.Text = loginform.position;
        }
        // food
        private void guna2GradientTileBtnFood_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnFood.Height;
            sidePanel.Top = guna2GradientTileBtnFood.Top;
        }
        //staff
        private void guna2GradientTileBtnStaff_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnStaff.Height;
            sidePanel.Top = guna2GradientTileBtnStaff.Top;
            staff1.BringToFront();
        }
        //customer
        private void guna2GradientTileBtnCustomer_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnCustomer.Height;
            sidePanel.Top = guna2GradientTileBtnCustomer.Top;
            customer1.BringToFront();
        }
        //warehouse
        private void guna2GradientTileWarehouse_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileWarehouse.Height;
            sidePanel.Top = guna2GradientTileWarehouse.Top;
            nguyenLieu1.BringToFront();
        }
        // introduce
        private void guna2GradientTileBtnIntroduce_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnIntroduce.Height;
            sidePanel.Top = guna2GradientTileBtnIntroduce.Top;
            introduce1.BringToFront();
        }
        // thong ke
        private void guna2GradientTileBtnStatistical_Click(object sender, EventArgs e)
        {
                statisticals2.BringToFront();
        }
        // home
        private void guna2GradientTileBtnHome_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnHome.Height;
            sidePanel.Top = guna2GradientTileBtnHome.Top;
            mainPage1.BringToFront();
        }
        // close
        private void guna2ControlBoxClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        // dang xuat
        private void btnSignOut_Click(object sender, EventArgs e)
        {
            this.Close();
            //////
            loginform frm = new loginform();
            frm.Show();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnHome.Height;
            sidePanel.Top = guna2GradientTileBtnHome.Top;
            mainPage1.BringToFront();
        }

        private void guna2TextBoxSearch_Click(object sender, EventArgs e)
        {
            guna2TextBoxSearch.Text = String.Empty;
        }
    }
}
