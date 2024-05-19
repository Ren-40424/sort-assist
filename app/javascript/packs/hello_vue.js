/* eslint no-console: 0 */

import { createApp } from 'vue'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  app.mount('#app')
})
