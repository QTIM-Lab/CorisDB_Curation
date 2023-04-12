<template>
  <v-container>
    {{message}}

  </v-container>
</template>

<script lang="ts">
export default {
  data() {
    return {
      message: 'Welcome to the Glaucoma Page'
    }
  },
  mounted() {
    console.log('Component mounted.')
    this.test()
  },
  methods: {
    test: () => {
      console.log("Getting Glaucoma Data")
      const url = "http://0.0.0.0:38147/api/connection_details"
      debugger
      console.log(url)
      fetch(url)
        .then(response => response.json())
        .then(data => {
          debugger;
          // Do something with the returned data
        })
        .catch(error => {
          // Handle any errors that occurred during the fetch request
        });
    }
  }
}
</script>
