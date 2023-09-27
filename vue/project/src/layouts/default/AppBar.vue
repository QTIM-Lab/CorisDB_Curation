<template>
  <v-container>
        <!-- <v-system-bar color="deep-purple darken-3"></v-system-bar> -->

        <v-app-bar
          color="#D0B97D"
          prominent
        >
          <v-app-bar-nav-icon variant="text" @click="alert"></v-app-bar-nav-icon>
          <!-- <v-app-bar-nav-icon variant="text" @click.stop="drawer = !drawer"></v-app-bar-nav-icon> -->
          <v-toolbar-title>CU Anschutz Dept. of Ophthalmology</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn variant="text" href="/coris_db/glaucoma">
            Glaucoma
          </v-btn>
          <v-btn variant="text" href="/coris_db/amd">
            AMD
          </v-btn>
          <v-app-bar-nav-icon class="mr-4">
            <v-icon>mdi-bell</v-icon>
          </v-app-bar-nav-icon>
          <v-app-bar-nav-icon>
            <v-icon>mdi-account-circle</v-icon>
          </v-app-bar-nav-icon>
        </v-app-bar>

  </v-container>
</template>

<script lang="ts">
  export default { // for drawer re-lookup vue code
    data: () => ({
      // drawer: false,
      group: null,
    }),

    methods: {
      alert: function() {
        alert("Not Implemented");
      },
    }
    
    // watch: { // for drawer re-lookup vue code
    //   // For drawer that we aren't using
    //   group () {
    //     this.drawer = false
    //   },
    // },
    
  }

</script>

<style>

</style>
