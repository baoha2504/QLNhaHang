using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLnhahang_anhttt.Introduce
{
    public partial class Introduce : UserControl
    {
        public Introduce()
        {
            InitializeComponent();
        }

        public int ImageNumber = 1;

        public void LoadNextImages()
        {
            timer1.Start();
            ImageNumber++;
            if(ImageNumber > 6)
            {
                ImageNumber = 1;
            }

            pictureBox1.ImageLocation = string.Format(@"D:\QLNhaHang\Resources\" + ImageNumber + ".jpg");
        }

        public void LoadPreviousImages()
        {
            timer1.Start();
            ImageNumber--;
            if (ImageNumber < 1)
            {
                ImageNumber = 6;
            }

            pictureBox1.ImageLocation = string.Format(@"D:\QLNhaHang\Resources\" + ImageNumber + ".jpg");
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            LoadNextImages();
        }

        private void Introduce_Load(object sender, EventArgs e)
        {
            //pictureBox1.ImageLocation = string.Format(@"D:\QLNhaHang\Resources\" + ImageNumber + ".jpg");
            ImageNumber = 1;
            pictureBox1.Image = Image.FromFile(@"D:\QLNhaHang\Resources\" + ImageNumber + ".jpg");
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {
            
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {
            
        }

        private void panel1_Click(object sender, EventArgs e)
        {
            timer1.Stop();
            LoadPreviousImages();
        }

        private void panel2_Click(object sender, EventArgs e)
        {
            timer1.Stop();
            LoadNextImages();
        }
    }
}
