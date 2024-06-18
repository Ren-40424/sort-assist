import { createRouter, createWebHistory } from 'vue-router'
import CreateWorkspace from '../components/CreateWorkspace.vue'

const routes = [
  { path: '/create', component: CreateWorkspace }
]

const router = createRouter({
  history: createWebHistory('/'),
  routes
})

export default router