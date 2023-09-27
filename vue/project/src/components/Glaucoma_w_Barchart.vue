<template>
  <v-container>
    <h1>{{ message }}</h1>
    
    <BarChart 
    :rawData="table_glaucoma_summary_stats"
    />

    <v-table theme="dark">
      <thead>
        <tr>
          <th>age_and_other_bins</th>
          <th>patient_counts</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="item in table_glaucoma_summary_stats"
          :key="item.age_and_other_bins"
        >
          <td>
          {{ item.age_and_other_bins }}
          </td>
          <td>
          {{ item.patient_counts }}
          </td>

        </tr>
      </tbody>
    </v-table>

  </v-container>
</template>

<script lang="ts">
import BarChart from '@/components/BarChart.vue'
export default {
  props: {
    sshPortForward: String
  },
  components: {
    BarChart
  },
  data: function () {
    return {
      message: 'Welcome to the Glaucoma Page',
      host: '0.0.0.0',
      table_glaucoma_summary_stats: [{ age_and_other_bins: "bin_default", patient_counts: 0 }],
      cols_glaucoma_summary_stats: [{ col_name: 'age_and_other_bins' }, { col_name: 'patient_counts' }],
    }
  },
  created: function() {
    console.log('Component created.')
  },
  mounted() {
    console.log('Component mounted.')
    this.get_glaucoma_stats()
    // debugger
  },
  methods: {
    get_glaucoma_stats: function() {
      var _this = this;
      const url = `http://${this.host}:${this.sshPortForward}/api/glaucoma_summary_stats`
      // debugger
      console.log(url)
      fetch(url)
        .then(response => response.json())
        .then(data => {
          // Do something with the returned data
          console.log("AAAAAAA")
          _this.table_glaucoma_summary_stats = data
          // var cgss : object[] = this.cols_glaucoma_summary_stats
          // var cgss: { col_name: String }[] = [];
          // var cgss = [];
          Object.keys(data[0]).forEach((v,i,a) => {
            // cgss.push({ col_name: v })
            _this.cols_glaucoma_summary_stats.push({ col_name: v })
          })
        })
        .catch(error => {
          // Handle any errors that occurred during the fetch request
        });
    },
  }
}
</script>
