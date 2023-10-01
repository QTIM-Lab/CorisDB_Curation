<template>
  <v-row>
    <v-slider
            :ticks="tickLabels"
            :max="2"
            step="1"
            show-ticks="always"
            tick-size="4"
          ></v-slider>
  </v-row>
</template>

<script lang="ts">
export default {
  data: () => ({
    tickLabels: {
            0: '2022-03-02',
            1: '2022-03-02',
            2: '2022-03-02',
    },
  }),
  mounted() {
    console.log("EncounterSlider mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("EncounterSlider loaded successfully!");
    },
  },
};
</script>