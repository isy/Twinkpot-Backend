import Vue from 'vue/dist/vue.esm.js'

document.addEventListener("DOMContentLoaded", () => {
    new Vue({
        el: "#new_user",
        data: {
            user: {
                email: ""
            }
        },
        computed: {
            mailError: function() {
                return /^[A-Za-z0-9]+[\w-]+@[\w\.-]+\.\w{2,}$/.test(this.user.email)
            }
        }
    })
})
