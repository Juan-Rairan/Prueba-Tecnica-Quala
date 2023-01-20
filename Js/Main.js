var mainVue = null;
mainVue = new Vue({
    el: "#Vue_Controller_Main",
    data() {
        return {
            currentRoute:"Create.html"
        }
    },
    mounted: function () {

    }, methods: {
        changePage: function (route) {
            var self = this;
            self.currentRoute = route;
        }
    }
})  