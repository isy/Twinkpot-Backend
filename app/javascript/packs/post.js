import Vue from 'vue/dist/vue.esm.js'
import Vuetify from 'vuetify'
import('../../../node_modules/vuetify/dist/vuetify.min.css')
import PhotoNew from './components/forms/photo_new.vue'
import SideMenu from './components/side_menu.vue'
import VueGoogleAutocomplete from 'vue-google-autocomplete'
import axios from 'axios'

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
        tagInput: '',
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
        fetchTags: function() {
            axios.get('/api/photographs/fetch_tags', { params: {tag: this.tagInput }}).then((response) => {
                console.log(response.data);
            }, (error) => {
                console.log(error);
            });
        },
    }
})

//Adobeエディターのセットアップ関数
function set_adbe_image(){
    //<body>内の画像要素を取得
    var button = document.getElementById('edit-button');
    var image = document.getElementById('image');
    //画像編集エディタを利用するための準備
    var Editor = new Aviary.Feather({
        apiKey: '8c2b5b3559be493786442e92aba0f0d0',
        language: 'ja',
        onSave: function(imageID, newURL) {
            document.getElementById("image").src = newURL;
            document.getElementById("image_src").value = newURL;
            Editor.close();
        }
    });
    //画像要素をクリックしたら、「編集エディタ」を表示
    button.addEventListener('click', function () {
        console.log("押した");
        Editor.launch({
            //<img>内のidとsrcを取得
            image: image.id,
            url: image.src
        });
    });
}
//エディター動作割り当てる
//    set_adbe_image();
//ファイル選択ボックスの処理
$(document).ready(function() {
    var obj1 = document.getElementById("selfile");
    obj1.addEventListener("change", function(evt){
        console.log("読み込んだよ");
        var file = evt.target.files;
        var reader = new FileReader();
        //dataURL形式でファイルを読み込む
        reader.readAsDataURL(file[0]);
        //ファイルの読込が終了した時の処理
        reader.onload = function(){
            var dataUrl = reader.result;
            //読み込んだ画像とdataURLを書き出す
//            document.getElementById("canvas").innerHTML = "<img id='image' class='' src='" + dataUrl + "'>";
            set_adbe_image();
        }
    },false);
});


$(document).ready(function() {
    $('#tag-it').tagit({
        autocomplete: {source: "/api/photographs/fetch_tags", minLength: 2},
        placeholderText: "タグをつけよう😜",
        fieldName: "tags[]",
    });
});