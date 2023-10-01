<template>
    <v-container fluid class="rounded elevation-1">
        <v-row class="rounded elevation-1">
            <v-col cols="5" class="rounded elevation-1">
                <p>cols="5"</p>
                <v-text-field
                    label="Look up Patient in Database (Not active..yet)">
                </v-text-field>
                <v-autocomplete 
                    label="Recent Patients"
                    v-model="selectedPatientAutocomplete" 
                    @change="searchPatients"
                    @keydown="searchPatients"
                    :items="patients.map((patient) => patient.name + ' (' + patient.mrn + ')')" 
                >
                <!-- https://github.com/vuetifyjs/vuetify/issues/12880 -->
                </v-autocomplete>
            </v-col>
            <v-col cols="7" class="rounded elevation-1">
                <p>cols="7"</p>
                <PatientDemographics></PatientDemographics>
                <EncounterSlider></EncounterSlider>
            </v-col>
        </v-row>

        <v-row class="rounded elevation-1">
            <v-col cols="3" class="rounded elevation-1">
                <p>cols="3"</p>
                <EpicFlowSheetData></EpicFlowSheetData>
            </v-col>
            <!-- CarouselDeck -->
            <v-col cols="9" class="rounded elevation-1">
                <p>cols="9"</p>
                <v-row class="rounded elevation-1">
                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                    <ImageComponent></ImageComponent>
                </v-col>
                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                    <ImageComponent></ImageComponent>
                </v-col>
                </v-row>
                <v-row class="rounded elevation-1">
                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                    <ImageComponent></ImageComponent>
                </v-col>

                <v-col cols="6" class="rounded elevation-1">
                    <p>cols="6"</p>
                    <ImageComponent></ImageComponent>
                </v-col>
                </v-row>
            </v-col>
        </v-row>

    </v-container>


</template>
  
<script lang="ts">
import EpicFlowSheetData from '@/components/General_Components/EpicFlowSheetData.vue'
import PatientDemographics from '@/components/General_Components/PatientDemographics.vue'
import ImageComponent from '@/components/Image_Modalities/ImageComponent.vue'
import EncounterSlider from '@/components/General_Components/EncounterSlider.vue'

export default {
    data: () => ({
        selectedPatientAutocomplete: '',
        patients: [
        {
          "mrn": 999999,
          "name": "PersonA",
          "age": 74,
          "gender": "Female"
        },
        {
          "mrn": 444444,
          "name": "PersonB",
          "age": 64,
          "gender": "Male"
        },
      ],
    }),
    components: { EpicFlowSheetData, PatientDemographics, ImageComponent, EncounterSlider },
    mounted() {
        console.log("Patient mounted!");
        this.test();
    },
    methods: {
        test: function () {
        console.log("Patient view loaded successfully!");
        },
        searchPatients() {
            var inputString = this.selectedPatientAutocomplete;
            if (!inputString) { // check if inputString is null or undefined
                alert('Input string is empty or null.');
                return;
            }
            const regex = /^(.*?)\s+\((\d+)\)$/; 
            var match = inputString.match(regex);
            if (!match) { // check if match result is null
            alert('No match found.');
            return;
            }
            var name = match[1]; // Captured group 1 (.*?)
            var mrn: number | null = parseInt(match[2]); // Captured group 2 (\d+)
            
            var foundPatient = this.patients.find((patient) => patient.mrn === mrn);
            if (!foundPatient) {
            alert('No patient found.');
            return;
            }
            this.selectedPatient = foundPatient;
            
            var foundPatientImages = this.patientImages.find((imageSet) => imageSet.mrn === mrn)
            if (!foundPatientImages) {
            alert('No patient images found.');
            return;
            }
            this.imageSet = foundPatientImages;
        },
    },
};
</script>

<style>

</style>