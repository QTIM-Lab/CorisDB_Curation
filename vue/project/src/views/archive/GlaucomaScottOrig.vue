<template>
  <v-container>
    <v-app-bar app>
      <v-app-bar-nav-icon @click="drawer = !drawer" />
      <v-app-bar-title>
        {{ companyName }}
      </v-app-bar-title>
      <v-spacer></v-spacer>
      <v-btn text @click="navigateTo('Nav1')" class="mr-4">
        Glaucoma
      </v-btn>
      <v-btn text @click="navigateTo('Nav2')" class="mr-4">
        Retina
      </v-btn>
      <v-btn text @click="navigateTo('Nav3')">
        Cornea
      </v-btn>
      <v-app-bar-nav-icon @click="openNotifications" class="mr-4">
        <v-icon>mdi-bell</v-icon>
      </v-app-bar-nav-icon>
      <v-app-bar-nav-icon @click="openProfile">
        <v-icon>mdi-account-circle</v-icon>
      </v-app-bar-nav-icon>
    </v-app-bar>

    <v-navigation-drawer app v-model="drawer">
      <v-list>
        <v-list-item v-for="(item, index) in navigationLinks" :key="index" link>
          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-card class="mx-auto mt-4">
      <v-card-text>
        <v-row align="center">
          <v-col cols="9">
            <v-text-field v-model="searchQuery" label="Patient Query (MRN, Name, etc)" outlined></v-text-field>
          </v-col>
          <v-col cols="3">
            <v-btn color="primary" @click="search">Search</v-btn>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
    
    <!-- Top Row -->
    <v-row class="mt-4">
      <v-col v-for="(carousel, index) in carouselsTop" :key="'top-' + index" cols="4">
        <div class="carousel-title" v-if="!carousel.expanded" @click="toggleCarouselTop(index)">{{ carousel.title }}</div>
        <div :class="{'expanded-carousel-overlay': carousel.expanded}">
          <v-carousel v-if="!carousel.expanded">
            <v-carousel-item v-for="(image, imgIndex) in carousel.images" :key="'top-' + index + '-' + imgIndex" :src="image" cover></v-carousel-item>
          </v-carousel>
          <v-carousel v-else>
            <v-carousel-item v-for="(image, imgIndex) in carousel.images" :key="'top-' + index + '-expanded-' + imgIndex" :src="image" contain></v-carousel-item>
            <div class="close-button" @click="toggleCarouselTop(index)">Close</div>
          </v-carousel>
        </div>
      </v-col>
    </v-row>

    <!-- Bottom Row -->
    <v-row class="d-flex justify-center">
      <v-col v-for="(carousel, index) in carouselsBottom" :key="'bottom-' + index" cols="4">
        <div class="carousel-title" v-if="!carousel.expanded" @click="toggleCarouselBottom(index)">{{ carousel.title }}</div>
        <div :class="{'expanded-carousel-overlay': carousel.expanded}">
          <v-carousel v-if="!carousel.expanded">
            <v-carousel-item v-for="(image, imgIndex) in carousel.images" :key="'bottom-' + index + '-' + imgIndex" :src="image" cover></v-carousel-item>
          </v-carousel>
          <v-carousel v-else>
            <v-carousel-item v-for="(image, imgIndex) in carousel.images" :key="'bottom-' + index + '-expanded-' + imgIndex" :src="image" contain></v-carousel-item>
            <div class="close-button" @click="toggleCarouselBottom(index)">Close</div>
          </v-carousel>
        </div>
      </v-col>
    </v-row>

  </v-container>
</template>

<style scoped>
.carousel-title {
  text-align: center;
  font-size: 24px;
  margin-bottom: 10px;
  color: #1976D2;
  font-weight: bold;
  text-transform: uppercase;
  cursor: pointer;
}

.carousel-title:hover {
  text-decoration: underline;
}

.expanded-carousel-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 9999;
  background-color: rgba(0, 0, 0, 0.9);
  display: flex;
  justify-content: center;
  align-items: center;
}

