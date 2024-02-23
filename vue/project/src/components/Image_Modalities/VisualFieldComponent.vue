<template>
<v-btn
color="#D0B97D"
@click="toggleOpticDiskSerialPhotoDialog"
>
Visual Field Photo
</v-btn>
<!-- Small Carousel -->
<v-carousel progress="#D0B97D">
<v-carousel-item cover v-for="(item, index) in imageSet.VisualField">

  <v-row>
    <v-col cols="12">
      <br>
      <br>
      <br>
      <v-img :src="item.image" cover width="80%" class="mx-auto" />
    </v-col>
  </v-row>

</v-carousel-item>

</v-carousel>

<!-- Large Carousel -->
<v-dialog v-model="opticDiskSerialPhotoDialog" width="100%">

<v-card>
  <v-card-text>
    <v-label>Visual Field Photo</v-label>
    <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
      <v-carousel-item cover v-for="(item, index) in imageSet.VisualField">

        <v-row>
          <v-col cols="12">
            <v-img :src="item.image" cover width="80%" class="mx-auto" />
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
      VisualField: [
          {
            image: "https://www.reviewofophthalmology.com/CMSImagesContent/2021/04/RP/GM-1.jpg  ",
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

