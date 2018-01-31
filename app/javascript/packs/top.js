import Vue from 'vue/dist/vue.esm.js'
import LoginModal from './components/login_modal.vue'


new Vue({
    el: "#app",
    components: {
        'loginModal': LoginModal,
    }
})