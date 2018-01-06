<template>
    <div class="overlay">
        <span class="overlay-back" @click="pageBack"><i class="fa fa-chevron-left" aria-hidden="true"></i>
もどる</span>
        <div class="panel">
            <div class="panel-header">
                シェアする
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
                        <i class="fa fa-map-marker" aria-hidden="true"></i><span class="place_name">{{ postData.place_name }}</span>
                    </div>
                    <div class="tag-row">
                        <i class="fa fa-tags" aria-hidden="true"></i>
                        <span class="tag-button" v-for="tag in postData.tags">
                            {{ tag.name }}
                        </span>
                    </div>
                    <div class="caption">
                        <span>{{ postData.caption }}</span>
                    </div>
                </div>
            </div>
            <div class="panel-map" ref="googleMap">

            </div>
        </div>
        <h3>{{ postData }}</h3>
    </div>
</template>


<script>
    import axios from 'axios';

    export default {
        data: () => ({
            posts: [],
            postData: '',
        }),
        mounted: function () {
            this.fetchShowPost();
        },
        updated: function () {
            this.maps()
        },
        methods: {
            fetchShowPost: function() {
                axios.get('/api/photographs/fetch_show_post', {params: {post_id: this.$route.params.id}}).then((response) => {
                    this.postData = response.data.post;
                }, (error) => {
                    console.log(error);
                });
            },
            pageBack: function () {
                this.$router.go(-1)
            },
            maps: function() {
                console.log("map: ", google.maps);
                console.log(this.$refs.googleMap);
//                this.$nextTick(() => { console.log(this.$refs.aaa) })
                const map = new google.maps.Map(this.$refs.googleMap, {
                    center: {lat: Number(this.postData.latitude), lng: Number(this.postData.longitude)},
//                    center: {placeId: 'ChIJj3DoguMIAWARRwmOYugj4xc' },
                    scrollwheel: false,
                    zoom: 12
                })
                const position = new google.maps.LatLng(Number(this.postData.latitude), Number(this.postData.longitude));
                const marker = new google.maps.Marker({
                    position,
                    map
                });
        },
        },
    }
</script>