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

namespace QLnhahang_anhttt.Food
{
    public partial class InHoaDon : Form
    {

        public ReportParameterCollection rpc;
        public DataTable dt;
        public string sopyc;
        public string tongtien;

        public InHoaDon()
        {
            InitializeComponent();
        }

        private void InHoaDon_Load(object sender, EventArgs e)
        {

            this.reportViewer1.RefreshReport();
            //this.reportViewer1.LocalReport.SetParameters(rpc);
            this.reportViewer1.LocalReport.DataSources.Clear();

            //2
            reportViewer1.SetDisplayMode(Microsoft.Reporting.WinForms.DisplayMode.Normal);
            reportViewer1.ZoomMode = Microsoft.Reporting.WinForms.ZoomMode.Percent;
            reportViewer1.ZoomPercent = 75;

            //3
            DataSetFood dataset = new DataSetFood();
            dataset.BeginInit();
            this.reportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WinForms.ReportDataSource("DataSet1", dataset.Tables["DataTable1"]));
            this.reportViewer1.LocalReport.ReportPath = @"D:\QLNhaHang\Food\InHoaDon.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            dataset.EndInit();

            //4
            string connectionString = @"Data Source=DESKTOP-PA4DT27\SQLEXPRESS;Initial Catalog=QuanLyNhaHang;Integrated Security=True";

            //5
            DataSetFoodTableAdapters.DataTable1TableAdapter nhap = new DataSetFoodTableAdapters.DataTable1TableAdapter();
            nhap.Connection.ConnectionString = connectionString;
            nhap.ClearBeforeFill = true;
            nhap.Fill(dataset.DataTable1, tongtien, sopyc);

            this.reportViewer1.RefreshReport();
        }
    }
}
