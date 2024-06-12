import { createApp } from "vue"
import WorkspaceManager from '../components/WorkspaceManager.vue';

import axios from 'axios';
const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;

document.addEventListener('turbo:load', () => {
  Turbo.session.drive = false;
  const app = createApp(WorkspaceManager);
  app.mount('#workspace-manager');
})
