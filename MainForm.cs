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
using QLnhahang_anhttt.Food;

namespace QLnhahang_anhttt
{
    public partial class MainForm : Form
    {
        int newLocationX;
        int newLocationY;
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
            if (permission == 1 || permission == 3)
            {
                foods1.BringToFront();
            } else
            {
                MessageBox.Show("Bạn không có quyền sử dụng chức năng này!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        //staff
        private void guna2GradientTileBtnStaff_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnStaff.Height;
            sidePanel.Top = guna2GradientTileBtnStaff.Top;
            if (permission == 1)
            {
                staff1.BringToFront();
            }
            else
            {
                MessageBox.Show("Bạn không có quyền sử dụng chức năng này!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        //customer
        private void guna2GradientTileBtnCustomer_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnCustomer.Height;
            sidePanel.Top = guna2GradientTileBtnCustomer.Top;
            if (permission == 1 || permission == 3)
            {
                customer1.BringToFront();
            }
            else
            {
                MessageBox.Show("Bạn không có quyền sử dụng chức năng này!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        //warehouse
        private void guna2GradientTileWarehouse_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileWarehouse.Height;
            sidePanel.Top = guna2GradientTileWarehouse.Top;
            if (permission == 1 || permission == 2)
            {
                nguyenLieu1.BringToFront();
            }
            else
            {
                MessageBox.Show("Bạn không có quyền sử dụng chức năng này!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
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
            sidePanel.Height = guna2GradientTileBtnStatistical.Height;
            sidePanel.Top = guna2GradientTileBtnStatistical.Top;
            if (permission == 1 || permission == 2)
            {
                statisticals2.BringToFront();
            }
            else
            {
                MessageBox.Show("Bạn không có quyền sử dụng chức năng này!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        // home
        private void guna2GradientTileBtnHome_Click(object sender, EventArgs e)
        {
            sidePanel.Height = guna2GradientTileBtnHome.Height;
            sidePanel.Top = guna2GradientTileBtnHome.Top;

            mainPage1.BringToFront();
            if(mainPage1.hienthi == 1)
            {
                
            }
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
            toolTip1.ShowAlways = true;
            toolTip1.SetToolTip(btnSignOut, "Đăng xuất khỏi chương trình");
            toolTip1.SetToolTip(guna2ControlBoxClose, "Đóng");
            sidePanel.Height = guna2GradientTileBtnHome.Height;
            sidePanel.Top = guna2GradientTileBtnHome.Top;
            mainPage1.BringToFront();
        }

        private void guna2TextBoxSearch_Click(object sender, EventArgs e)
        {
            guna2TextBoxSearch.Text = String.Empty;
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
