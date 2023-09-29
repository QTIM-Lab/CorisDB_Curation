<template>
  <v-alert
    v-model="showAlert"
    title="Alert title"
    text="Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, ratione debitis quis est labore voluptatibus! Eaque cupiditate minima, at placeat totam, magni doloremque veniam neque porro libero rerum unde voluptatem!"
  ></v-alert>
</template>

<script lang="ts">
export default {
  data: () => ({
    showAlert: true,
  }),
  mounted() {
    console.log("mounted!");
  },
  methods: {
    test: function () {
      console.log("method test called successfully!");
    },
    toggleAlert() {
      this.showAlert = !this.showAlert;
    },
  },
};
</script>