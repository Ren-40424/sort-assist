<template>
<tr v-if="isTightScreen">
  <td><router-link :to="{ name: 'Sheet', params: { id: sheet.id }}">{{ sheet.name }}</router-link></td>
  <td>ここに日時</td>

  <div class="sheet-menu-button" @click="menuClicked(sheet.id)">
    ・・・
  </div>

  <div v-if="visibleMenu == sheet.id" class="sheet-menu">
    <div class="sheet-edit-button" @click="openModal(sheet)">編集する</div>
    <div class="sheet-delete-button" @click="deleteSheet(sheet.id)" :sheetId="sheet.id">削除する</div>
  </div>
</tr>

<tr v-else>
  <td><router-link :to="{ name: 'Sheet', params: { id: sheet.id }}">{{ sheet.name }}</router-link></td>
  <td>ここに作成者</td>
  <td>ここに更新者</td>
  <td>ここに日時</td>

  <div class="sheet-menu-button" @click="menuClicked(sheet.id)">
    ・・・
  </div>

  <div v-if="visibleMenu == sheet.id" class="sheet-menu">
    <div class="sheet-edit-button" @click="openModal(sheet)">編集する</div>
    <div class="sheet-delete-button" @click="deleteSheet(sheet.id)" :sheetId="sheet.id">削除する</div>
  </div>
</tr>

<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">表を編集</div>
    <div class="close-btn" @click="closeModal">✕</div>
  </div>

  <div class="modal-main">
    <form @submit.prevent="submit(selectedSheet.id)">
      <label for="sheet-name">表の名前</label><br>
      <input class="input" id="sheet-name" type="text" v-model="selectedSheet.name" required="required"><br>
      <label for="sheet-explanation">表の説明</label><br>
      <textarea class="input" id="sheet-explanation" v-model="selectedSheet.explanation"></textarea>
      <input type="submit" value="作成" class="submit-btn">
    </form>
  </div>
</dialog>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import axios from 'axios';

const props = defineProps({
  sheet: {
    type: Object,
    required: true,
  },
  visibleMenu: {
    type: Number,
  },
})

const emit = defineEmits(['clicked', 'sheetUpdated'])

//////////// メニューボタンクリックでメニューを表示させる ////////////
const menuClicked = (sheetId) => {
  emit('clicked', sheetId);
}

//////////// シート編集機能////////////
const modal = ref(null)
const selectedSheet = ref({ id: null, name: '', explanation: '' })
const openModal = (sheet) => {
  Object.assign(selectedSheet.value, sheet)
  modal.value.showModal()
}

const closeModal = () => {
  modal.value.close()
  selectedSheet.value = { id: null, name: '', explanation: '' }
}

const submit = (id) => {
  if (!selectedSheet.value.name) return;
  axios.put(`/api/sheets/${id}`, {
    sheet: {
      name: selectedSheet.value.name,
      explanation: selectedSheet.value.explanation,
    }
  }).then(() => {
    emit('sheetUpdated');
    closeModal()
  }).catch(error => {
    console.log(error);
  });
};

//////////// シート削除機能 ////////////
const deleteSheet = async (id) => {
  const conf = confirm('表を削除しますか？')
  if (!conf) return;
  await axios.delete(`/api/sheets/${id}`,{
    params: {
      id: id
    }
  }).then(() => {
    emit('sheetUpdated');
  }).catch(error => {
    console.log(error)
  })
}

//////////// レスポンシブ対応 ////////////
const isTightScreen = ref(window.innerWidth < 1080)
const handleResize = () => {
  isTightScreen.value = window.innerWidth < 1080
}

onMounted(() => {
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
})
</script>

<style scoped>
tr {
  height: 2.5em;
  border-bottom: 1px solid #555555;
  position: relative;
}

.sheet-menu-button {
  opacity: 0.5;
  letter-spacing: -10px;
  padding-right: 8px;
  display: none;
  position: absolute;
  top: 12px;
  right: 0px;
  cursor: pointer;
  user-select: none;
}

tr:hover .sheet-menu-button {
  display: block;
}

.sheet-menu-button:hover {
  opacity: 1;
}

.sheet-menu {
  height: max-content;
  width: max-content;
  padding: 10px;
  background-color: #6f6f6f;
  position: absolute;
  top: -10px;
  right: 40px;
  color: #ffffff;
  z-index: 999;
}

.sheet-menu div {
  cursor: pointer;
}

.sheet-edit-button {
  margin-bottom: 10px;
}

.sheet-delete-button {
  color: red;
}

/* モーダル */
dialog[open] {
  width: 450px;
  height: 320px;
  background-color: #dddddd;
  box-shadow: 0px 0px 10px 1px rgba(0, 0, 0, 0.30);
  border: none;
  outline: none;
  user-select: none;
}

.modal-top {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}

.close-btn {
  text-align: end;
  cursor: pointer;
}

.modal-main {
  text-align: left;
  width: 250px;
  margin: 0 auto;
}

#sheet-name {
  width: 250px;
}

#sheet-explanation {
  width: 250px;
  height: 4em;
}

.submit-btn {
  display: flex;
  justify-content: center;
}
</style>