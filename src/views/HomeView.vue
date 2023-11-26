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
              Recarga de créditos
              <v-chip v-if="state === 'checkout'" label color="#ebe2b5" class="mx-2">
                <v-icon left>mdi-circle-multiple-outline</v-icon>
                {{ credits }} {{ credits === 1 ? 'crédito' : 'créditos' }}
              </v-chip>
              <v-chip v-if="state === 'checkout'" label color="#a9d6bb">
                <v-icon left>mdi-cash</v-icon>
                R$ {{ price }}
              </v-chip>
            </h1>
          </v-card-title>

          <v-divider class="mb-4"></v-divider>

          <v-fade-transition group>
            <template v-if="state == 'loading'">

              <v-card-text key="loading-text" class="d-flex justify-center">
                <v-progress-circular indeterminate></v-progress-circular>
              </v-card-text>

            </template>

            <template v-if="state == 'error'">

              <v-card-text key="error-text">
                <v-alert type="error" border="left" elevation="2">
                  Desculpe, ocorreu um erro inesperado. Tente novamente mais tarde.
                </v-alert>
              </v-card-text>

            </template>

            <template v-if="state == 'initial'">

              <v-card-text key="initial-text">
                <v-form ref="form">

                  <v-row align="center">
                    <v-col cols="12">
                      <v-text-field
                        v-model.number="credits"
                        label="Créditos"
                        type="number"
                        prepend-icon="mdi-minus"
                        append-outer-icon="mdi-plus"
                        @click:prepend="credits <= 1 ? null : credits--"
                        @click:append-outer="credits++"
                        :rules="rules.credits"
                      >
                      </v-text-field>
                    </v-col>
                  </v-row>

                  <v-text-field
                    label="Nome completo"
                    hide-details="auto"
                    v-model="name"
                    :rules="rules.name"
                  >
                  </v-text-field>
                  <v-text-field
                    label="Username do jogo"
                    hide-details="auto"
                    v-model="username"
                    :rules="rules.username"
                  >
                  </v-text-field>
                  <v-text-field
                    label="E-mail"
                    hide-details="auto"
                    v-model="email"
                    :rules="rules.email"
                  >
                  </v-text-field>

                </v-form>

              </v-card-text>

              <v-card-actions key="initial-actions">
                <v-btn block color="primary" @click="proceedToCheckout">
                  Seguir para o checkout
                  <v-icon right>mdi-cart-outline</v-icon>
                </v-btn>
              </v-card-actions>

            </template>

            <template v-if="state == 'checkout'">

              <v-card-text key="checkout-text">

                <v-sheet class="mb-8 px-2" elevation="4" color="#e8eaeb" style="cursor: pointer" v-ripple @click="payViaPaypal">
                  <v-row align="center">
                    <v-col cols="3">
                      <v-img src="@/assets/paypal.png" height="64px" contain></v-img>
                    </v-col>
                    <v-col>
                      <h3 class="text-h5 font-weight-light font-italic ">Pagar via PayPal</h3>
                    </v-col>
                    <v-col cols="auto">
                      <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on">mdi-credit-card-outline</v-icon>
                        </template>
                        <span>Aceita cartões de crédito e débito.</span>
                      </v-tooltip>

                      <!-- <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on" small>mdi-gamepad-circle-outline</v-icon>
                        </template>
                        <span>Aceita PIX.</span>
                      </v-tooltip>

                      <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on">mdi-barcode</v-icon>
                        </template>
                        <span>Aceita Boleto.</span>
                      </v-tooltip> -->
                    </v-col>
                  </v-row>
                </v-sheet>

                <v-sheet class="mb-8 px-2" elevation="4" color="#e8e8eb" style="cursor: pointer" v-ripple @click="payViaStripe">
                  <v-row align="center">
                    <v-col cols="3">
                      <v-img src="@/assets/stripe.png" height="64px" contain></v-img>
                    </v-col>
                    <v-col>
                      <h3 class="text-h5 font-weight-light font-italic ">Pagar via Stripe</h3>
                    </v-col>
                    <v-col cols="auto">
                      <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on">mdi-credit-card-outline</v-icon>
                        </template>
                        <span>Aceita cartões de crédito e débito.</span>
                      </v-tooltip>

                      <!-- <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on" small>mdi-gamepad-circle-outline</v-icon>
                        </template>
                        <span>Aceita PIX.</span>
                      </v-tooltip>

                      <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on">mdi-barcode</v-icon>
                        </template>
                        <span>Aceita Boleto.</span>
                      </v-tooltip> -->
                    </v-col>
                  </v-row>
                </v-sheet>

                <v-sheet class="mb-8 px-2" elevation="4" color="#ebebe8" style="cursor: pointer" v-ripple @click="payViaMercadopago">
                  <v-row align="center">
                    <v-col cols="3">
                      <v-img src="@/assets/mercadopago.png" height="64px" contain></v-img>
                    </v-col>
                    <v-col>
                      <h3 class="text-h5 font-weight-light font-italic ">Pagar via Mercado Pago</h3>
                    </v-col>
                    <v-col cols="auto">
                      <!-- <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on">mdi-credit-card-outline</v-icon>
                        </template>
                        <span>Aceita cartões de crédito e débito.</span>
                      </v-tooltip> -->

                      <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on" small>mdi-gamepad-circle-outline</v-icon>
                        </template>
                        <span>Aceita PIX.</span>
                      </v-tooltip>

                      <!-- <v-tooltip top>
                        <template v-slot:activator="{ on }">
                          <v-icon class="mr-2" v-on="on">mdi-barcode</v-icon>
                        </template>
                        <span>Aceita Boleto.</span>
                      </v-tooltip> -->
                    </v-col>
                  </v-row>
                </v-sheet>

              </v-card-text>

            </template>

          </v-fade-transition>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  name: 'HomeView',

  components: {
  },

  data: () => ({
    state: 'initial',

    // form fields
    name: '',
    username: '',
    email: '',
    credits: 1,

    id: null,
    price: null,

    // form rules
    rules: {
      name: [
        (v) => !!v || 'Nome é obrigatório'
      ],
      username: [
        (v) => !!v || 'Username é obrigatório'
      ],
      email: [
        (v) => !!v || 'E-mail é obrigatório',
        (v) => /^.+@.+\..+$/.test(v) || 'E-mail precisa ser válido'
      ],
      credits: [
        (v) => !!v || 'Créditos é obrigatório',
        (v) => v > 0 || 'Créditos precisa ser maior que 0'
      ]
    }
  }),

  methods: {

    async proceedToCheckout () {
      if (!this.$refs.form.validate()) {
        return
      }

      this.state = 'loading'

      // call api

      try {
        const response = await axios.post(process.env.VUE_APP_API_URL + '/invoice/', {
          name: this.name,
          username: this.username,
          email: this.email,
          credits: this.credits
        })

        if (!response?.data?.id || !response?.data?.price) {
          throw new Error('Invalid response')
        }

        this.id = response.data.id
        this.price = response.data.price

        this.state = 'checkout'
      } catch (e) {
        this.state = 'error'
      }
    },

    async payViaPaypal () {
      this.state = 'loading'

      // call api

      try {
        const response = await axios.get(process.env.VUE_APP_API_URL + '/invoice/' + this.id + '/paypal')

        if (!response?.data?.link) {
          throw new Error('Invalid response')
        }

        window.open(response.data.link, '_blank').focus()
        this.state = 'checkout'
      } catch (e) {
        this.state = 'error'
        setTimeout(() => {
          this.state = 'checkout'
        }, 3000)
      }
    },

    async payViaStripe () {
      this.state = 'loading'

      // call api

      try {
        const response = await axios.get(process.env.VUE_APP_API_URL + '/invoice/' + this.id + '/stripe')
        console.log(response.data)

        if (!response?.data?.link) {
          throw new Error('Invalid response')
        }

        window.open(response.data.link, '_blank').focus()
        this.state = 'checkout'
      } catch (e) {
        this.state = 'error'
        setTimeout(() => {
          this.state = 'checkout'
        }, 3000)
      }
    },

    async payViaMercadopago () {
      this.state = 'loading'

      // call api

      try {
        const response = await axios.get(process.env.VUE_APP_API_URL + '/invoice/' + this.id + '/mercadopago')

        if (!response?.data?.link) {
          throw new Error('Invalid response')
        }

        window.open(response.data.link, '_blank').focus()
        this.state = 'checkout'
      } catch (e) {
        this.state = 'error'
        setTimeout(() => {
          this.state = 'checkout'
        }, 3000)
      }
    }

  }
}
</script>
