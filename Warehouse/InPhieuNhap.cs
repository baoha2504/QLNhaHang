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
    public partial class InPhieuNhap : Form
    {
        public ReportParameterCollection rpc;
        public DataTable dt;
        public string sopn;
        public InPhieuNhap()
        {
            InitializeComponent();
        }

        private void InPhieuNhap_Load(object sender, EventArgs e)
        {

            //1
            //reportViewer1.Reset();

            this.reportViewer1.LocalReport.SetParameters(rpc);
            this.reportViewer1.LocalReport.DataSources.Clear();

            //2
            reportViewer1.SetDisplayMode(Microsoft.Reporting.WinForms.DisplayMode.Normal);
            reportViewer1.ZoomMode = Microsoft.Reporting.WinForms.ZoomMode.Percent;
            reportViewer1.ZoomPercent = 100;

            //3
            DataSetNhap dataset = new DataSetNhap();
            dataset.BeginInit();
            this.reportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WinForms.ReportDataSource("DataSet1", dataset.Tables["DataTable1"]));
            this.reportViewer1.LocalReport.ReportPath = @"D:\QLNhaHang\Warehouse\PhieuNhap.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            dataset.EndInit();

            //4
            string connectionString = @"Data Source=DESKTOP-PA4DT27\SQLEXPRESS;Initial Catalog=QuanLyNhaHang;Integrated Security=True";

            //5
            DataSetNhapTableAdapters.DataTable1TableAdapter nhap = new DataSetNhapTableAdapters.DataTable1TableAdapter();
            nhap.Connection.ConnectionString = connectionString;
            nhap.ClearBeforeFill = true;
            nhap.Fill(dataset.DataTable1, sopn);
            
            this.reportViewer1.RefreshReport();
        }
    }
}
