<template>
    <div class="overlay">
        <span class="overlay-back" @click="pageBack"><i class="fa fa-chevron-left" aria-hidden="true"></i>
もどる</span>
        <div class="panel">
            <div class="panel-header">
                シェアする
                <div class="save-button">
                    <span @click="isShow=!isShow"><i class="fa fa-thumb-tack" aria-hidden="true"></i>
                        保存</span>
                </div>
            </div>
            <div class="panel-contents">
                <div class="panel-content-left">
                    <img class="" :src="postData.post_image.large.url">
                </div>
                <div class="panel-content-right">
                    <div class="user_info">
                        <a :href="'/users/'+ postData.user.user_name">
                            <img class="" :src="postData.user.user_image.user_profile.url">
                            <span class="user_name">{{ postData.user.user_name }}</span>
                        </a>
                    </div>
                    <div class="post-place">
                        <router-link :to="{ name: 'place', params: { name: postData.place_name }}">
                            <i class="fa fa-map-marker" aria-hidden="true"></i><span class="place_name">{{ postData.place_name }}</span>
                        </router-link>
                    </div>
                    <div class="tag-row">
                        <i class="fa fa-tags" aria-hidden="true"></i>
                        <router-link class="tag-button" tag="span" v-for="tag in postData.tags" :to="{ name: 'showTag', params: { name: tag.name }}">
                            {{ tag.name }}
                        </router-link>
                    </div>
                    <div class="caption">
                        <span>{{ postData.caption }}</span>
                    </div>
                    <div class="panel-content-right-footer">
                        <div class="like-button">
                            <i class="fa like-heart" :class='{"fa-heart": isLike, "fa-heart-o": !isLike}' aria-hidden="true" @click="clickLike" title="いいね"></i>いいね
                        </div>
                        <div class="like-count">
                            {{ likeCount }} 人がいいねしています
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-map" ref="googleMap">

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
                     <input v-model="itineraryName" type="text" @submit.prevent="postItinerary">
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
        updated: function () {
            this.maps()
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
                        this.$toasted.success('いいね！しました', {
                            theme: 'bubble',
                            icon: 'check',
                            duration: 2500
                        })
                    }, (error) => {
                        console.log(error)
                        this.$toasted.error('操作に失敗しました', {
                            theme: 'bubble',
                            icon: 'error',
                            duration: 2500
                        })
                    })
                    this.likeCount += 1
                } else {
                    axios.delete('/api/photographs/delete_like', {params: {post_id: this.$route.params.id}}).then((response) => {
                        this.isLike = false
                        this.$toasted.show('いいね！を取り消しました', {
                            theme: 'bubble',
                            icon: 'delete',
                            duration: 2500
                        })
                    }, (error) => {
                        console.log(error)
                        this.$toasted.error('操作に失敗しました', {
                            theme: 'bubble',
                            icon: 'error',
                            duration: 2500
                        })

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
                    this.$toasted.success('新しい旅程を作成しました', {
                        theme: 'bubble',
                        icon: 'save',
                        duration: 2500
                    })
                }, (error) => {
                    console.log(error)
                })
            },
            postItineraryDetails(itinerary_id) {
                axios.post('/api/itineraries/post_itinerary_details', {itinerary_details: {itinerary_id: itinerary_id, post_data: this.postData}}).then((response) => {
                    console.log(response.data)
                    this.$toasted.success('保存しました', {
                        theme: 'bubble',
                        icon: 'save',
                        duration: 2500
                    })
                    this.isShow = false
                }, (error) => {
                    console.log(error)
                })
            },
            pageBack: function () {
                this.$router.go(-1)
            },
            maps: function() {
                const map = new google.maps.Map(this.$refs.googleMap, {
                    center: {lat: Number(this.postData.latitude), lng: Number(this.postData.longitude)},
                    scrollwheel: false,
                    zoom: 12
                })
                const position = new google.maps.LatLng(Number(this.postData.latitude), Number(this.postData.longitude));
                const marker = new google.maps.Marker({
                    position,
                    map,
                    title: this.postData.place_name,
                });
        },
        },
    }
</script>