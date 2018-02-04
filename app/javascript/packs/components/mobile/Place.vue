<template>
    <div class="m-home-contents">
        <span class="overlay-back" @click="pageBack"><i class="fa fa-chevron-left" aria-hidden="true"></i></span>
        <div class="place-map" ref="googleMap">
        </div>
        <div class="place-info">
            <div class="place-name">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                {{ placePosts.place_name }}
            </div>
        </div>
        <div class="m-post-contents">
            <div class="posts" v-for="(post, index) in placePosts.posts">
                <router-link :to="{ name: 'showPost', params: { id: post.id }}">
                    <img class="" :src="post.post_image.medium_square.url">
                </router-link>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';

    export default {
        data: () => ({
            placePosts: [],
            postData: '',
        }),
        mounted: function () {
            this.fetchPlacePost();
        },
        updated: function () {
            this.maps()
        },
        methods: {
            fetchPlacePost: function() {
                axios.get('/api/photographs/fetch_place_post', {params: {name: this.$route.params.name}}).then((response) => {
                    this.placePosts = response.data.place_posts;
                }, (error) => {
                    console.log(error);
                });
            },
            maps: function() {
                console.log("map: ", google.maps);
                const styles = [
                    {
                        "stylers": [
                            { "visibility": "on" },
                            { "saturation": -100 }
                        ]
                    },{
                        "featureType": "administrative",
                        "stylers": [
                            { "visibility": "simplified" }
                        ]
                    },{
                        "featureType": "transit",
                        "stylers": [
                            { "visibility": "off" }
                        ]
                    },{
                        "featureType": "poi",
                        "stylers": [
                            { "saturation": -100 },
                            { "lightness": 64 },
                            { "visibility": "on" }
                        ]
                    },{
                        "featureType": "road",
                        "elementType": "labels.icon",
                        "stylers": [
                            { "visibility": "simplified" }
                        ]
                    },{
                        "featureType": "road.highway",
                        "stylers": [
                            { "saturation": -50 },
                            { "lightness": 50 }
                        ]
                    }
                ]
                const map = new google.maps.Map(this.$refs.googleMap, {
                    center: {lat: Number(this.placePosts.latitude), lng: Number(this.placePosts.longitude)},
                    scrollwheel: false,
                    draggable: false,
                    disableDefaultUI: true,
                    styles: styles,
                    zoom: 14
                })
                const position = new google.maps.LatLng(Number(this.placePosts.latitude), Number(this.placePosts.longitude));
                const marker = new google.maps.Marker({
                    position,
                    map
                });
            },
            pageBack: function () {
                this.$router.go(-1)
            },
        },
    }
</script>