.carousel-image {
  object-fit: contain !important; /* Scale image to fit within the carousel item */
  width: 100%; /* Ensure image width covers the carousel item */
  height: 100%; /* Ensure image height covers the carousel item */
}

.close-button {
  position: absolute;
  top: 1rem;
  right: 1rem;
  cursor: pointer;
  color: white;
}
</style>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

const sshPortForward = 'TODO';

const companyName = ref('CU Anschutz Dept. of Ophthalmology');
const drawer = ref(false);

const navigationLinks = [
  { title: 'John Doe' },
  { title: 'Jane Dole' },
  { title: 'Adam Person' },
  { title: 'Zach Humane' }
];

// Top Row Carousels
const carouselsTop = ref([
  { title: 'Fundus', images: ['https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Fundus_photograph_of_normal_right_eye.jpg/1200px-Fundus_photograph_of_normal_right_eye.jpg', 'https://webeye.ophth.uiowa.edu/eyeforum/atlas/LARGE/Normal-fundus-LRG.jpg'], expanded: false },
  { title: 'Visual Field', images: ['https://www.aao.org/image.axd?id=90702bb6-8daa-469f-afcb-255b878f9e02&t=636841867828800000', 'https://eyeguru.org/wp-content/uploads/2016/06/image10.png'], expanded: false },
  { title: 'OCT Report', images: ['https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fwww.reviewofoptometry.com%2FCMSImagesContent%2F2020%2F02%2F042_ro0220_Schott_f1.jpg', 'https://media.springernature.com/lw685/springer-static/image/art%3A10.1186%2Fs40942-020-0208-5/MediaObjects/40942_2020_208_Fig1_HTML.png'], expanded: false }
]);

// Bottom Row Carousels
const carouselsBottom = ref([
  { title: 'OCT B-Scan TP1', images: ['https://www.researchgate.net/publication/322700713/figure/fig1/AS:963434019569727@1606711978618/OCT-B-scan-of-a-normal-eye-imaged-using-SS-OCT-The-B-scan-is-16mm-in-length-and-offers.gif'], expanded: false },
  { title: 'OCT B-Scan TP2', images: ['https://www.researchgate.net/publication/322700713/figure/fig1/AS:963434019569727@1606711978618/OCT-B-scan-of-a-normal-eye-imaged-using-SS-OCT-The-B-scan-is-16mm-in-length-and-offers.gif'], expanded: false },
]);

// Add the carousel toggle functions
const toggleCarouselTop = (index: number) => {
  carouselsTop.value[index].expanded = !carouselsTop.value[index].expanded;
};

const toggleCarouselBottom = (index: number) => {
  carouselsBottom.value[index].expanded = !carouselsBottom.value[index].expanded;
};

const searchQuery = ref(""); // Add this line to define the search query

const search = () => {
  // Implement your search logic here using the "searchQuery" data
  console.log("Searching for:", searchQuery.value);
}

const openNotifications = () => {
  // Implement your notifications logic here
};

const openProfile = () => {
  // Implement your profile logic here
};

const navigateTo = (navItem: String) => {
  // Implement your navigation logic here based on the clicked item
  console.log(`Navigating to ${navItem}`);
}

// onMounted(() => {
//   console.log('Component mounted.');
//   get_glaucoma_stats();
// });

// const get_glaucoma_stats = () => {
//   const host = '0.0.0.0';
//   const url = `http://${host}:${sshPortForward}/api/glaucoma_summary_stats`;

//   console.log(url);
//   table_glaucoma_summary_stats.value = [{ age_and_other_bins: "Hi", patient_counts: 2}]
//   cols_glaucoma_summary_stats.value.push({ col_name: "yo"})

//   fetch(url)
//     .then(response => response.json())
//     .then(data => {
//       // Do something with the returned data
//       console.log("AAAAAAA");
//       table_glaucoma_summary_stats.value = data;

//       Object.keys(data[0]).forEach((v, i, a) => {
//         cols_glaucoma_summary_stats.value.push({ col_name: v });
//       });
//     })
//     .catch(error => {
//       // Handle any errors that occurred during the fetch request
//     });
// };
</script>
