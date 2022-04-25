using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
namespace QLnhahang_anhttt.Data
{
    class Data_Provider
    {
        public static string connectionSTR = @"Data Source=DESKTOP-PA4DT27\SQLEXPRESS;Initial Catalog=QuanLyNhaHang;Integrated Security=True";

        public static DataTable GetDataTable(string query)
        {
            DataTable data = new DataTable();
            using (SqlConnection connection = new SqlConnection(connectionSTR))//du lieu duoc khai bao trong ngoac tu duoc giai phong
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);//thuc thi query tren ket noi connection
                SqlDataAdapter adapter = new SqlDataAdapter(command);//trung gian dua ra ket qua
                adapter.Fill(data);
                connection.Close();
            }
            return data;
        }

        public static DataTable exc(string query)
        {
            DataTable data = new DataTable();
            using (SqlConnection connection = new SqlConnection(connectionSTR))//du lieu duoc khai bao trong ngoac tu duoc giai phong
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);//thuc thi query tren ket noi connection
                command.ExecuteNonQuery();
                // SqlDataAdapter adapter = new SqlDataAdapter(command);//trung gian dua ra ket qua
                //adapter.Fill(data);
                connection.Close();
            }
            return data;

        }

        public static object ExcScalar(string query)
        {
            object data = 0;
            // string connectionSTR = "Data Source= DESKTOP-0JUE26U\\SQLEXPRESS;Initial Catalog = QuanLiquanCafe;Integrated Security = True";
            using (SqlConnection connection = new SqlConnection(connectionSTR))//du lieu duoc khai bao trong ngoac tu duoc giai phong
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);//thuc thi query tren ket noi connection
                data = command.ExecuteScalar();
                // SqlDataAdapter adapter = new SqlDataAdapter(command);//trung gian dua ra ket qua
                //adapter.Fill(data);
                connection.Close();
            }
            return data;
        }
    }
}
