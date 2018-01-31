<template>
    <nav class="m-tag-rank">
        <ul class="tag-lists">
            <router-link class="tag" tag="li" v-for="tag in tags" :to="{ name: 'showTag', params: { name: tag.name }}">
                {{ tag.name }}
            </router-link>
        </ul>
    </nav>

</template>

<script>
    import axios from 'axios';

    export default {
        data: () => ({
            tags: [],
        }),
        mounted: function () {
            this.fetchPopularTag()
        },
        methods: {
            fetchPopularTag: function () {
                axios.get('/api/photographs/fetch_popular_tag').then((response) => {
                    this.tags = response.data;
                }, (error) => {
                    console.log(error);
                });
            },
        },
    }

</script>