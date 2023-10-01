<template>
  <v-alert
    v-model="showAlert"
    title="TemplateComponent"
    text="This is an alert component lodged in the TemplateComponent component"
  ></v-alert>
</template>

<script lang="ts">
export default {
  data: () => ({
    showAlert: true,
  }),
  mounted() {
    console.log("TemplateComponent mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("TemplateComponent loaded successfully!");
    },
    toggleAlert() {
      this.showAlert = !this.showAlert;
    },
  },
};
</script>