import { createApp } from "vue"
import WorkspaceManager from '../components/WorkspaceManager.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(WorkspaceManager);
  app.mount('#workspace-manager');
})
