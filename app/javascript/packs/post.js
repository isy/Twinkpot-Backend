import Vue from 'vue/dist/vue.esm.js'
import PhotoNew from 'components/forms/photo_new.vue'

new Vue({
    el: "#app",
    components: {
        'photo-new': PhotoNew,
    }
})