import { createRouter, createWebHistory } from 'vue-router'
import Home from '../components/pages/Home.vue'
import Workspace from '../components/pages/Workspace.vue'
import Sheet from '../components/pages/Sheet.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/workspace/:id', name: 'Workspace', component: Workspace},
  { path: '/sheet/:id', name: 'Sheet', component: Sheet },
]

const router = createRouter({
  history: createWebHistory('/'),
  routes
})

export default router