<template>
  <v-container>
    <h2 class="text-center">Epic Flowsheet Data</h2>
    <h3 class="text-center">(Tabular Data)</h3>
    <p class="mt-16 text-center">Visual Activity</p>
    <p class="mt-16 text-center">Corneal Thickness</p>
    <p class="mt-16 text-center">IOP</p>
    <p class="mt-16 text-center">C/D Ratio</p>
    <p class="mt-16 text-center">Previous Assessment/Plan?</p>
  </v-container>
</template>

<script lang="ts">
export default {
  data: () => ({
  }),
  mounted() {
    console.log("EpicFlowSheetData mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("Loaded EpicFlowSheetData successfully!");
    },
  },
};
</script>