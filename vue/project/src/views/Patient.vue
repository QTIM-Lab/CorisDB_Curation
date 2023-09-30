<template>
    <v-alert
      v-model="showAlert"
      title="Alert title"
      text="Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, ratione debitis quis est labore voluptatibus! Eaque cupiditate minima, at placeat totam, magni doloremque veniam neque porro libero rerum unde voluptatem!"
    ></v-alert>

    <v-container fluid class="rounded elevation-1">
        <v-row class="rounded elevation-1">
        <v-col cols="5" class="rounded elevation-1">
            <p>cols="5"</p>
        </v-col>
        <v-col cols="2" v-if="true" class="rounded elevation-1">
            <p>cols="2"</p>
            <v-label>Name:</v-label>
            <p>SAMPLE</p>
        </v-col>
        <v-col cols="1" v-if="true" class="rounded elevation-1">
            <p>cols="1"</p>
            <v-label>MRN</v-label>
            <p>123456</p>
        </v-col>
        <v-col cols="1" v-if="true" class="rounded elevation-1">
            <p>cols="1"</p>
            <v-label>Age</v-label>
            <p>50</p>
        </v-col>
        <v-col cols="1" v-if="true" class="rounded elevation-1">
            <p>cols="1"</p>
            <v-label>Gender</v-label>
            <p>F</p>
        </v-col>
        </v-row>

        <v-row class="rounded elevation-1">
            <v-col cols="3" class="rounded elevation-1">
                <p>cols="3"</p>
                <EpicFlowSheetData></EpicFlowSheetData>
            </v-col>
            <v-col cols="9" class="rounded elevation-1">
                <p>cols="9"</p>
                <v-row class="rounded elevation-1">
                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                </v-col>
                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                </v-col>
                </v-row>
                <v-row class="rounded elevation-1">
                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                </v-col>

                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                </v-col>
                </v-row>
            </v-col>
        </v-row>

    </v-container>


</template>
  
<script lang="ts">
import EpicFlowSheetData from '@/components/General_Components/EpicFlowSheetData.vue'
import TemplateComponent from '@/components/General_Components/TemplateComponent.vue'

export default {
    data: () => ({
        showAlert: true,
    }),
    components: { EpicFlowSheetData },
    mounted() {
        console.log("Patient mounted!");
        this.test();
    },
    methods: {
        test: function () {
        console.log("Patient view loaded successfully!");
        },
        toggleAlert() {
        this.showAlert = !this.showAlert;
        },
    },
};
</script>

<style>

</style>