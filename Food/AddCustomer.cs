using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using QLnhahang_anhttt.Data;

namespace QLnhahang_anhttt.Food
{
    public partial class AddCustomer : Form
    {
        Foods food;
        public AddCustomer(Foods frm)
        {
            InitializeComponent();
            this.food = frm;
        }

        // button register 
        private void guna2BtnAddcustomer_Click(object sender, EventArgs e)
        {
            //neu thieu 1 trong cac thong tin 
            if(guna2TextBoxName.Text =="" || guna2TextBoxPhone.Text == "" || guna2TextBoxAddress.Text == "")
            {
                MessageBox.Show("Please fill full information in this register.");
            }
            //
            else
            {
                string date = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss.000");
                // goi den ham add_customer trong csdl
                Data_Provider.exc("exec add_Customer N'" + guna2TextBoxName.Text+ "','" + guna2TextBoxPhone.Text+ "',N'" + guna2TextBoxAddress.Text+ "','" + date+ "';");
                MessageBox.Show("Register successfully! \n Let's book table and order!");
                guna2TextBoxName.Text = "";
                guna2TextBoxPhone.Text = "";
                guna2TextBoxAddress.Text = "";

               food.guna2DataGridViewFood
            }
        }
    }
}
