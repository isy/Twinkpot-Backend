import Vue from 'vue/dist/vue.esm.js'
import Vuetify from 'vuetify'
import('../../../node_modules/vuetify/dist/vuetify.min.css')
import LoginModal from './components/login_modal.vue'

Vue.use(Vuetify)

new Vue({
    el: "#app",
    components: {
        'loginModal': LoginModal,
    }
})