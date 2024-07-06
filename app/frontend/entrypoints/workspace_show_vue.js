import { createApp } from "vue"
import WorkspaceAddUser from '../javascript/components/WorkspaceAddUser.vue';
import SheetCreate from '../javascript/components/SheetCreate.vue'

import axios from 'axios';
const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;

document.addEventListener('turbo:load', () => {
  const addUser = createApp(WorkspaceAddUser);
  addUser.mount('#add-user');
  const createSheet = createApp(SheetCreate);
  createSheet.mount('#create-sheet')
})
