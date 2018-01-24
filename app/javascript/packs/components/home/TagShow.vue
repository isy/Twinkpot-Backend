<template>
    <div class="tag_search--contents">
        <div class="tag_search--input">
            <autocomplete-tag :suggestions="suggestions" v-model="selection" @api="fetchTags" @input="fetchPosts">
            </autocomplete-tag>
        </div>
        <div v-show="posts.length==0">
            【{{ selection }}】の検索結果はありません
        </div>
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
    </div>

</template>

<script>
    import axios from 'axios';
    import AutocompleteTag from './AutocompleteTags.vue'

    export default {
        data: () => ({
            posts: [],
            searchTag: '',
            selection: '',
            suggestions: [],
        }),
        components: {
            AutocompleteTag
        },
        mounted: function () {
            this.selection = this.$route.params.name
            this.fetchPosts()
        },
        methods: {
            fetchPosts: function () {
                if(this.selection) {
                    axios.get('/api/photographs/fetch_tag_search', {params: {tag_name: this.selection}}).then((response) => {
                        this.posts = response.data.posts;
                    }, (error) => {
                        console.log(error);
                    });
                }
            },
            fetchTags(word) {
                if(word) {
                    axios.get('/api/photographs/fetch_autocomplete_tags', {params: {term: word}}).then((response) => {
                        this.suggestions = response.data;
                        console.log(response.data);
                    }, (error) => {
                        console.log(error);
                    });
                }
            },
        },
    }

</script>