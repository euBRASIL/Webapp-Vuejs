import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: () => import('../views/HomeView.vue')
  },
  {
    path: '/success',
    name: 'success',
    component: () => import('../views/ConfirmationView.vue')
  },
  {
    path: '/cancel',
    name: 'cancel',
    component: () => import('../views/CancelView.vue')
  }
]

const router = new VueRouter({
  routes
})

export default router
