import Vue from 'vue/dist/vue.esm.js'
import Router from './router/mobile_router'
import MobileMenu from './components/mobile/MobileMenu.vue'
import SideMenu from './components/side_menu.vue'
import {VueMasonryPlugin} from 'vue-masonry'

Vue.use(VueMasonryPlugin)
Vue.config.devtools = true
Vue.config.debug = true

new Vue({
    router: Router,
    el: "#app",
    components: {
        'mobile-menu': MobileMenu,
        'side-menu': SideMenu,
    }
})


