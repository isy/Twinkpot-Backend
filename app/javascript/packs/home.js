import Vue from 'vue/dist/vue.esm.js'
import Router from './router/router'
import SideMenu from './components/side_menu.vue'
import Photo_Cards from './components/home/photo_cards.vue'
import {VueMasonryPlugin} from 'vue-masonry'
import Toasted from 'vue-toasted'

Vue.use(VueMasonryPlugin)
Vue.use(Toasted)
Vue.config.devtools = true
Vue.config.debug = true

new Vue({
    router: Router,
    el: "#app",
    components: {
        'side-menu': SideMenu,
        'photo-cards': Photo_Cards
    }
})


