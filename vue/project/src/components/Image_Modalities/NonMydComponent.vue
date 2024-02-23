<template>
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
</template>

<script lang="ts">
export default {
  data: () => ({
    opticDiskSerialPhotoDialog: false,
    imageSet: {
      mrn:0,
      NonMyds: [
          {
            image_left: "https://upload.wikimedia.org/wikipedia/commons/7/7f/Retinography.jpg",
            image_right: "https://upload.wikimedia.org/wikipedia/commons/7/7f/Retinography.jpg"
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
  }),
  mounted() {
    console.log("ImageComponent mounted!");
    this.test();
  },
  methods: {
    test: function () {
      console.log("ImageComponent loaded successfully!");
    },
    toggleOpticDiskSerialPhotoDialog() {
      this.opticDiskSerialPhotoDialog === true ? this.opticDiskSerialPhotoDialog = false : this.opticDiskSerialPhotoDialog = true
    },
  },
};
</script>

