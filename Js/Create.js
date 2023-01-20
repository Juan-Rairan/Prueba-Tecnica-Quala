var mainVue = null;
mainVue = new Vue({
    el: "#Vue_Controller_Create",
    data() {
        return {
            money: [],
            user:{
                code: "",
                description: "",
                address: "",
                CreateDate:"",
                money: 0,
                identi:""
            }
        }
    },
    mounted: function () {
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
                    self.money = JSON.parse(data.d)
                }).catch((err) => {
                    console.log(err);
                })
            });
        },
        saveSucursal: function () {
            var self = this;

            fetch("Requests.aspx/saveSucursal", {
                method: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    code: self.user.code,
                    description: self.user.description,
                    address: self.user.address,
                    CreateDate: self.user.CreateDate,
                    money: self.user.money,
                    identi: self.user.identi
                })
            })
                .then((response) => {
                    return response.json().then((data) => {
                        data = JSON.parse(data.d)
                        alert(data[0][0].RESULT);
                        if (!data[0][0].RESULT.includes("Error")) {
                            location.reload();
                        }
                }).catch((err) => {
                    console.log(err);
                })
            });

        }
    }
})