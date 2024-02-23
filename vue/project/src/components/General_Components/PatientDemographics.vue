<template>
  <v-row>
    <v-col cols="3" v-if="true" class="rounded elevation-1">
        <!-- <p>cols="3"</p> -->
        <v-label>Name:</v-label>
        <p>SAMPLE</p>
    </v-col>
    <v-col cols="3" v-if="true" class="rounded elevation-1">
        <!-- <p>cols="3"</p> -->
        <v-label>MRN</v-label>
        <p>123456</p>
    </v-col>
    <v-col cols="3" v-if="true" class="rounded elevation-1">
        <!-- <p>cols="3"</p> -->
        <v-label>Age</v-label>
        <p>50</p>
    </v-col>
    <v-col cols="3" v-if="true" class="rounded elevation-1">
        <!-- <p>cols="3"</p> -->
        <v-label>Gender</v-label>
        <p>F</p>
    </v-col>
  </v-row>
</template>

<script lang="ts">
export default {
  data: () => ({
  }),
  mounted() {
    console.log("PatientDemographics mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("PatientDemographics loaded successfully!");
    },
  },
};
</script>