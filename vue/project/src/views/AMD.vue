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
      <v-col cols="5">
        <v-row>
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
        <v-row>
          <v-slider
            :ticks="tickLabels"
            :max="2"
            step="1"
            show-ticks="always"
            tick-size="4"
          ></v-slider>
        </v-row>
      </v-col>

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
          <p class="mt-16 text-center">Chief Complaint</p>
          <p class="mt-16 text-center">Visual Acuity</p>
          <p class="mt-16 text-center">IOP</p>
          <p class="mt-16 text-center">Vitreous</p>
          <p class="mt-16 text-center">Macula</p>
          <p class="mt-16 text-center">Peripheral Retina</p>
          <p class="mt-16 text-center">Previous Assessment/Plan</p>
        </v-container>
      </v-col>

      <v-col cols="9">
        <!-- Col of Carousels -->
        <!-- First Row -->
        <v-row>
          <!-- Eidon Photo -->
          <v-col cols="6">

            <v-btn
              color="#D0B97D"
              @click="toggleEidonDialog"
            >
              Eidon
            </v-btn>
            <!-- Small Carousel -->
            <v-carousel progress="#D0B97D">
              <v-carousel-item cover v-for="(item, index) in imageSet.Eidon">

                <v-row>
                  <!-- Invert for anatomical view -->
                  <v-col cols="6">
                    <v-img :src="item.image_right" class="image-fill" />
                  </v-col>
                  <v-col cols="6">
                    <v-img :src="item.image_left" class="image-fill" />
                  </v-col>
                </v-row>

              </v-carousel-item>

            </v-carousel>

            <!-- Large Carousel -->
            <v-dialog v-model="EidonDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>Eidon Photo</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item cover v-for="(item, index) in imageSet.Eidon">

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
                  <v-btn color="#D0B97D" block @click="toggleEidonDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- First Col -->


          <!-- Spectralis OCT AF -->
          <v-col cols="6">
            <v-btn
              color="#D0B97D"
              @click="toggleSpectralisOCTAFDialog"
            >
            Spectralis OCT AF
            </v-btn>
            <!-- Small Carousel -->
            <v-carousel progress="#D0B97D">
              <v-carousel-item cover v-for="(item, index) in imageSet.SpectralisOCTAF">
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

            <v-dialog v-model="SpectralisOCTAFDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>Spectralis OCT AF</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item cover v-for="(item, index) in imageSet.SpectralisOCTAF">
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
                  <v-btn color="#D0B97D" block @click="toggleSpectralisOCTAFDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- Second Col -->
        </v-row> <!-- First Row -->
        <!-- --------------------Next Row Of Carousels---------------------- -->

        <!-- Second Row -->
        <v-row>

          <!-- Spectralis B Scans -->
          <v-col cols="6">
            <v-btn
              color="#D0B97D"
              @click="toggleSpectralisOCTBScanDialog"
            >
            Spectralis B (OS) Scans
            </v-btn>
            <!-- Small Carousel -->
            <v-carousel @click="toggleSpectralisOCTReportDialog" progress="#D0B97D">
              <v-carousel-item v-for="(item, index) in imageSet.SpectralisOCTBScanLeft" :src="item.image" cover></v-carousel-item>
            </v-carousel>

            <!-- Large Carousel -->

            <v-dialog v-model="SpectralisOCTBScanDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>Spectralis B Scans</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item cover v-for="(item, index) in imageSet.SpectralisOCTBScan">
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
                  <v-btn color="#D0B97D" block @click="toggleSpectralisOCTBScanDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- First Col -->

          <!-- Spectralis B Scans -->
          <v-col cols="6">
            <v-btn
              color="#D0B97D"
              @click="toggleSpectralisOCTBScanDialog"
            >
            Spectralis B (OD) Scans
            </v-btn>
            <!-- Small Carousel -->
            <v-carousel @click="toggleSpectralisOCTReportDialog" progress="#D0B97D">
              <v-carousel-item v-for="(item, index) in imageSet.SpectralisOCTBScanRight" :src="item.image" cover></v-carousel-item>
            </v-carousel>

            <!-- Large Carousel -->

            <v-dialog v-model="SpectralisOCTBScanDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>Spectralis B Scans</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item cover v-for="(item, index) in imageSet.SpectralisOCTBScan">
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
                  <v-btn color="#D0B97D" block @click="toggleSpectralisOCTBScanDialog">Close Dialog</v-btn>
                </v-card-actions>
              </v-card>

            </v-dialog>

          </v-col> <!-- First Col -->
        </v-row> <!-- Second Row -->

        <!-- Second Row -->
        <v-row>

          <!-- Spectralis OCT Report -->
          <v-col cols="6">
            <!-- Small Carousel -->
            <v-btn
              color="#D0B97D"
              @click="toggleSpectralisOCTReportDialog"
            >
            Spectralis OCT Report
            </v-btn>
            <v-carousel @click="toggleSpectralisOCTReportDialog" progress="#D0B97D">
              <v-carousel-item v-for="(item, index) in imageSet.SpectralisOCTReport" :src="item.image" cover></v-carousel-item>
            </v-carousel>

            <!-- Large Carousel -->

            <v-dialog v-model="SpectralisOCTReportDialog" width="100%">

              <v-card>
                <v-card-text>
                  <v-label>Spectralis OCT Report</v-label>
                  <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
                    <v-carousel-item v-for="(item, index) in imageSet.SpectralisOCTReport" :src="item.image"
                      cover></v-carousel-item>

                  </v-carousel>
                </v-card-text>
                <v-card-actions>
                  <v-btn color="#D0B97D" block @click="toggleSpectralisOCTReportDialog">Close Dialog</v-btn>
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
      EidonDialog: false,
      SpectralisOCTAFDialog: false,
      SpectralisOCTBScanDialog: false,
      SpectralisOCTReportDialog: false,
      selectedPatientAutocomplete: '',
      tickLabels: {
            0: '2022-03-02',
            1: '2022-03-02',
            2: '2022-03-02',
          },
      selectedPatient: {
          "mrn": 0,
          "name": '',
          "age": 0,
          "gender": ''
        },
      patients: [
        {
          "mrn": 913408,
          "name": "Victoria Norris",
          "age": 74,
          "gender": "Female"
        },
        {
          "mrn": 1495477,
          "name": "Someone Else",
          "age": 64,
          "gender": "Male"
        },
      ],
      imageSet: {
        mrn:0,
        SpectralisOCTReport: [
          { image: "" },
        ],
        SpectralisOCTBScanLeft: [
            { image: "" },
          ],
        SpectralisOCTBScanRight: [
          { image: "" },
        ],
        SpectralisOCTBScan: [
        {
            image_left: "",
            image_right: ""
          },

        ],
        SpectralisOCTAF: [
          {
            image_left: "",
            image_right: ""
          },
        ],
        Eidon: [
          {
            image_left: "",
            image_right: ""
          },
        ],
      },
      patientImages: [
        {
          mrn:913408,
          SpectralisOCTReport: [
            { image: "/chosen_ones_amd/Spectralis_OCT_Report/axis01_7286_492843_20220302093139761f0da368dccc78a1f.png" },
          ],
          SpectralisOCTBScanLeft: [
            { image: "/chosen_ones_amd/Spectralis_OCT_B_Scans/left/LEFT.jpg" },
          ],
          SpectralisOCTBScanRight: [
            { image: "/chosen_ones_amd/Spectralis_OCT_B_Scans/right/RIGHT.jpg" },
          ],
          SpectralisOCTBScan: [
            {
              image_left: "/chosen_ones_amd/Spectralis_OCT_B_Scans/left/axis01_7286_492842_20220302093108607ec9fde881e285333.png",
              image_right: "/chosen_ones_amd/Spectralis_OCT_B_Scans/right/axis01_7286_492842_202203020931334112c090c1471cce01b.png"
            },
          ],
          SpectralisOCTAF: [
            {
              image_left: "/chosen_ones_amd/Spectralis_OCT_AF/left/axis01_7286_492842_202203020931174052fba45d1f6216123.png",
              image_right: "/chosen_ones_amd/Spectralis_OCT_AF/right/axis01_7286_492842_20220302093142085e18105f4934ca2eb.png"
            },
          ],
          Eidon: [
            {
              image_left: "/chosen_ones_amd/Eidon/left/axis01_7286_492841_20220302093059948f15012311f3a6ff.png",
              image_right: "/chosen_ones_amd/Eidon/right/axis01_7286_492841_20220302093058888d220fd006938458f.png"
            },
          ],
        },
        {
          mrn:1495477,
          SpectralisOCTReport: [
            { image: "chosen_ones_amd/Spectralis_OCT_Report/axis01_7286_492843_20220302093139761f0da368dccc78a1f.png" },
          ],
          SpectralisOCTBScanLeft: [
            {
              image: "chosen_ones_amd/Spectralis_OCT_B_Scans/left/axis01_7286_492842_20220302093108607ec9fde881e285333.png",
            },
          ],
          SpectralisOCTBScanRight: [
            {
              image: "/chosen_ones_amd/Spectralis_OCT_B_Scans/right/axis01_7286_492842_202203020931334112c090c1471cce01b.png",
            },
          ],
          SpectralisOCTBScan: [
            {
              image_left: "/chosen_ones_amd/Spectralis_OCT_B_Scans/left/axis01_7286_492842_20220302093108607ec9fde881e285333.png",
              image_right: "/chosen_ones_amd/Spectralis_OCT_B_Scans/right/axis01_7286_492842_202203020931334112c090c1471cce01b.png"
            },
          ],
          SpectralisOCTAF: [
            {
              image_left: "/chosen_ones_amd/Spectralis_OCT_AF/left/axis01_7286_492842_202203020931174052fba45d1f6216123.png",
              image_right: "/chosen_ones_amd/Spectralis_OCT_AF/right/axis01_7286_492842_20220302093142085e18105f4934ca2eb.png"
            },
          ],
          Eidon: [
            {
              image_left: "/chosen_ones_amd/Eidon/left/axis01_7286_492841_20220302093059948f15012311f3a6ff.png",
              image_right: "/chosen_ones_amd/Eidon/right/axis01_7286_492841_20220302093058888d220fd006938458f.png"
            },
          ],
        },
      ]
    }),

    methods: {
      alert: function () {
        alert("Not Implemented");
      },
      toggleEidonDialog() {
        this.EidonDialog === true ? this.EidonDialog = false : this.EidonDialog = true
      },
      toggleSpectralisOCTAFDialog() {
        this.SpectralisOCTAFDialog === true ? this.SpectralisOCTAFDialog = false : this.SpectralisOCTAFDialog = true
      },
      toggleSpectralisOCTBScanDialog() {
        this.SpectralisOCTBScanDialog === true ? this.SpectralisOCTBScanDialog = false : this.SpectralisOCTBScanDialog = true
      },
      toggleSpectralisOCTReportDialog() {
        this.SpectralisOCTReportDialog === true ? this.SpectralisOCTReportDialog = false : this.SpectralisOCTReportDialog = true
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

<style scoped>
/* Add margin to the top of each heading */
/* .fffmt-4 {
    margin: 50px 0 0 0; 
  } */
</style>
