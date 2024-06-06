import { createApp } from "vue"
import WorkspaceManager from '../components/WorkspaceManager.vue';

document.addEventListener('turbo:load', () => {
  Turbo.session.drive = false;
  const app = createApp(WorkspaceManager);
  app.mount('#workspace-manager');
})
