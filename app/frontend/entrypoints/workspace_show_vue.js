import { createApp } from "vue"
import SheetList from '../javascript/components/SheetList.vue'
import WorkspaceUserList from "../javascript/components/WorkspaceUserList.vue";

import axios from 'axios';
const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;

document.addEventListener('turbo:load', () => {
  const sheetList = createApp(SheetList);
  sheetList.mount('#sheet-list')
  const userList = createApp(WorkspaceUserList)
  userList.mount('#user-list')
})
