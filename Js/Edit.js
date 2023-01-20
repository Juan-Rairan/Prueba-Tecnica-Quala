var mainVue = null;
mainVue = new Vue({
    el: "#Vue_Controller_Edit",
    data() {
        return {
            money: [],
            sucursales: [],
            update: false,
            edit: {
                code: "",
                description: "",
                address: "",
                CreateDate: "",
                money: 0,
                identi: ""
            }, back: []

        }
    },
    mounted: function () {
        this.getSucursales();
        this.getMoney();
    }, methods: {
        getMoney: function () {
            var self = this;
            fetch("Requests.aspx/getMoney", {
                method: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
            })
                .then((response) => {
                    return response.json().then((data) => {
                        console.log(self.money)
                        self.money = JSON.parse(data.d)
                        
                    }).catch((err) => {
                        console.log(err);
                    })
                });
        },
        getSucursales: function () {
            var self = this;
            fetch("Requests.aspx/getSucursales", {
                method: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
            })
                .then((response) => {
                    return response.json().then((data) => {
                        self.sucursales = JSON.parse(data.d)
                    }).catch((err) => {
                        console.log(err);
                    })
                });
        },
        deleteSucursal: function (Id_Sucursal) {
            var self = this;
            fetch("Requests.aspx/deleteSucursal", {
                method: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    Id_Sucursal: Id_Sucursal
                })
            })
                .then((response) => {
                    return response.json().then((data) => {
                        data = JSON.parse(data.d)
                        alert(data[0][0].RESULT);
                        location.reload();
                    }).catch((err) => {
                        console.log(err);
                    })
                });
        },
        updateSucursal: function (obj) {
            var self = this;
            console.log(obj)
            
            fetch("Requests.aspx/UpdateSucursal", {
                method: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    Id_Sucursal: obj.Id_Sucursal,
                    Codigo_Sucursal: obj.Codigo_Sucursal,
                    Descripcion: obj.Descripcion,
                    Direccion: obj.Direccion,
                    Fecha_Creacion_User: obj.Fecha_Creacion_User,
                    Id_Moneda: obj.Id_Moneda,
                    Identificacion: obj.Identificacion
                })
            })
                .then((response) => {
                    return response.json().then((data) => {
                        data = JSON.parse(data.d)
                        alert(data[0][0].RESULT);
                        location.reload();
                    }).catch((err) => {
                        console.log(err);
                    })
                });
        },
        reload : function () {
            update = false;
            location.reload();
        }
    }
})