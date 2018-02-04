<template>
    <div class="m-home-contents">
        <div class="tag_search--input">
            <autocomplete-tag :suggestions="suggestions" v-model="selection" @api="fetchTags" @input="fetchPosts">
            </autocomplete-tag>
        </div>
        <div class="search-contents">
            <div class="m-post-contents">
                <div class="message" v-show="posts.length==0">
                    【{{ selection }}】の検索結果はありません
                </div>
                <div class="posts" v-for="post in posts">
                    <router-link :to="{ name: 'showPost', params: { id: post.id }}">
                    <img class="" :src="post.post_image.medium_square.url">
                    </router-link>
                </div>
            </div>
        </div>
    </div>

</template>

<script>
    import axios from 'axios';
    import AutocompleteTag from '../home/AutocompleteTags.vue'

    export default {
        data: () => ({
            posts: [],
            searchTag: '',
            selection: '',
            suggestions: [],
        }),
        components: {
            AutocompleteTag,
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