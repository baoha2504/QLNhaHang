using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;

namespace QLnhahang_anhttt.Warehouse
{
    public partial class InPhieuXuat : Form
    {
        public string sopx;
        public InPhieuXuat()
        {
            InitializeComponent();
        }

        private void InPhieuXuat_Load(object sender, EventArgs e)
        {

            //2
            reportViewer1.SetDisplayMode(Microsoft.Reporting.WinForms.DisplayMode.Normal);
            reportViewer1.ZoomMode = Microsoft.Reporting.WinForms.ZoomMode.Percent;
            reportViewer1.ZoomPercent = 100;

            //3
            DataSetXuat dataset = new DataSetXuat();
            dataset.BeginInit();
            this.reportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WinForms.ReportDataSource("DataSet1", dataset.Tables["DataTable1"]));
            this.reportViewer1.LocalReport.ReportPath = @"D:\QLNhaHang\Warehouse\PhieuXuat.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            dataset.EndInit();

            //4
            string connectionString = @"Data Source=DESKTOP-PA4DT27\SQLEXPRESS;Initial Catalog=QuanLyNhaHang;Integrated Security=True";

            //5
            DataSetXuatTableAdapters.DataTable1TableAdapter xuat = new DataSetXuatTableAdapters.DataTable1TableAdapter();
            xuat.Connection.ConnectionString = connectionString;
            xuat.ClearBeforeFill = true;
            xuat.Fill(dataset.DataTable1, sopx);

            this.reportViewer1.RefreshReport();
        }
    }
}
