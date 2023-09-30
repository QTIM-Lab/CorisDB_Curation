<template>
  <v-alert
    v-model="showAlert"
    title="Epic Flow Sheet Data"
    text="This is an alert component lodged in the EpicFlowSheetData component"
  ></v-alert>
</template>

<script lang="ts">
export default {
  data: () => ({
    showAlert: true,
  }),
  mounted() {
    console.log("EpicFlowSheetData mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("Loaded EpicFlowSheetData successfully!");
    },
    toggleAlert() {
      this.showAlert = !this.showAlert;
    },
  },
};
</script>