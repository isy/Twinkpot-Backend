<template>
    <div class="place-contents">
        <div class="place-map" ref="googleMap">
        </div>
        <div class="place-info">
            <div class="place-name">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                {{ placePosts.place_name }}
            </div>
        </div>
        <div v-masonry transition-duration="0.8s" item-selector=".item" class="post-contents">
            <div v-masonry-tile class="item" v-for="post in placePosts.posts">
                <router-link :to="{ name: 'showPost', params: { id: post.id }}">
                    <img class="" :src="post.post_image.medium.url">
                    <div class="item-description">
                        <p class="place-name"><i class="fa fa-map-marker" aria-hidden="true"></i>{{ post.place_name }}</p>
                        <p class="item-caption">{{ post.caption }}</p>
                    </div>
                </router-link>
            </div>
        </div>
        {{ placePosts }}
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
        },
    }
</script>