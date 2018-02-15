<template>
    <div class="itinerary_lists-contents">
         <div class="itinerary_lists-center">
             <h4>旅程編集</h4>
             <div class="itinerary_lists">
                 <ul class="lists">
                     <li v-for="itinerary_detail in itinerary_details" class="list">
                         {{ itinerary_detail.place_name }}
                         <i class="fa fa-trash edit-icon" @click="DeleteItineraryDetail(itinerary_detail)"></i>
                     </li>
                 </ul>
             </div>

         </div>
    </div>

</template>


<script>
    import axios from 'axios';

    export default {
        data: () => ({
            itinerary_details: [],
        }),
        mounted: function () {
            this.fetchItinerary()
        },
        methods: {
            fetchItinerary: function() {
                axios.get('/api/itineraries/fetch_itinerary_details', {params: {itinerary_id: this.$route.params.id}}).then((response) => {
                    this.itinerary_details = response.data.itineraries
                }, (error) => {
                    console.log(error)
                })
            },
            DeleteItineraryDetail(itinerary_detail) {
                axios.delete('/api/itineraries/delete_itinerary_detail', {params: {itinerary_detail_id: itinerary_detail.id}}).then((response) => {
                    this.itinerary_details.splice(this.itinerary_details.indexOf(itinerary_detail), 1)
                    this.$toasted.show('削除しました', {
                        theme: 'bubble',
                        icon: 'delete',
                        duration: 2500
                    })
                }, (error) => {
                    console.log(error)
                })
            }
        }
    }
</script>