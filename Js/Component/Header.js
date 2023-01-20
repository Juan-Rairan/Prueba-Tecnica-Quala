Vue.component('header_component', {
    template: `
        <div>
            <ul>
                <li><a @click="$parent.changePage('Create.html')">Crear Sucursal</a></li>
                <li><a @click="$parent.changePage('Edit.html')" >Editar Sucursal</a></li>
                <li class="QualaLogo"><img src="../Img/QualaLogo.png" title="Logo Quala" alt="Logo"/></li>
            </ul>
        </div>
        `,
    data() {
        return {
            
        }
    }, mounted() {
    
    },
    methods: {
        //openToolTip: function (Tipo) {
        //    var self = this;
        //    if (Tipo == "LOGIN") {
        //        document.getElementById("tooltip_login").style.display = "";
        //        self.tipo = "LOGIN";
        //    } else if (Tipo == "REGIST") {
        //        document.getElementById("tooltip_login").style.display = "";
        //        self.tipo = "REGIST";
        //    }
        //},
        //registration: function () {
        //    try {
               
        //        }
        //    } catch (e) {
        //        alert("Error -  comuniquese con el administrador del sistema");
        //        console.log(e);
        //    }
        //}
    },
})
