<template>
    <div class="m-overlay">
        <span class="overlay-back" @click="pageBack"><i class="fa fa-chevron-left" aria-hidden="true"></i></span>
        <div class="panel">
            <div class="panel-header">
                <div class="user_info">
                    <a :href="'/users/'+ postData.user.user_name">
                        <img class="" :src="postData.user.user_image.user_profile.url">
                        <span class="user_name">{{ postData.user.user_name }}</span>
                    </a>
                </div>
                <div class="save-button" @click="isShow=!isShow">
                    <i class="fa fa-thumb-tack" aria-hidden="true"></i>
                        保存
                </div>
            </div>
            <div class="panel-contents">
                <div class="panel-content-image">
                    <img class="" :src="postData.post_image.large.url">
                </div>
                <div class="panel-content-under">
                    <div class="post-place">
                        <router-link :to="{ name: 'place', params: { name: postData.place_name }}">
                            <i class="fa fa-map-marker" aria-hidden="true"></i><span class="place_name">{{ postData.place_name }}</span>
                        </router-link>
                    </div>
                    <div class="panel-content-button">
                        <div class="like-button">
                            <i class="fa like-heart" :class='{"fa-heart": isLike, "fa-heart-o": !isLike}' aria-hidden="true" @click="clickLike" title="いいね"></i>
                            <i class="fa fa-share"></i>
                        </div>
                        <div class="like-count">
                           いいね！ {{ likeCount }} 件
                        </div>
                    </div>
                    <div class="caption">
                        <span>{{ postData.caption }}</span>
                    </div>
                    <div class="tag-row">
                        <i class="fa fa-tags" aria-hidden="true"></i>
                        <span class="tag-button" v-for="tag in postData.tags">
                            {{ tag.name }}
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="itinerary-modal" v-bind:class="{show: isShow}">
            <i class="fa fa-times-circle close-button" aria-hidden="true" @click="isShow=!isShow"></i>
            <h3>旅程を選択</h3>
            <ul class="itinerary-list">
                <li class="itinerary" v-for="itinerary in itineraries" @click="postItineraryDetails(itinerary.id)">
                    <span>{{ itinerary.itinerary_name }}</span>
                </li>
            </ul>
             <form>
                 <input v-model="itineraryName" type="text" @submit.prevent="postItinerary" placeholder="旅程名を入力して追加">
             </form>
            <button @click="postItinerary">追加</button>
        </div>

        <div class="itinerary-modal-bg" v-bind:class="{show: isShow}" v-on:click="isShow=!isShow"></div>
    </div>
</template>


<script>
    import axios from 'axios';

    export default {
        data: () => ({
            posts: [],
            postData: '',
            isLike: false,
            likeState: true,
            likeCount: 0,
            itineraries: [],
            itineraryName: '',
            isShow: false
        }),
        mounted: function () {
            this.fetchShowPost()
            this.fetchItineraries()
        },
        methods: {
            fetchShowPost: function() {
                axios.get('/api/photographs/fetch_show_post', {params: {post_id: this.$route.params.id}}).then((response) => {
                    this.postData = response.data.post
                    this.isLike = response.data.post.like
                    this.likeCount = response.data.post.likeCount
                }, (error) => {
                    console.log(error)
                });
            },
            clickLike: function () {
                if(this.isLike == false) {
                    axios.post('/api/photographs/post_like', {like: {post_id: this.$route.params.id}}).then((response) => {
                        this.isLike = true
                    }, (error) => {
                        console.log(error)
                    })
                    this.likeCount += 1
                } else {
                    axios.delete('/api/photographs/delete_like', {params: {post_id: this.$route.params.id}}).then((response) => {
                        this.isLike = false
                        console.log(this.isLike)
                    }, (error) => {
                        console.log(error)
                    })
                    this.likeCount -= 1
                }
            },
            fetchItineraries: function () {
                axios.get('/api/itineraries/fetch_itineraries').then((response) => {
                    for(var i = 0; i < response.data.itineraries.length; i++) {
                        this.itineraries.push(response.data.itineraries[i]);
                    }
                }, (error) => {
                    console.log(error);
                });
            },
            postItinerary: function () {
                if(!this.itineraryName) return;
                axios.post('/api/itineraries/post_itineraries', {itinerary: {itinerary_name: this.itineraryName}}).then((response) => {
                    console.log(response.data)
                    this.itineraries.unshift(response.data.itinerary);
                    this.itineraryName = ''
                }, (error) => {
                    console.log(error)
                })
            },
            postItineraryDetails(itinerary_id) {
                axios.post('/api/itineraries/post_itinerary_details', {itinerary_details: {itinerary_id: itinerary_id, post_data: this.postData}}).then((response) => {
                    console.log(response.data)
                    this.isShow = false
                }, (error) => {
                    console.log(error)
                })
            },
            pageBack: function () {
                this.$router.go(-1)
            },
        },
    }
</script>