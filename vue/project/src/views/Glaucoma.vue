<template>
  <v-container fluid>
    <v-row>
      <v-col cols="5">
        <!-- <v-autocomplete v-model="selectedPatientAutocomplete" :items="patients.map((patient) => patient.name + ' (' + patient.mrn + ')')" item-text="name" label="Search Patients" @input="searchPatients"></v-autocomplete> -->
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

      <!-- Debug search list -->
      <!-- <v-col cols="3">
        <v-list>
          <v-list-item v-for="patient in filteredPatients" :key="patient.mrn">
            <v-list-item-title>{{ patient.name }}</v-list-item-title>
            <v-list-item-subtitle>{{ patient.age }} years old</v-list-item-subtitle>
          </v-list-item>
        </v-list>
      </v-col> -->
      <v-col cols="2" v-if="selectedPatient">
        <v-label>Name:</v-label>
        <p>{{ selectedPatient.name }}</p>
      </v-col>
      <v-col cols="1" v-if="selectedPatient">
        <v-label>MRN</v-label>
        <p>{{ selectedPatient.mrn }}</p>
      </v-col>
      <v-col cols="1" v-if="selectedPatient">
        <v-label>Age</v-label>
        <p>{{ selectedPatient.age }}</p>
      </v-col>
      <v-col cols="1" v-if="selectedPatient">
        <v-label>Gender</v-label>
        <p>{{ selectedPatient.gender }}</p>
      </v-col>
      <!-- <v-col cols="1" v-if="selectedPatientAutocomplete">
        <v-label>Test</v-label>
        <p>{{ selectedPatientAutocomplete }}</p>
      </v-col> -->
    </v-row>

    <!-- EXAMPLE Carousel Raw-->
    <!-- <v-col cols="4">
      <v-label>Example</v-label>
      <v-carousel >
        <v-carousel-item
          src="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
          cover
        ></v-carousel-item>

        <v-carousel-item
          src="https://cdn.vuetifyjs.com/images/cards/hotel.jpg"
          cover
        ></v-carousel-item>

        <v-carousel-item
          src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
          cover
        ></v-carousel-item>
      </v-carousel>
    </v-col> -->

    <v-row>
      <v-col cols="3">
        <v-container>
          <h2 class="text-center">Epic Flowsheet Data</h2>
          <h3 class="text-center">(Tabular Data)</h3>
          <p class="mt-16 text-center">Visual Activity</p>
          <p class="mt-16 text-center">Corneal Thickness</p>
          <p class="mt-16 text-center">IOP</p>
          <p class="mt-16 text-center">C/D Ratio</p>
          <p class="mt-16 text-center">Previous Assessment/Plan?</p>
        </v-container>
      </v-col>

      <v-col cols="9">
        <!-- Col of Carousels -->
        <!-- First Row -->
        <v-row>
          <!-- Optic Disk Serial Photo -->
          <v-col cols="6">

            <v-btn
              color="#D0B97D"
              @click="toggleOpticDiskSerialPhotoDialog"
            >
              Optic Disk Serial Photo
            </v-btn>
            <!-- Small Carousel -->
            <v-carousel progress="#D0B97D">
              <v-carousel-item cover v-for="(item, index) in imageSet.NonMyds">

                <v-row>
                  <v-col cols="12">
                    <v-img :src="item.image_left" cover width="80%" class="mx-auto" />
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols="12">
                    <v-img :src="item.image_right" cover width="80%" class="mx-auto" />
                  </v-col>
                </v-row>

              </v-carousel-item>

            </v-carousel>

            <!-- Large Carousel -->
            <v-dialog v-model="opticDiskSerialPhotoDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>Optic Disk Serial Photo</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item cover v-for="(item, index) in imageSet.NonMyds">

                      <v-row>
                        <v-col cols="12">
                          <v-img :src="item.image_left" cover width="80%" class="mx-auto" />
                        </v-col>
                      </v-row>
                      <v-row>
                        <v-col cols="12">
                          <v-img :src="item.image_right" cover width="80%" class="mx-auto" />
                        </v-col>
                      </v-row>

                    </v-carousel-item>
                  </v-carousel>
                </v-card-text>
                <v-card-actions>
                  <v-btn color="#D0B97D" block @click="toggleOpticDiskSerialPhotoDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- First Col -->


          <!-- Visual Field -->
          <v-col cols="6">
            <v-btn
              color="#D0B97D"
              @click="toggleVisualFieldDialog"
            >
              Visual Field
            </v-btn>
            <!-- Small Carousel -->
            <v-carousel progress="#D0B97D">
              <v-carousel-item cover v-for="(item, index) in imageSet.HFA3s">
                <v-row>
                  <v-col cols="6">
                    <v-img :src="item.image_left" class="image-fill" />
                  </v-col>
                  <v-col cols="6">
                    <v-img :src="item.image_right" class="image-fill" />
                  </v-col>
                </v-row>

              </v-carousel-item>
            </v-carousel>

            <!-- Large Carousel -->

            <v-dialog v-model="visualFieldDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>Visual Field</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item cover v-for="(item, index) in imageSet.HFA3s">
                      <v-row>
                        <v-col cols="6">
                          <v-img :src="item.image_left" class="image-fill" />
                        </v-col>
                        <v-col cols="6">
                          <v-img :src="item.image_right" class="image-fill" />
                        </v-col>
                      </v-row>

                    </v-carousel-item>
                  </v-carousel>
                </v-card-text>
                <v-card-actions>
                  <v-btn color="#D0B97D" block @click="toggleVisualFieldDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- Second Col -->
        </v-row> <!-- First Row -->
        <!-- --------------------Next Row Of Carousels---------------------- -->

        <!-- Second Row -->
        <v-row>

          <!-- OCT GCC Report -->
          <v-col cols="6">
            <!-- Small Carousel -->
            <v-btn
              color="#D0B97D"
              @click="toggleOCTGCCReportDialog"
            >
              OCT GCC Report
            </v-btn>
            <v-carousel progress="#D0B97D">
              <v-carousel-item v-for="(item, index) in imageSet.OCT_GCCs" :src="item.image" cover></v-carousel-item>
            </v-carousel>

            <!-- Large Carousel -->

            <v-dialog v-model="OCTGCCReportDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>OCT GCC Report</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item v-for="(item, index) in imageSet.OCT_GCCs" :src="item.image" cover></v-carousel-item>
                  </v-carousel>
                </v-card-text>
                <v-card-actions>
                  <v-btn color="#D0B97D" block @click="toggleOCTGCCReportDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- First Col -->

          <!-- OCT RNFL Report -->
          <v-col cols="6">
            <!-- Small Carousel -->
            <v-btn
              color="#D0B97D"
              @click="toggleOCTRNFLReportDialog"
            >
              OCT RNFL Report
            </v-btn>
            <v-carousel @click="toggleOCTRNFLReportDialog" progress="#D0B97D">
              <v-carousel-item v-for="(item, index) in imageSet.OCT_RNFLs" :src="item.image" cover></v-carousel-item>
            </v-carousel>

            <!-- Large Carousel -->

            <v-dialog v-model="OCTRNFLReportDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>OCT RNFL Report</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item v-for="(item, index) in imageSet.OCT_RNFLs" :src="item.image"
                      cover></v-carousel-item>

                  </v-carousel>
                </v-card-text>
                <v-card-actions>
                  <v-btn color="#D0B97D" block @click="toggleOCTRNFLReportDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- Second Col -->
        </v-row> <!-- Second Row -->
      </v-col> <!-- Col of Carousels -->
    </v-row>
  </v-container>

