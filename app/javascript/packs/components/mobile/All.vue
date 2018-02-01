<template>
    <div class="m-home-contents">
        <div class="select-button" @click="isShow=!isShow">
            <i class="ion-search" aria-hidden="true"></i>
        </div>
        <div class="m-refine" :class="{show: isShow}">
            <i class="ion-arrow-left-c close-button" aria-hidden="true" @click="isShow=!isShow"></i>
            <div class="pref-city">
                <select name="input_pref" v-model="selectPref" @change="fetchCitys()" class="form-control pref-select">
                    <option value="">都道府県</option>
                    <optgroup v-for="(group, name) in pref" :label="name">
                        <option v-for="option in group" :value="option.name">
                            {{ option.name }}
                        </option>
                    </optgroup>
                </select>

                <select name="input_city" v-model="selectCity" class="form-control city-select" :disabled="selectPref == ''">
                    <option value="" >市区町村</option>
                    <option v-for="(value, index) in city" :value="value.city">{{value.city}}</option>
                </select>
            </div>
            <div class="category">
                <select name="input_category" v-model="selectCategory" class="form-control category-select">
                    <option value="" >カテゴリ選択</option>
                    <option v-for="(value, index) in categories" :value="value.id">{{value.name}}</option>
                </select>
            </div>
            <div class="refine-button" @click="refinePosts()">検索する</div>
        </div>
        <div class="m-post-contents">
            <div class="posts" v-for="(post, index) in posts">
                <router-link :to="{ name: 'showPost', params: { id: post.id }}">
                <img class="" :src="post.post_image.medium_square.url">
                </router-link>
                <div class="like-button">
                    <i class="fa like-heart" :class='{"fa-heart": post.isLike, "fa-heart-o": !post.isLike}' aria-hidden="true" @click="clickLike(post, index)" title="いいね"></i>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Modal from './Modal.vue'
    import axios from 'axios';

    export default {
        data: () => ({
            posts: [],
            isShow: false,
            pref: {
                '北海道': [
                    {"no":"1","name":"\u5317\u6d77\u9053"},
                ],
                 '東北': [
                    {"no":"2","name":"\u9752\u68ee\u770c"},{"no":"3","name":"\u5ca9\u624b\u770c"},{"no":"4","name":"\u5bae\u57ce\u770c"},{"no":"5","name":"\u79cb\u7530\u770c"},{"no":"6","name":"\u5c71\u5f62\u770c"},{"no":"7","name":"\u798f\u5cf6\u770c"},
                ],
                '関東': [
                    {"no":"8","name":"\u8328\u57ce\u770c"},{"no":"9","name":"\u6803\u6728\u770c"},{"no":"10","name":"\u7fa4\u99ac\u770c"},{"no":"11","name":"\u57fc\u7389\u770c"},{"no":"12","name":"\u5343\u8449\u770c"},{"no":"13","name":"\u6771\u4eac\u90fd"},{"no":"14","name":"\u795e\u5948\u5ddd\u770c"},
                ],
                '甲信越・北陸': [
                    {"no":"15","name":"\u65b0\u6f5f\u770c"},{"no":"16","name":"\u5bcc\u5c71\u770c"},{"no":"17","name":"\u77f3\u5ddd\u770c"},{"no":"18","name":"\u798f\u4e95\u770c"},{"no":"19","name":"\u5c71\u68a8\u770c"},{"no":"20","name":"\u9577\u91ce\u770c"},
                ],
                '東海': [
                    {"no":"21","name":"\u5c90\u961c\u770c"},{"no":"22","name":"\u9759\u5ca1\u770c"},{"no":"23","name":"\u611b\u77e5\u770c"},{"no":"24","name":"\u4e09\u91cd\u770c"},
                ],
                '関西': [
                    {"no":"25","name":"\u6ecb\u8cc0\u770c"},{"no":"26","name":"\u4eac\u90fd\u5e9c"},{"no":"27","name":"\u5927\u962a\u5e9c"},{"no":"28","name":"\u5175\u5eab\u770c"},{"no":"29","name":"\u5948\u826f\u770c"},{"no":"30","name":"\u548c\u6b4c\u5c71\u770c"},
                ],
                '中国・四国': [
                    {"no":"31","name":"\u9ce5\u53d6\u770c"},{"no":"32","name":"\u5cf6\u6839\u770c"},{"no":"33","name":"\u5ca1\u5c71\u770c"},{"no":"34","name":"\u5e83\u5cf6\u770c"},{"no":"35","name":"\u5c71\u53e3\u770c"},{"no":"36","name":"\u5fb3\u5cf6\u770c"},{"no":"37","name":"\u9999\u5ddd\u770c"},{"no":"38","name":"\u611b\u5a9b\u770c"},{"no":"39","name":"\u9ad8\u77e5\u770c"},
                ],
                '九州・沖縄': [
                    {"no":"40","name":"\u798f\u5ca1\u770c"},{"no":"41","name":"\u4f50\u8cc0\u770c"},{"no":"42","name":"\u9577\u5d0e\u770c"},{"no":"43","name":"\u718a\u672c\u770c"},{"no":"44","name":"\u5927\u5206\u770c"},{"no":"45","name":"\u5bae\u5d0e\u770c"},{"no":"46","name":"\u9e7f\u5150\u5cf6\u770c"},{"no":"47","name":"\u6c96\u7e04\u770c"}
                ]
            },
            city: [],
            categories: [],
            selectPref: '',
            selectCity: '',
            selectCategory: ''
        }),
        components: {
          Modal
        },
        mounted: function () {
            this.fetchCategory();
            this.fetchPosts();
        },
        methods: {
            fetchCategory: function () {
                axios.get('/api/photographs/fetch_category').then((response) => {
                    this.categories = response.data.categories
                }, (error) => {
                    console.log(error);
                });
            },
            fetchCitys() {
                axios.get('/api/photographs/fetch_city', {params: {prefecture: this.selectPref}}).then((response) => {
                    this.city = response.data.cities
                }, (error) => {
                    console.log(error);
                });
            },
            refinePosts: function () {
                axios.get('/api/photographs/fetch_refine_posts', {params: {prefecture: this.selectPref, city: this.selectCity, category: this.selectCategory }}).then((response) => {
                    this.posts = response.data.posts
                }, (error) => {
                    console.log(error);
                });
                this.isShow = false
            },
            fetchPosts: function () {
                axios.get('/api/photographs/fetch_posts').then((response) => {
                    for(var i = 0; i < response.data.posts.length; i++) {
                        this.posts.push(response.data.posts[i]);
                    }
                }, (error) => {
                    console.log(error);
                });
            },
            clickLike(post, index) {
                if(post.isLike == false) {
                    axios.post('/api/photographs/post_like', {like: {post_id: post.id}}).then((response) => {
                        this.posts[index].isLike = true
                    }, (error) => {
                        console.log(error)
                    })
                } else {
                    axios.delete('/api/photographs/delete_like', {params: {post_id: post.id}}).then((response) => {
                        this.posts[index].isLike = false
                    }, (error) => {
                        console.log(error)
                    })
                }
            },
        },
    }
</script>