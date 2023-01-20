<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginU.aspx.cs" Inherits="WMain_LoginU" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <style>
            body {
                margin: 0px;
                padding: 0px;
                width: 100%;
                height: 100%;
                background-image: url(../img/fondo.jpg);
            }

            .ctn-login {
                margin: 10% auto 0% auto;
                width: 30vw;
                /* height: 30vh; */
                text-align: center;
                background-color: #0000008c;
                padding: 1%;
                color: #fff;
                font-family: 'Titillium Web', sans-serif;
                border-radius: 8px;
            }

            .inputs {
                padding: 2%;
            }

                .inputs input {
                    width: 80%;
                    border-radius: 8px;
                    padding: 2%;
                }

            .ctn-img-usuario {
                width: 35%;
                margin: auto;
                border: 1px solid #fff;
                border-radius: 100px;
                padding: 5%;
                ;
            }

            .btn {
                width: 80%;
                margin: 5% auto;
                background-color: blue;
                padding: 2%;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s;
            }

                .btn:hover {
                    box-shadow: 0px 0px 20px 4px #00c8ff;
                    transition: all 0.3s;
                }

            a {
                color: #fff;
            }
        </style>
        <div class="ctn-login">
            <div class="inputs">
                <div class="ctn-img-usuario">
                    <img src="../img/user.png" alt="usuario" width="100%">
                </div>
                <label for="user">Usuario</label>
                <br>
                <asp:TextBox runat="server" ID="user"></asp:TextBox>
                <br>
                <label for="pass">Contraseña</label>
                <br>
                <asp:TextBox runat="server" TextMode="Password" ID="pass"></asp:TextBox>
                <br>
                <asp:Button CssClass="btn" runat="server" Text="Ingresar" OnClick="loginUser" />
                <br>
                <a href="#">¿olvidó su contraseña?</a>
                <br>
                <asp:Label runat="server" Visible="false" ID="MessageError"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
