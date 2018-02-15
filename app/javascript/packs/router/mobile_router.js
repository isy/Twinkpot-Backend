import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Home from '../components/mobile/Home.vue'
import All from '../components/mobile/All.vue'
import Tag from '../components/mobile/Tag.vue'
import TagShow from '../components/mobile/TagShow.vue'
import Modal from '../components/mobile/Modal.vue'
import Place from '../components/mobile/Place.vue'
import ItineraryList from '../components/mobile/ItineraryList.vue'
import ItineraryMap from '../components/mobile/ItineraryMap.vue'
import ItineraryEdit from '../components/mobile/ItineraryEdit.vue'


Vue.use(VueRouter)

export default new VueRouter({
    mode: 'history',
    routes: [
        { path: '/home', component: Home },
        { path: '/home/all', component: All },
        { path: '/home/tag', component: Tag },
        { path: '/home/tag/:name',name: 'showTag' , component: TagShow },
        { path: '/home/post/:id', name: 'showPost', component: Modal },
        { path: '/home/place/:name', name: 'place', component: Place },
        { path: '/home/:user_name/itinerary', component: ItineraryList },
        { path: '/home/:user_name/itinerary/:id', name: 'itineraryMap', component: ItineraryMap },
        { path: '/home/:user_name/itinerary/:id/edit', name: 'itineraryEdit', component: ItineraryEdit },
        { path: '/home/:user_name/itinerary/:id', name: 'itineraryMap', component: ItineraryMap },
    ],
})