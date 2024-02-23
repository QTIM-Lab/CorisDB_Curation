<template>
<v-btn
color="#D0B97D"
@click="toggleOpticDiskSerialPhotoDialog"
>
OCT GCC Photo
</v-btn>
<!-- Small Carousel -->
<v-carousel progress="#D0B97D">
<v-carousel-item cover v-for="(item, index) in imageSet.images">

  <v-row>
    <v-col cols="12">
      <v-img :src="item.image" cover width="80%" class="mx-auto" />
    </v-col>
  </v-row>

</v-carousel-item>

</v-carousel>

<!-- Large Carousel -->
<v-dialog v-model="opticDiskSerialPhotoDialog" width="100%">

<v-card>
  <v-card-text>
    <v-label>OCT GCC Photo</v-label>
    <v-carousel height="100%" progress="#D0B97D" hide-delimiters>
      <v-carousel-item cover v-for="(item, index) in imageSet.images">

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
      images: [
          {
            image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl9jM5gcpiOrVDzKgFLA4vknAohcxM_dwDMg&usqp=CAU",
          },
          {
            image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl9jM5gcpiOrVDzKgFLA4vknAohcxM_dwDMg&usqp=CAU",
          }
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

