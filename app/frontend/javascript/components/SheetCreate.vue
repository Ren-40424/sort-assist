<template>

<div @click="modal.showModal" class="create-sheet-btn">表を作成する</div>
<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">表を作成する</div>
    <div class="close-btn" @click="closeModal">✕</div>
  </div>

  <div class="modal-main">
    <label for="sheet-name">表の名前</label><br>
    <input class="input" id="sheet-name" type="text" v-model="sheet.name"><br>
    <label for="sheet-explanation">表の説明</label><br>
    <textarea class="input" id="sheet-explanation" type="textarea" v-model="sheet.explanation"></textarea>
    <div @click="submit" :style="{ backgroundColor: buttonColor }" class="submit-btn">作成</div>
  </div>

</dialog>

</template>



<script setup>
import { ref, watch } from 'vue'
import axios from 'axios'

//////////// モーダル開閉用 ////////////
const modal = ref(null)
const closeModal = () => {
  sheet.value.name = ''
  sheet.value.explanation = ''
  modal.value.close()
}


//////////// シート作成機能 ////////////
const sheet = ref({
  name: '',
  explanation: '',
  workspace_id: window.workspaceId
})

// 入力状況に応じて送信ボタンの色を変える
let buttonColor = 'gray'
watch(() => sheet.value.name, () => {
  if(sheet.value.name === ''){
    buttonColor = 'gray'
  }else{
    buttonColor = '#28385E'
  }
})

const submit = () => {
  if (!sheet.value.name) return
  axios.post('/api/sheets', {
    sheet: sheet.value
  }).then(() =>{
    closeModal()
  }).catch(error => {
    console.log(error)
  })
}


</script>


<style scoped>

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
  text-align: center;
}

</style>