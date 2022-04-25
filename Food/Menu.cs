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

        public Menu(Foods foods)
        {
            InitializeComponent();
        }

        public string Price { get; internal set; }
        public string name { get; internal set; }
        public Image Background { get; internal set; }

    }
}
