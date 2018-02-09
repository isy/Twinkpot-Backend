import Vue from 'vue/dist/vue.esm.js'
import Router from './router/itinerary_router'
import Toasted from 'vue-toasted'

Vue.use(Toasted)
Vue.config.devtools = true
Vue.config.debug = true

new Vue({
    router: Router,
    el: "#app",
    components: {
    }
})


