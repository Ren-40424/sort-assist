console.log('Vite ⚡️ Rails')
console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')
import "@hotwired/turbo-rails"
import "@hotwired/stimulus"

import axios from 'axios';
const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;

import { createApp } from 'vue';
import App from "../App.vue";
import router from '../javascript/router/router'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  app.use(router).mount('#app')
})
