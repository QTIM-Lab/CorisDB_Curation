<!-- <template>
  <v-alert
    v-model="showAlert"
    title="Alert title"
    text="Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, ratione debitis quis est labore voluptatibus! Eaque cupiditate minima, at placeat totam, magni doloremque veniam neque porro libero rerum unde voluptatem!"
  ></v-alert>
  <p>{{ patients }}</p>
  <p>{{ selectedPatientAutocomplete }}</p>
</template>

<script lang="ts">
export default {
  name: "MRNSearch",
  props: ["patients", "selectedPatientAutocomplete"],
  data: () => ({
    showAlert: true,
  }),
  mounted() {
    console.log("mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("method test called successfully!");
      console.log(this.patients)
      console.log(this.selectedPatientAutocomplete)
    },
    toggleAlert() {
      this.showAlert = !this.showAlert;
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
</script> -->