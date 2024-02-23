<template>
    <v-container fluid class="rounded elevation-1">
        <v-row class="rounded elevation-1">
            <v-col cols="5" class="rounded elevation-1">
                <!-- <p>cols="5"</p> -->
                <v-text-field
                    label="Look up Patient in Database">
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
                <!-- <p>cols="7"</p> -->
                <PatientDemographics></PatientDemographics>
                <EncounterSlider></EncounterSlider>
            </v-col>
        </v-row>

        <v-row class="rounded elevation-1">
            <v-col cols="3" class="rounded elevation-1">
                <!-- <p>cols="3"</p> -->
                <EpicFlowSheetData></EpicFlowSheetData>
            </v-col>
            <!-- CarouselDeck -->
            <v-col cols="9" class="rounded elevation-1">
                <!-- <p>cols="9"</p> -->
                <v-row class="rounded elevation-1">
                <v-col cols="6" class="rounded elevation-1">
                    <!-- <p>cols="6"</p> -->
                    <FundusComponent></FundusComponent>
                </v-col>
                <v-col cols="6" class="rounded elevation-1">
                    <!-- <p>cols="6"</p> -->
                    <VisualFieldComponent></VisualFieldComponent>
                </v-col>
                </v-row>
                <v-row class="rounded elevation-1">
                <v-col cols="6" class="rounded elevation-1">
                    <!-- <p>cols="6"</p> -->
                    <OCTComponent></OCTComponent>
                </v-col>

                <v-col cols="6" class="rounded elevation-1">
                    <!-- <p>cols="6"</p> -->
                    <OCTRNFLComponent></OCTRNFLComponent>
                </v-col>
                </v-row>
            </v-col>
        </v-row>

    </v-container>


</template>
  
<script lang="ts">
import EpicFlowSheetData from '@/components/General_Components/EpicFlowSheetData.vue'
import PatientDemographics from '@/components/General_Components/PatientDemographics.vue'
import FundusComponent from '@/components/Image_Modalities/FundusComponent.vue'
import VisualFieldComponent from '@/components/Image_Modalities/VisualFieldComponent.vue'
import OCTComponent from '@/components/Image_Modalities/OCTComponent.vue'
import OCTRNFLComponent from '@/components/Image_Modalities/OCTRNFLComponent.vue'
import EncounterSlider from '@/components/General_Components/EncounterSlider.vue'

export default {
    data: () => ({
        selectedPatientAutocomplete: '',
        selectedPatient: {
          "mrn": 0,
          "name": '',
          "age": 0,
          "gender": ''
          },
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
        patientImages: [
          {
              mrn:1234567,
              OCT_GCCs: [
              { image: "edd37.png" },
              { image: "9faaa.png" },
              { image: "eabac.png" },
              ],
              OCT_RNFLs: [
              { image: "4acf7.png" },
              { image: "35020.png" },
              { image: "9c12e.png" },
              ],
              HFA3s: [
              {
                  image_left: "/page_1.png",
                  image_right: "0/page_1.png"
              },
              {
                  image_left: "/page_1.png",
                  image_right: "8/page_1.png"
              },
              {
                  image_left: "/page_1.png",
                  image_right: "1/page_1.png"
              },
              ],
              NonMyds: [
              {
                  image_left: "03a6df0.png",
                  image_right: "e30f1d26.png"
              },
              {
                  image_left: "705fb78.png",
                  image_right: "8c1f9880.png"
              },
              {
                  image_left: "aec54cd.png",
                  image_right: "1d686de8.png"
              },
              ],
          },
          {
              mrn: 7654321,
              OCT_GCCs: [
              { image: "eabac.png" },
              { image: "9faaa.png" },
              { image: "edd37.png" },
              ],
              OCT_RNFLs: [
              { image: "9c12e.png" },
              { image: "35020.png" },
              { image: "4acf7.png" },
              ],
              HFA3s: [
              {
                  image_right: "/page_1.png",
                  image_left: "0/page_1.png"
              },
              {
                  image_right: "/page_1.png",
                  image_left: "8/page_1.png"
              },
              {
                  image_right: "/page_1.png",
                  image_left: "1/page_1.png"
              },
              ],
              NonMyds: [
              {
                  image_right: "03a6df0.png",
                  image_left: "e30f1d26.png"
              },
              {
                  image_right: "705fb78.png",
                  image_left: "8c1f9880.png"
              },
              {
                  image_right: "aec54cd.png",
                  image_left: "1d686de8.png"
              },
              ],
          }
        ]
    }),
    components: { EpicFlowSheetData, PatientDemographics, FundusComponent, VisualFieldComponent, OCTComponent, OCTRNFLComponent, EncounterSlider },
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
            fetch('http://localhost:45325/api/search_for_patient/50000')
            .then(response => {
                if (!response.ok) {
                throw new Error('Network response was not ok');
                }
                debugger
                return response.json();
            })
            .then(data => {
                debugger
                console.log(data);
            })
            .catch(error => {
                debugger
                console.log('There was a problem with the fetch operation:', error.message);
            });
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
            // var foundPatientImages = this.patientImages.find((imageSet) => imageSet.mrn === mrn)
            // if (!foundPatientImages) {
            // alert('No patient images found.');
            // return;
            // }
            // this.imageSet = foundPatientImages;
        },
    },
};
</script>

<style>

</style>