</template>


<script lang="ts">

// import MRNSearch from '@/components/General_Components/MRNSearch.vue'

export default {
  name:"GlaucomaView",
  // components: {
  //   MRNSearch
  // },
  data: () => ({
    group: null,
    opticDiskSerialPhotoDialog: false,
    visualFieldDialog: false,
    OCTGCCReportDialog: false,
    OCTRNFLReportDialog: false,
    selectedPatientAutocomplete: '',
    selectedPatient: {
        "mrn": 0,
        "name": '',
        "age": 0,
        "gender": ''
      },
    patients: [
      {
        "mrn": 1234567,
        "name": "Jim ASDFASD",
        "age": 73,
        "gender": "Male"
      },
      {
        "mrn": 7654321,
        "name": "Someone Else",
        "age": 44,
        "gender": "Female"
      },
    ],
    imageSet: {
      mrn:0,
      OCT_GCCs: [
        { image: "" },
        { image: "" },
        { image: "" },
      ],
      OCT_RNFLs: [
        { image: "" },
        { image: "" },
        { image: "" },
      ],
      HFA3s: [
        {
          image_left: "",
          image_right: ""
        },
        {
          image_left: "",
          image_right: ""
        },
        {
          image_left: "",
          image_right: ""
        },
      ],
      NonMyds: [
        {
          image_left: "",
          image_right: ""
        },
        {
          image_left: "",
          image_right: ""
        },
        {
          image_left: "",
          image_right: ""
        },
      ],
    },
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

  methods: {
    alert: function () {
      alert("Not Implemented");
    },
    toggleOpticDiskSerialPhotoDialog() {
      this.opticDiskSerialPhotoDialog === true ? this.opticDiskSerialPhotoDialog = false : this.opticDiskSerialPhotoDialog = true
    },
    toggleVisualFieldDialog() {
      this.visualFieldDialog === true ? this.visualFieldDialog = false : this.visualFieldDialog = true
    },
    toggleOCTGCCReportDialog() {
      this.OCTGCCReportDialog === true ? this.OCTGCCReportDialog = false : this.OCTGCCReportDialog = true
    },
    toggleOCTRNFLReportDialog() {
      this.OCTRNFLReportDialog === true ? this.OCTRNFLReportDialog = false : this.OCTRNFLReportDialog = true
    },
    test() {
      debugger
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
}
</script>

<style>
/* Add margin to the top of each heading */
/* .fffmt-4 {
    margin: 50px 0 0 0; 
  } */
</style>