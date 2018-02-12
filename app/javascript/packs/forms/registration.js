import Vue from 'vue/dist/vue.esm.js'

function destoryVue() {
    this.$destroy()
    document.removeEventListener('turbolinks:before-cache', destoryVue)
}

document.addEventListener('turbolinks:load', () => {
    var element = document.getElementById("new_user")
    if (element != null) {
        new Vue({
            el: element,
            data: {
                user: {
                    mail: '',
                    password: '',
                    passwordConfirm: ''
                }
            },
            beforeMount: function () {
                this.$originalElement = this.$el.outerHTML
                document.addEventListener('turbolinks:before-cache', destoryVue.bind(this))
            },
            destroyed: function () {
                this.$el.outerHTML = this.$originalElement
            },
            computed: {
                mailError: function () {
                    if (this.user.mail) {
                        return /^[A-Za-z0-9]+[\w-]+@[\w\.-]+\.\w{2,}$/.test(this.user.mail) ? '' : '・メールアドレスの形式ではありません'
                    }
                },
                passwordError: function () {
                    if (this.user.password) {
                        return this.user.password.length >= 6 ? '' : '・パスワードは6文字以上で入力してください'
                    }
                },
                passwordMatch: function () {
                    if (this.user.passwordConfirm) {
                        return this.user.passwordConfirm == this.user.password ? '' : '・パスワードが一致しません'
                    }

                }

            }
        })
    }
})
