<template>
  <v-alert
    v-model="showAlert"
    title="Template Component"
    text="This is an alert component lodged in the TemplateComponent component"
  ></v-alert>
</template>

<script lang="ts">
export default {
  data: () => ({
    showAlert: true,
  }),
  mounted() {
    console.log("Template component mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("Template Component loaded successfully!");
    },
    toggleAlert() {
      this.showAlert = !this.showAlert;
    },
  },
};
</script>