using QLnhahang_anhttt.Food;
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
using QLnhahang_anhttt;

namespace QLnhahang_anhttt
{
    public partial class FoodMenu : UserControl
    {
        #region Properties

        private string _price;
        private string _name;
        private Image _background;

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
        public Image Background
        {
            get { return _background; }
            set { _background = value; this.BackgroundImage = value; }
        }
        #endregion

        public Foods food;
        public StartForm startForm;
        public static int count = 0;
        public static int sttclicked = -1;
        public int phanloai;
        public FoodMenu(Foods frm)
        {
            InitializeComponent();
            this.food = frm;
            this.guna2Panel2_valid.Visible = false;
            phanloai = 0;
        }

        public FoodMenu(StartForm startForm)
        {
            InitializeComponent();
            this.startForm = startForm;
            this.guna2Panel2_valid.Visible = false;
            phanloai=1;
        }
        

        private void FoodMenu_Click(object sender, EventArgs e)
        {
            if (phanloai == 0)
            {
                SelectedFood selected = new SelectedFood(food);
                if (panel2_valid.Visible == false)
                {
                    panel2_valid.Visible = true;
                    guna2Panel2_valid.Visible = true;

                    // add selected vao panel, vao list 
                    selected.Price = this.Price;
                    selected.name = this.name;
                    food.flowLayoutPnl_Selected.Controls.Add(selected);
                    food.flowLayoutPnl_Selected.Controls.SetChildIndex(selected, count); // set index of added payment
                                                                                         //        try
                                                                                         //      {
                    sttclicked = food.flowLayoutPnlMenu.Controls.GetChildIndex(this); // lấy index của menu được click
                    /*                }
                                    catch
                                    {
                                        sttclicked = food.flowLayoutPanel1.Controls.GetChildIndex(this); // lấy index của menu được click
                                    }*/

                    Foods.paymentlist[count] = selected;
                    count++;
                }
                else
                {
                    panel2_valid.Visible = false;
                    guna2Panel2_valid.Visible = false;
                }
            }

        }

        private void guna2Panel2_valid_Click(object sender, EventArgs e)
        {

            if (panel2_valid.Visible == false)
            {
                panel2_valid.Visible = true;
                guna2Panel2_valid.Visible = true;
            }
            else
            {
                if (food.flowLayoutPnl_Selected.Controls.Count > 0)
                {
                    // click vào menu food => name của food rồi so sánh với name trong payment => get index cua payment tương ứng => xóa trong list payment
                    for (int i = 0; i < count; i++)
                    {
                        if (Foods.paymentlist[i].name == this.name)
                        {
                            food.flowLayoutPnl_Selected.Controls.Remove(Foods.paymentlist[i]);
                            Foods.paymentlist = Foods.paymentlist.Where((source, index) => index != i).ToArray(); // xoa phan tu  trong array                           
                            count--;
                        }
                    }
                }
                // Tính lại tổng tiền
                long subtotal = 0;
                if (count > 0)
                {
                    for (int i = 0; i < count; i++)
                    {
                        if (food.flowLayoutPnl_Selected.Controls[i].Name == "payment")
                        {
                            subtotal = (long)(subtotal + Foods.paymentlist[i].guna2NumericUpDown1.Value * int.Parse(Foods.paymentlist[i].lbl_price.Text));
                        }
                    }
                    string sub = string.Format(new CultureInfo("vi-VN"), "{0:#,##0.00}", subtotal);
                    food.lblSub_menu.Text = sub;
                  
                }
                else
                food.lblSub_menu.Text = "0";
                sttclicked = -1;

                panel2_valid.Visible = false;
                guna2Panel2_valid.Visible = false;
            }
        }
    }
}
