import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/home/photo_cards.vue'
import Tag from '../components/home/tag.vue'
import Modal from '../components/home/Modal.vue'

Vue.use(VueRouter)

export default new VueRouter({
    mode: 'history',
    routes: [
        { path: '/home', component: Index },
        { path: '/home/tag', component: Tag },
        { path: '/home/post/:id', name: 'showPost', component: Modal },
    ],
})