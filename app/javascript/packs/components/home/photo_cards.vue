<template>
    <div v-masonry transition-duration="0.8s" item-selector=".item" class="post-contents">
        <div v-masonry-tile class="item" v-for="post in posts">
            <router-link :to="{ name: 'showPost', params: { id: post.id }}">
            <img class="" :src="post.post_image.medium.url">
            <div class="item-description">
                <p class="place-name"><i class="fa fa-map-marker" aria-hidden="true"></i>{{ post.place_name }}</p>
                <p class="item-caption">{{ post.caption }}</p>
            </div>
            </router-link>
        </div>
    </div>

</template>

<script>
    import Modal from './Modal.vue'
    import axios from 'axios';

    export default {
        data: () => ({
            posts: [],
            showModal: false,
        }),
        components: {
          Modal
        },
        mounted: function () {
            this.fetchPosts();
        },
        methods: {
            fetchPosts: function () {
                axios.get('/api/photographs/fetch_posts').then((response) => {
                    for(var i = 0; i < response.data.posts.length; i++) {
                        this.posts.push(response.data.posts[i]);
                    }
                }, (error) => {
                    console.log(error);
                });
            },
        },
    }
</script>