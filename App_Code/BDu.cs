using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BDu
/// </summary>
public static class BDu
{
    public static string str_conn = ConfigurationManager.ConnectionStrings["TestDB"].ConnectionString;
    public static DataSet ejecutar_sp_ds(String comando, string[] nom_par, Object[] val_par)
    {
        
        DataSet ret = new DataSet();
        SqlConnection conn = null;
        SqlCommand cmd = null;

        try
        {
            conn = new SqlConnection(str_conn);
            cmd = new SqlCommand(comando, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;
            if (nom_par != null && val_par != null)
                for (int i = 0; i < Math.Min(nom_par.Length, val_par.Length); i++)
                    cmd.Parameters.AddWithValue(nom_par[i], val_par[i]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            conn.Open();
            da.Fill(ret);
            conn.Close();
            cmd.Dispose();
            conn.Dispose();
        }
        catch (Exception e)
        {
            if (cmd != null)
                cmd.Dispose();
            if (conn != null)
            {
                conn.Close();
                conn.Dispose();
            }

        }
        return ret;
    }
    public static string ejecutar_sp_st(String comando, string[] nom_par, Object[] val_par)
    {
        string ret = "";
        SqlConnection conn = null;
        SqlCommand cmd = null;
        try
        {
            conn = new SqlConnection(str_conn);
            cmd = new SqlCommand(comando, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 0;
            if (nom_par != null && val_par != null)
                for (int i = 0; i < Math.Min(nom_par.Length, val_par.Length); i++)
                    cmd.Parameters.AddWithValue(nom_par[i], val_par[i]);
            conn.Open();
            ret = cmd.ExecuteScalar().ToString();
            conn.Close();
            cmd.Dispose();
            conn.Dispose();
        }
        catch (Exception e)
        {
            if (cmd != null)
                cmd.Dispose();
            if (conn != null)
            {
                conn.Close();
                conn.Dispose();
            }
            ret = "Error :" + e.Message;
        }
        return ret;
    }
}