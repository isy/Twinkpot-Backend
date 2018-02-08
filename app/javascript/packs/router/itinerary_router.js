import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ItineraryMap from '../components/itineraries/ItineraryMap.vue'
import ItineraryList from '../components/itineraries/ItineraryList.vue'
import ItineraryEdit from '../components/itineraries/ItineraryEdit.vue'


Vue.use(VueRouter)

export default new VueRouter({
    mode: 'history',
    routes: [
        { path: '/users/:user_name/itinerary', component: ItineraryList },
        { path: '/users/:user_name/itinerary/:id/edit', name: 'itineraryEdit', component: ItineraryEdit },
        { path: '/users/:user_name/itinerary/:id', name: 'itineraryMap', component: ItineraryMap },
    ],
})