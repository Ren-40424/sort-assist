import { createApp } from "vue"
import SheetEdit from '../javascript/components/SheetEdit.vue'

import axios from 'axios';
const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;

document.addEventListener('turbo:load', () => {
  const sheetEdit = createApp(SheetEdit);
  sheetEdit.mount('#sheet-edit');
})
