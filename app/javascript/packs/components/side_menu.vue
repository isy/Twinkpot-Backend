<template>
    <v-navigation-drawer
            fixed
            v-model="drawer"
            app
            class="yellow darken-1"
    >
        <v-list class="pa-0">
            <v-list-tile avatar>
                <v-list-tile-avatar>
                    <img src="./../images/twink_logo.png" />
                </v-list-tile-avatar>
                <v-list-tile-content>
                    <v-list-tile-title class="logo-face">Twinkpot</v-list-tile-title>
                </v-list-tile-content>
            </v-list-tile>
        </v-list>
        <v-list dense>
            <v-list-tile @click="">
                <v-list-tile-action>
                    <v-icon>home</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                    <v-list-tile-title>Home</v-list-tile-title>
                </v-list-tile-content>
            </v-list-tile>
            <v-list-tile @click="">
                <v-list-tile-action>
                    <v-icon>contact_mail</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                    <v-list-tile-title>Contact</v-list-tile-title>
                </v-list-tile-content>
            </v-list-tile>
        </v-list>
    </v-navigation-drawer>
</template>

<style>
    .side-menu {
        background-color: #B00100;
    }
</style>

<script>
    export default {
        data: () => ({
            drawer: true
        }),
    }
</script>