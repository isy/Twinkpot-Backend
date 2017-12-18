import Vue from 'vue/dist/vue.esm.js'
import Vuetify from 'vuetify'
import('../../../node_modules/vuetify/dist/vuetify.min.css')
import PhotoNew from './components/forms/photo_new.vue'
import SideMenu from './components/side_menu.vue'
import VueGoogleAutocomplete from 'vue-google-autocomplete'

Vue.use(Vuetify)

new Vue({
    el: "#app",
    components: {
        'photo-new': PhotoNew,
        'vue-google-autocomplete': VueGoogleAutocomplete,
        'side-menu': SideMenu
    },
    data: {
        address: '',
        uploadedImage: '',
    },
    methods: {
        getAddressData: function (addressData, placeResultData, id) {
            this.address = placeResultData;
        },
        onFileChange(e) {
            let files = e.target.files || e.dataTransfer.files;
            this.createImage(files[0]);
        },
        createImage(file) {
            let reader = new FileReader();
            reader.onload = (e) => {
                this.uploadedImage = e.target.result;
            };
            reader.readAsDataURL(file);
        },
    }
})