import { createApp } from "vue"
import WorkspaceAddUser from '../components/WorkspaceAddUser.vue';

document.addEventListener('turbo:load', () => {
  Turbo.session.drive = false;
  const app = createApp(WorkspaceAddUser);
  app.mount('#add-user-btn');
})
