<template>
    <div class="m-itinerary-map-contents">
        <div class="itinerary-map" ref="googleMap">
        </div>
        <div class="share_box">
            <label for="label1"><i class="fa fa-share-alt" aria-hidden="true"></i></label>
            <input type="checkbox" id="label1"/>
            <div class="hidden_show">
                <p>プランをシェアする</p>
                <div class="share-button">
                    <a :href="'http://www.facebook.com/sharer.php?u=' + currentUrl" target="_blank" class="btn-fb"><i class="icon-facebook"></i></a>
                    <a :href="'http://twitter.com/share?url=' + currentUrl + '&text=【Twinkpot】でプランを作りました😜&related=orefolder'" target="_blank" class="btn-tw"><i class="icon-twitter"></i></a>
                    <a href="http://line.me/R/msg/text/?【Twinkpot】からプランが届きました☺️" target="_blank" class="btn-li"><i class="icon-line"></i></a>
                </div>

            </div>
        </div>
        <div class="itinerary-side">
            <div class="mode-select">
                <p class="transport">交通手段</p>
                <ul class="mode-list">
                    <li class="mode-button" @click="modeClick('DRIVING')" :class='{"mode-active": selectedMode == "DRIVING"}'><i class="fa fa-car" aria-hidden="true"></i>自動車</li>
                    <li class="mode-button" @click="modeClick('WALKING')" :class='{"mode-active": selectedMode == "WALKING"}'><i class="fa fa-male" aria-hidden="true"></i>徒歩</li>
                </ul>
            </div>
            <div class="mode-time">
                <p class="mode-time-title">移動時間<br><span id="min"></span></p>
                <p class="mode-time-title">移動距離<br><span id="distance"></span></p>

            </div>
            <div class="place_details">
                <div class="place_detail" v-for="itineraryPlace in itineraryPlaces">
                    <a :href="'/home/place/' + itineraryPlace.place.place_name">
                        <img v-if="itineraryPlace.place.post_image" :src="itineraryPlace.place.post_image.medium.url">
                    </a>
                    <div class="place_detail-info">
                        <h5>{{ itineraryPlace.place.place_name }}</h5>
                        <p class="postal-code">〒{{ itineraryPlace.place.postal_code }}</p>
                        <p class="place-address">{{ itineraryPlace.place.address }}</p>
                        <p class="place-tel"><i class="fa fa-phone"></i>{{ itineraryPlace.place.tel }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</template>


<script>
    import axios from 'axios';

    export default {
        data: () => ({
            itineraries: [],
            itineraryPlaces: [],
            selectedMode: 'DRIVING',
            min: 0,
            distance: 0,
            currentUrl: location.href
        }),
        mounted: function () {
            this.fetchItinerary()
        },
        methods: {
            modeClick(mode) {
                this.selectedMode = mode
                this.maps()
            },
            fetchItinerary: function() {
                axios.get('/api/itineraries/fetch_itinerary_details', {params: {itinerary_id: this.$route.params.id}}).then((response) => {
                    this.itineraries = response.data.itineraries
                    this.maps()
                    this.fetchItineraryPlaces()
                }, (error) => {
                    console.log(error)
                });
            },
            fetchItineraryPlaces: function () {
                let placeNames = []
                for(var i = 0; i < this.itineraries.length; i++) {
                    placeNames.push(this.itineraries[i].place_name)
                }
                axios.get('/api/itineraries/fetch_itinerary_places', {params: {itineraries: placeNames }}).then((response) => {
                    this.itineraryPlaces = response.data.itinerary_places
                }, (error) => {
                    console.log(error)
                })
            },
            maps: function() {
                let waypoints = []
                let latSum = 0
                let lngSum = 0
                this.itineraries.forEach( function (value, index, ary) {
                    latSum += Number(value.latitude)
                    lngSum += Number(value.longitude)
                    if (index == 0 || index == (ary.length - 1)) return
                    waypoints.push({ location: value.place_name })
                })
                let avgLat = latSum / this.itineraries.length
                let avgLng = lngSum / this.itineraries.length

                const map = new google.maps.Map(this.$refs.googleMap, {
                    center: {lat: avgLat, lng: avgLng},
                    scrollwheel: false,
                    mapTypeControl: false,
                    zoom: 14
                })
                const request = {
                    origin: new google.maps.LatLng(Number(this.itineraries[0].latitude),Number(this.itineraries[0].longitude)),
                    destination: new google.maps.LatLng(Number(this.itineraries[this.itineraries.length - 1].latitude),Number(this.itineraries[this.itineraries.length - 1].longitude)),
                    optimizeWaypoints: true,
                    waypoints: waypoints,
                    travelMode: google.maps.DirectionsTravelMode[this.selectedMode],
                };
                const ds = new google.maps.DirectionsService()
                const renderer = new google.maps.DirectionsRenderer({
                    map: map,
                })

                var dist = 0
                var seco = 0
                ds.route(request, function(result, status) {
                    if(status == google.maps.DirectionsStatus.OK) {
                        renderer.setDirections(result)
                        result.routes[0].legs.forEach( function (value) {
                            seco += value.duration.value
                            dist += value.distance.value
                        })
                        document.getElementById('min').innerHTML = Math.round((seco / 60) * 10) / 10 + "分";
                        document.getElementById('distance').innerHTML = Math.round((dist / 1000) * 100) /100 + "km";
                    }
                })
            },
        }
    }
</script>