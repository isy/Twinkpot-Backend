import Vue from 'vue/dist/vue.esm.js'
import Vuetify from 'vuetify'
import('../../../node_modules/vuetify/dist/vuetify.min.css')
import SideMenu from './components/side_menu.vue'

Vue.use(Vuetify)

new Vue({
    el: "#app",
    components: {
        'sideMenu': SideMenu,
    }
})