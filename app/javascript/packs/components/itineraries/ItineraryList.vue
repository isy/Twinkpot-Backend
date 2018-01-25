<template>
    <div class="itinerary_lists-contents">
         <div class="itinerary_lists-center">
             <h4>旅程一覧</h4>
             <div class="itinerary_lists">
                 <ul class="lists">
                     <router-link v-for="itinerary_list in itinerary_lists" tag="li" :to="{ name: 'itineraryMap', params: { id: itinerary_list.id }}" class="list">
                         {{ itinerary_list.itinerary_name }}
                     </router-link>
                 </ul>
             </div>

         </div>
    </div>

</template>


<script>
    import axios from 'axios';

    export default {
        data: () => ({
            itinerary_lists: [],
        }),
        mounted: function () {
            this.fetchItinerary()
        },
        methods: {
            fetchItinerary: function() {
                axios.get('/api/itineraries/fetch_itinerary_lists').then((response) => {
                    this.itinerary_lists = response.data.itinerary_lists
                }, (error) => {
                    console.log(error)
                });
            },
        }
    }
</script>