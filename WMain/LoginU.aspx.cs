using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WMain_LoginU : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void loginUser(object sender, EventArgs e)
    {
        string use = user.Text;
        string passw = pass.Text;
        string[] nom_par = { "@user", "@passw" };
        object[] val_par = {use, Globals.Encriptar(passw)};
        string rta = BDu.ejecutar_sp_st("Sp_valid_User", nom_par, val_par);
        //se deja una validación nula ya que el usuario y la clave no se aplicó para este ejercicio
        if (1 == 1)
        {
            Response.Redirect("Main.html");
        }
        else {
            MessageError.Text = rta;
            MessageError.Visible = true;
        }
            

    }
}