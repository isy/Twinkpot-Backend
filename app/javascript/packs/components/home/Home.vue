<template>
    <div class="home--contents">
        <tag-rank></tag-rank>
        <div class="main-contents">
            <article class="article-list">
                <h3>人気ランキング</h3>
                <div class="post-lists">
                    <div class="popular-post" v-for="(post, index) in popularPosts">
                        <router-link :to="{ name: 'showPost', params: { id: post.id }}">
                            <img :src="post.post_image.medium.url">
                            <p><i aria-hidden="true" class="fa fa-map-marker"></i>{{ post.place_name }}</p>
                        </router-link>
                        <div class="like-button">
                            <i class="fa like-heart" :class='{"fa-heart": post.isLike, "fa-heart-o": !post.isLike}' aria-hidden="true" @click="clickLike(post, index)" title="いいね"></i>
                        </div>
                    </div>
                </div>
            </article>

            <article class="article-list">
                <h3>すべて</h3>
                <div class="post-lists">
                    <div class="popular-post" v-for="(post, index) in posts">
                        <router-link :to="{ name: 'showPost', params: { id: post.id }}">
                            <img :src="post.post_image.medium.url">
                            <p><i aria-hidden="true" class="fa fa-map-marker"></i>{{ post.place_name }}</p>
                        </router-link>
                        <div class="like-button">
                            <i class="fa like-heart" :class='{"fa-heart": post.isLike, "fa-heart-o": !post.isLike}' aria-hidden="true" @click="clickLike(post, index)" title="いいね"></i>
                        </div>
                    </div>
                </div>
            </article>

            <article class="article-list">
                <h3>ユーザランキング</h3>
                <div class="user-lists">
                    <div class="user-rank" v-for="(user, index) in users">
                        <a :href="'/users/'+ user.user_name">
                            <span class="rank">{{ index + 1 }}</span>
                            <img :src="user.user_image.user_profile.url" v-show="user.user_image.user_profile.url">
                            <img src="../../images/no_image_profile.jpeg" v-show="!user.user_image.user_profile.url">
                            <p>{{ user.user_name }}</p>
                        </a>
                    </div>
                </div>
            </article>
        </div>
    </div>

</template>

<script>
    import axios from 'axios';
    import TagRank from './TagRank.vue'

    export default {
        data: () => ({
            posts: [],
            popularPosts: [],
            users: []
        }),
        components: {
            TagRank
        },
        mounted: function () {
            this.fetchPopularPosts()
            this.fetchPosts()
            this.fetchUsers()
        },
        methods: {
            fetchPopularPosts: function () {
                axios.get('/api/photographs/fetch_popular_posts').then((response) => {
                    this.popularPosts = response.data.posts;
                }, (error) => {
                    console.log(error);
                });
            },
            fetchPosts: function () {
                axios.get('/api/photographs/fetch_limit_posts').then((response) => {
                    this.posts = response.data.posts;
                }, (error) => {
                    console.log(error);
                });
            },
            fetchUsers: function () {
                axios.get('/api/photographs/fetch_user_rank').then((response) => {
                    this.users = response.data.users;
                    console.log(response.data)
                }, (error) => {
                    console.log(error);
                });
            },
            clickLike(post, index) {
                if(post.isLike == false) {
                    axios.post('/api/photographs/post_like', {like: {post_id: post.id}}).then((response) => {
                        this.posts[index].isLike = true
                        this.$toasted.success('いいね！しました🙆', {
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
                } else {
                    axios.delete('/api/photographs/delete_like', {params: {post_id: post.id}}).then((response) => {
                        this.posts[index].isLike = false
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
                }
            },
        },
    }

</script>