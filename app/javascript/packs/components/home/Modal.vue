<template>
    <div class="overlay">
        aaaa
        <p @click="pageBack">＜もどる</p>
        <div class="panel">
            <div class="panel-header">
                シェアする
            </div>
            <div class="panel-contents">
                <div class="panel-content-left">
                    <img class="" :src="postData.post_image.large.url">
                </div>
                <div class="panel-content-right">

                </div>
            </div>
            <h3>{{ postData }}</h3>
        </div>
    </div>
</template>


<script>
    import axios from 'axios';

    export default {
        data: () => ({
            posts: [],
            postData: ''
        }),
        mounted: function () {
            this.fetchShowPost();
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
            }
        },
    }
</script>