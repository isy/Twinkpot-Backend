import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ItineraryMap from '../components/itineraries/ItineraryMap.vue'


Vue.use(VueRouter)

export default new VueRouter({
    mode: 'history',
    routes: [
        { path: '/users/:user_name/itinerary', component: ItineraryMap },
    ],
})