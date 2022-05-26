using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLnhahang_anhttt.Food
{
    public partial class SelectedFood : UserControl
    {
        #region Properties

        private string _price;
        private string _name;
        private int _soluong;

        [Category("Custom Props")]
        public string Price
        {
            get { return _price; }
            set { _price = value; lbl_price.Text = value; }
        }

        [Category("Custom Props")]
        public string name
        {
            get { return _name; }
            set { _name = value; lbl_name.Text = value; }
        }

        [Category("Custom Props")]
        public int soluong
        {
            get { return _soluong; }
            set { _soluong = value; guna2NumericUpDown1.Value = value; }
        }

        #endregion
        Foods food;

        long subtotal = 0;
        public SelectedFood(Foods frm)
        {
            InitializeComponent();
            this.food = frm;
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            subtotal = 0;
            int stt = food.flowLayoutPnl_Selected.Controls.GetChildIndex(this); // Lấy index của element muốn xóa
            food.flowLayoutPnl_Selected.Controls.Remove(this); // xoa khoi panel             
            Foods.paymentlist = Foods.paymentlist.Where((source, index) => index != stt).ToArray(); // xoa phan tu khoi array

            /* Disable linePanel*/
            for (int j = 0; j < Foods.index; j++)
            {
                if (Foods.menu[j].name == this.lbl_name.Text)
                {
                    Foods.menu[j].panel2_valid.Visible = false;
                    Foods.menu[j].guna2Panel2_valid.Visible = false;
                }
            }

            /*FoodMenu.count -= 1;
            if (FoodMenu.count > 0)
            {
                for (int i = 0; i < FoodMenu.count; i++)
                {
                    if (food.flowLayoutPnl_Selected.Controls[i].Name == "payment")
                    {
                        subtotal = (long)(subtotal + Foods.paymentlist[i].guna2NumericUpDown1.Value * Int32.Parse(Foods.paymentlist[i].lbl_price.Text));
                    }
                }
                string sub = string.Format(new CultureInfo("vi-VN"), "{0:#,##0.00}", subtotal);
                food.lblSub_menu.Text = sub;
            }
            else
                food.lblSub_menu.Text = "0";

*/
        }

        private void guna2NumericUpDown1_ValueChanged(object sender, EventArgs e)
        {
            try
            {
                subtotal = 0;
                if (FoodMenu.count > 0)
                {
                    for (int i = 0; i < FoodMenu.count; i++)
                    {
                        if (food.flowLayoutPnl_Selected.Controls[i].Name == "SelectedFood")
                        {
                            subtotal = (long)(subtotal + Foods.paymentlist[i].guna2NumericUpDown1.Value * Int32.Parse(Foods.paymentlist[i].lbl_price.Text));
                        }
                    }
                    Foods.tongtam = subtotal;
                    Foods.tong = subtotal;
                    string sub = subtotal.ToString();
                    //    string sub = string.Format(new CultureInfo("vi-VN"), "{0:#,##0.00}", subtotal);
                    food.lblSub_menu.Text = sub;
                    //        food.<tongtien>.Text = sub;
                }
                else
                    food.lblSub_menu.Text = "0";
            } catch
            {
                MessageBox.Show("Lỗi", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
