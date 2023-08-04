<template>
    <div>
      <canvas id="bar-chart"></canvas>
    </div>
</template>
  
<script lang="ts">
import { Chart } from 'chart.js/auto'

export default {
  name: 'BarChart',
  props: {rawData: { type: Array, required: true, item: Number },
  },
  data() {
    return {
      // myChart = [],
      chart_data: {
        labels: [] as string[],
        datasets: [{
          label: 'Summary Stats',
          data: [] as number[],
          backgroundColor: [] as string[],
          borderColor: [] as string[],
          borderWidth: 1
        }]
      }
    }
  },
  created: function() {
    console.log("In created from BarChart.vue")
  },
  mounted: function() {
    console.log("In mounted from BarChart.vue")
    const LABELS: string[] = [];
    const DATA: number[] = [];
    const BACKGROUND_COLOR: string[] = [];
    const BORDER_COLOR: string[] = [];
    var MAX_VAL: number = 0;
    debugger
    this.rawData.forEach(function(v: any, i: any, a: any) {
      var columns = Object.keys(v)
      LABELS.push(v[columns[0]])
      DATA.push(v[columns[1]])
      debugger
      MAX_VAL = Math.max(MAX_VAL, v[columns[1]])
      console.log(MAX_VAL)
    })
    this.rawData.forEach(function(v: any, i: any, a: any) {
      var columns = Object.keys(v)
      var bit_val = 255 * (v[columns[1]]/MAX_VAL)
      console.log(bit_val)
      debugger
      BACKGROUND_COLOR.push(`rgba(${bit_val}, ${bit_val}, ${bit_val}, 0.2)`)
      BORDER_COLOR.push(`rgb(${bit_val}, ${bit_val}, ${bit_val})`)
    })
    this.chart_data.labels = LABELS;
    this.chart_data.datasets[0].data = DATA;
    this.chart_data.datasets[0].backgroundColor = BACKGROUND_COLOR;
    this.chart_data.datasets[0].borderColor = BORDER_COLOR;
    debugger
    const ctx = document.getElementById('bar-chart') as HTMLCanvasElement;
    new Chart(ctx, {
        type: 'bar',
        data: this.chart_data,
        options: {
          scales: {
            y: {
              beginAtZero: true
            }
          }
        },
      });
    // this.chart_data
    // this.myChart.data = this.chart_data;
  }
}
</script>