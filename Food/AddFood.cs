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
using System.IO;

namespace QLnhahang_anhttt.Food
{
    public partial class AddFood : Form
    {
        SqlConnection sqlCon = new SqlConnection(Data_Provider.connectionSTR);
        string pt = @"D:\food\menufood.png";
        string loai;

        public AddFood()
        {
            InitializeComponent();

        }
        public void ChonAnh() // hàm chọn ảnh
        {
            OpenFileDialog dlg = new OpenFileDialog();
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                pt = dlg.FileName;
            //    MessageBox.Show(pt);
                pictureBox2.Image = Image.FromFile(pt);
                pictureBox2.SizeMode = PictureBoxSizeMode.StretchImage;
            }
        }

        public void ChonLoai()
        {

            if (cbb_Kind.Text == "Burger")
            {
                loai = "BR";
            }
            if (cbb_Kind.Text == "Pizza")
            {
                loai = "PZ";
            }
            if (cbb_Kind.Text == "Nước")
            {
                loai = "NU";
            }
            
        }

        public bool Check_Data()
        {
            if (loai == "")
            {
                MessageBox.Show("Bạn chưa chọn loại món.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                cbb_Kind.Focus();
                return false;
            }
            if (string.IsNullOrEmpty(txtDish.Text))
            {
                MessageBox.Show("Bạn chưa nhập tên món.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtDish.Focus();
                return false;
            }
            if (string.IsNullOrEmpty(txtID_Add.Text))
            {
                MessageBox.Show("Bạn chưa nhập mã món ăn.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txtID_Add.Focus();
                return false;
            }
            if (string.IsNullOrEmpty(txt_price.Text))
            {
                MessageBox.Show("Bạn chưa nhập giá tiền.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                txt_price.Focus();
                return false;
            }
            return true;
        }

        private void guna2BtnAddFood_Click(object sender, EventArgs e)
        {
            ChonLoai();
            Check_Data();
            try
            {
                sqlCon.Open();
                string query = "INSERT INTO MONAN(MAMONAN, TENMON, DONGIA, DVT, MALM, pathimage) VALUES('" + txtID_Add.Text + "', N'" + txtDish.Text + "', '" + txt_price.Text + "', 'VND', '" + loai + "', '" + pt + "')";
                SqlCommand cmd = new SqlCommand(query, sqlCon);
                cmd.ExecuteNonQuery();
                sqlCon.Close();
                DialogResult result = MessageBox.Show("Continue?", "Add success", MessageBoxButtons.YesNo);
                switch (result)
                {
                    case DialogResult.Yes:
                        this.Hide();
                        Form nf = new AddFood();
                        nf.ShowDialog();
                        break;
                    case DialogResult.No:
                        this.Hide();
                        break;
                }
            }
            catch
            {
                string message = "Lỗi";
                string title = "Thông báo";
                DialogResult dialogResult = MessageBox.Show(message, title, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
           
        }

        private void guna2btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
        }

        private void btn_image_Click(object sender, EventArgs e)
        {
            ChonAnh();
        }
    }
}
