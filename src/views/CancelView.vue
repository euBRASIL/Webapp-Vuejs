<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="12" md="8">
        <v-card>
          <v-img
            src="https://cdn.vuetifyjs.com/images/cards/docks.jpg"
            height="200px"
          >
          </v-img>

          <v-card-text>
            <v-alert type="warning" border="left" elevation="2">
              Compra não concluída.
            </v-alert>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'CancelView',

  components: {
  },

  data: () => ({
  }),

  methods: {
  }
}
</script>
