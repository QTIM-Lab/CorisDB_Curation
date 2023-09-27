<template>
  <v-container class="fill-height">
    <v-responsive class="d-flex align-center text-center fill-height">
      <v-img
        contain
        height="300"
        src="@/assets/Colorado_Buffaloes_wordmark.png"
      />
      

      <div class="text-body-2 font-weight-light mb-n1">Welcome to</div>

      <h1 class="text-h2 font-weight-bold">CORIS DB</h1>

      <div class="py-14" />

      <v-row class="d-flex align-center justify-center">

        <v-col cols="auto">
          <v-btn
            color="#D0B97D"
            href="/coris_db/glaucoma"
            min-width="228"
            rel="noopener noreferrer"
            size="x-large"
            target="_blank"
            variant="flat"
          >
            <v-icon
              icon="mdi-speedometer"
              size="large"
              start
            />

            Glaucoma Demo
          </v-btn>
        </v-col>

        
      </v-row>
    </v-responsive>
  </v-container>
</template>

<script lang="ts" setup>
  //
</script>
