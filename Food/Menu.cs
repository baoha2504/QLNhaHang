using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLnhahang_anhttt.Food
{
    public partial class Menu : UserControl
    {
       
        // gia tri, ten va anh cua mon an
        private string _price;
        private string _name;
        private Image _background;

        //  [Category("Custom Props")]
        public string Price
        {
            get { return _price; }
            set { _price = value; label1.Text = value; }
        }

        public string NameFood
        {
            get { return _name; }
            set { _name = value; label2.Text = value; }
        }

        // [Category("Custom Props")]

        public Image Background
        {
            get { return _background; }
            set { _background = value; this.BackgroundImage = value; }
        }

        Foods food;
        public static int count = 0;
        public static int sttclicked = -1;
        public Menu(Foods frm)
        {
            InitializeComponent();
            this.food = frm;
        }
        //neu chon mon se hien len gia, ten mon, check
        private void Menu_Click(object sender, EventArgs e)
        {
           // Payment Payment = new Payment(food);
            if (guna2GradienbtnCheck.Visible == false)
            {
                guna2GradienbtnCheck.Visible = true;
                panelSelectFood.Visible = true;


                // add payment vao panel, vao list payment
                Payment.Price = this.Price;
                Payment.name = this.name;
                food.flowLayoutPanel2.Controls.Add(Payment);
                food.flowLayoutPanel2.Controls.SetChildIndex(Payment, count); // set index of added payment

                try
                {
                    sttclicked = food.flowLayoutPanel3.Controls.GetChildIndex(this); // lấy index của menu được click
                }
                catch
                {
                    sttclicked = food.flowLayoutPanel1.Controls.GetChildIndex(this); // lấy index của menu được click
                }

                Foods.paymentlist[count] = Payment;
                count = count + 1;
            }
            else
            {
                guna2GradienbtnCheck.Visible = false;
                panelSelectFood.Visible = false;

            }
        }
    }
}
