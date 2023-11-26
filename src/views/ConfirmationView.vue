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

          <v-card-title>
            <h1 class="text-h4">
              Pagemento efetuado com sucesso
            </h1>
          </v-card-title>

          <v-card-text>
            Aguarde o e-mail de confirmação do seu pedido.
            Obrigado!
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'ConfirmationView',

  components: {
  },

  data: () => ({
  }),

  methods: {
  }
}
</script>
