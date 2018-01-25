<template>
    <v-navigation-drawer
            fixed
            v-model="drawer"
            app
            class="yellow darken-1"
    >
        <v-list class="pa-0 logo">
            <v-list-tile avatar>
                <v-list-tile-avatar>
                    <img src="./../images/twink_logo.png" />
                </v-list-tile-avatar>
                <v-list-tile-content>
                    <a href="/"><v-list-tile-title class="logo-face">Twinkpot</v-list-tile-title></a>
                </v-list-tile-content>
            </v-list-tile>
        </v-list>
        <v-list one-line class="side-menu-list">
            <a href="/home"><v-list-tile @click="">
                <v-list-tile-action>
                    <v-icon>home</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                    <v-list-tile-title class="title">ホーム</v-list-tile-title>
                </v-list-tile-content>
                <div class="moving-arrow" style="transform: translate3d(0px, 0px, 0px);"></div>
            </v-list-tile></a>
            <v-list-tile @click="">
                <v-list-tile-action>
                    <v-icon>contact_mail</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                    <v-list-tile-title class="title">Contact</v-list-tile-title>
                </v-list-tile-content>
            </v-list-tile>
            <a href="/home/photo_new"><v-list-tile @click="">
                <v-list-tile-action>
                    <v-icon>fa-camera-retro</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                    <v-list-tile-title class="title">投稿</v-list-tile-title>
                </v-list-tile-content>
            </v-list-tile></a>
        </v-list>
    </v-navigation-drawer>
</template>

<script>
    export default {
        data: () => ({
            drawer: null
        }),
    }
</script>