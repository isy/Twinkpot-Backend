import Vue from 'vue/dist/vue.esm.js'
import Router from './router/router'
import Vuetify from 'vuetify'
import('../../../node_modules/vuetify/dist/vuetify.min.css')
import SideMenu from './components/side_menu.vue'
import Photo_Cards from './components/home/photo_cards.vue'
import {VueMasonryPlugin} from 'vue-masonry';

Vue.use(Vuetify)
Vue.use(VueMasonryPlugin)


new Vue({
    router: Router,
    el: "#app",
    components: {
        'side-menu': SideMenu,
        'photo-cards': Photo_Cards
    }
})


