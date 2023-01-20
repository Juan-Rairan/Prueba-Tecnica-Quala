using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WMain_Requests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string getMoney()
    {
        try
        {
            string data = Globals.set_a_json(BDu.ejecutar_sp_ds("Sp_Get_Moneda", null, null));
            return data;
        }catch(Exception e)
        {
            return "Error - " + e.Message;
        }


    }
    [WebMethod]
    public static string getSucursales()
    {
        try
        {
            string data = Globals.set_a_json(BDu.ejecutar_sp_ds("Sp_Get_Sucursales", null, null));
            return data;
        }
        catch (Exception e)
        {
            return "Error - " + e.Message;
        }


    }
    [WebMethod]
    public static string SaveSucursal(string code, string description, string address, string CreateDate, string money, string identi)
    {
        try
        {
            string[] nom_par = { "@code", "@description", "@address", "@CreateDate", "@money", "@identi" };
            object[] val_par = { code, description, address, CreateDate, money, identi };
            string data = Globals.set_a_json(BDu.ejecutar_sp_ds("Sp_Save_Sucursal", nom_par, val_par));
            return data;
        }
        catch (Exception e)
        {
            return "Error - " + e.Message;
        }


    }
    [WebMethod]
    public static string deleteSucursal(int Id_Sucursal)
    {
        try
        {
            string[] nom_par = { "@Id_Sucursal"};
            object[] val_par = { Id_Sucursal};
            string data = Globals.set_a_json(BDu.ejecutar_sp_ds("Sp_Delete_Sucursal", nom_par, val_par));
            return data;
        }
        catch (Exception e)
        {
            return "Error - " + e.Message;
        }
    }

    [WebMethod]
    public static string UpdateSucursal(int Id_Sucursal, string Codigo_Sucursal, string Descripcion, string Direccion, string Fecha_Creacion_User, int Id_Moneda, string Identificacion)
    {
        try
        {
            string[] nom_par = { "@Id_Sucursal", "@Codigo_Sucursal", "@Descripcion","@Direccion", "Fecha_Creacion_User", "Id_Moneda", "Identificacion" };
            object[] val_par = { Id_Sucursal, Codigo_Sucursal, Descripcion, Direccion, Fecha_Creacion_User, Id_Moneda, Identificacion };
            string data = Globals.set_a_json(BDu.ejecutar_sp_ds("Sp_Update_Sucursal", nom_par, val_par));
            return data;
        }
        catch (Exception e)
        {
            return "Error - " + e.Message;
        }
    }
}