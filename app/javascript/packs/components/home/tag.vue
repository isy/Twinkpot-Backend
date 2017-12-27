<template>
    <div class="tag_search--contents">
        <div class="tag_search--input">
            <input type="text" v-model="searchTag" placeholder="気になるタグを検索してみよう🕺" @input="fetchPosts">
        </div>
        <div v-show="posts.length==0">
            検索結果はありません
        </div>
        <div v-masonry transition-duration="0.8s" item-selector=".item" class="post-contents">
            <div v-masonry-tile class="item" v-for="post in posts">
                <img class="" :src="post.post_image.medium.url">
                <div class="item-description">
                    <p class="place-name"><i class="fa fa-map-marker" aria-hidden="true"></i>{{ post.place_name }}</p>
                    <p class="item-caption">{{ post.caption }}</p>
                </div>
            </div>
        </div>
    </div>

</template>

<script>
    import axios from 'axios';

    export default {
        data: () => ({
            posts: [],
            searchTag: '',
        }),
        methods: {
            fetchPosts: function () {
                if(this.searchTag.length > 0) {
                    axios.get('/api/photographs/fetch_tag_search', {params: {tag_name: this.searchTag}}).then((response) => {
                        this.posts = response.data.posts;
                    }, (error) => {
                        console.log(error);
                    });
                }
            }
        },
    }
</script>