import { createRouter, createWebHistory } from 'vue-router'
import Home from '../components/pages/Home.vue'
import Workspace from '../components/pages/Workspace.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/workspace/:id', name: 'Workspace', component: Workspace},
]

const router = createRouter({
  history: createWebHistory('/'),
  routes
})

export default router