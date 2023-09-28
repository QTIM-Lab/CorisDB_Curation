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

export default { // for drawer re-lookup vue code
  data: () => ({
    // drawer: false,
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
        "mrn": 1495479,
        "name": "Josef Nackowicz",
        "age": 73,
        "gender": "Male"
      },
      {
        "mrn": 1495477,
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
        mrn:1495479,
        OCT_GCCs: [
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_GCC/axis01_2718_257290_201812121003305086566c389f7aedd37.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_GCC/axis01_2718_322787_201912110843296879003f718d1e9faaa.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_GCC/axis01_2718_379845_20201012101225947bece3371fd0eabac.png" },
        ],
        OCT_RNFLs: [
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_RNFL/axis01_2718_137146_2016101007523003154571c199e94acf7.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_RNFL/axis01_2718_187209_20171016074010726cec01ffa62735020.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_RNFL/axis01_2718_322787_201912110839428129c4db2734249c12e.png" },
        ],
        HFA3s: [
          {
            image_left: "/chosen_ones/HFA3x/left/pdf_1.2.276.0.75.2.5.80.25.3.201012095444155.345051356800.2015915086/page_1.png",
            image_right: "/chosen_ones/HFA3x/right/pdf_1.2.276.0.75.2.5.80.25.3.201012095448293.345051356800.2015915120/page_1.png"
          },
          {
            image_left: "/chosen_ones/HFA3x/left/pdf_1.2.276.0.75.2.5.80.25.3.191211083158643.345051356800.1860673760/page_1.png",
            image_right: "/chosen_ones/HFA3x/right/pdf_1.2.276.0.75.2.5.80.25.3.191211083203099.345051356800.1860673788/page_1.png"
          },
          {
            image_left: "/chosen_ones/HFA3x/left/pdf_1.2.276.0.75.2.5.80.25.3.201012095444155.345051356800.2015915086/page_1.png",
            image_right: "/chosen_ones/HFA3x/right/pdf_1.2.276.0.75.2.2.30.2.7.20220207070758.860.18611/page_1.png"
          },
        ],
        NonMyds: [
          {
            image_left: "/chosen_ones/NonMyd/left/axis01_2718_287449_201906120816228504c88b713b03a6df0.png",
            image_right: "/chosen_ones/NonMyd/right/axis01_2718_287449_20190612081622678981e820ee30f1d26.png"
          },
          {
            image_left: "/chosen_ones/NonMyd/left/axis01_2718_350677_20200610084935917b13100e8705fb78.png",
            image_right: "/chosen_ones/NonMyd/right/axis01_2718_350677_20200610084935854a8defbb98c1f9880.png"
          },
          {
            image_left: "/chosen_ones/NonMyd/left/axis01_2718_419438_20210412084929850ff8a454d5aec54cd.png",
            image_right: "/chosen_ones/NonMyd/right/axis01_2718_419438_20210412084929928d65ec55b1d686de8.png"
          },
        ],
      },
      {
        mrn: 1495477,
        OCT_GCCs: [
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_GCC/axis01_2718_379845_20201012101225947bece3371fd0eabac.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_GCC/axis01_2718_322787_201912110843296879003f718d1e9faaa.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_GCC/axis01_2718_257290_201812121003305086566c389f7aedd37.png" },
        ],
        OCT_RNFLs: [
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_RNFL/axis01_2718_322787_201912110839428129c4db2734249c12e.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_RNFL/axis01_2718_187209_20171016074010726cec01ffa62735020.png" },
          { image: "/chosen_ones/Cirrus_OCT/Cirrus_OCT_RNFL/axis01_2718_137146_2016101007523003154571c199e94acf7.png" },
        ],
        HFA3s: [
          {
            image_right: "/chosen_ones/HFA3x/left/pdf_1.2.276.0.75.2.5.80.25.3.201012095444155.345051356800.2015915086/page_1.png",
            image_left: "/chosen_ones/HFA3x/right/pdf_1.2.276.0.75.2.5.80.25.3.201012095448293.345051356800.2015915120/page_1.png"
          },
          {
            image_right: "/chosen_ones/HFA3x/left/pdf_1.2.276.0.75.2.5.80.25.3.191211083158643.345051356800.1860673760/page_1.png",
            image_left: "/chosen_ones/HFA3x/right/pdf_1.2.276.0.75.2.5.80.25.3.191211083203099.345051356800.1860673788/page_1.png"
          },
          {
            image_right: "/chosen_ones/HFA3x/left/pdf_1.2.276.0.75.2.5.80.25.3.201012095444155.345051356800.2015915086/page_1.png",
            image_left: "/chosen_ones/HFA3x/right/pdf_1.2.276.0.75.2.2.30.2.7.20220207070758.860.18611/page_1.png"
          },
        ],
        NonMyds: [
          {
            image_right: "/chosen_ones/NonMyd/left/axis01_2718_287449_201906120816228504c88b713b03a6df0.png",
            image_left: "/chosen_ones/NonMyd/right/axis01_2718_287449_20190612081622678981e820ee30f1d26.png"
          },
          {
            image_right: "/chosen_ones/NonMyd/left/axis01_2718_350677_20200610084935917b13100e8705fb78.png",
            image_left: "/chosen_ones/NonMyd/right/axis01_2718_350677_20200610084935854a8defbb98c1f9880.png"
          },
          {
            image_right: "/chosen_ones/NonMyd/left/axis01_2718_419438_20210412084929850ff8a454d5aec54cd.png",
            image_left: "/chosen_ones/NonMyd/right/axis01_2718_419438_20210412084929928d65ec55b1d686de8.png"
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