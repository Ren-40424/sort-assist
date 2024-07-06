<template>
<div @click="modal.showModal" id="create-workspace-btn">
  +新規ワークスペースを作成
</div>

<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">ワークスペースを作成</div>
    <div class="close-btn" @click="closeModal">✕</div>
  </div>
  <div class="modal-main">
    <form @submit.prevent="submit">
      <label for="workspace-name">ワークスペースの名前</label>
      <input type="text" id="workspace-name" class="input" v-model="workspace.name" required="required"><br>
      <label for="workspace-explanation">ワークスペースの説明</label>
      <textarea id="workspace-explanation" v-model="workspace.explanation"></textarea><br>
      <input type="submit" value="作成する" :style="{ backgroundColor: buttonColor }" class="submit-btn">
    </form>
  </div>
</dialog>
</template>

<script setup>
import { ref, watch } from 'vue';
import axios from 'axios';

const emit = defineEmits(['workspaceCreated']);

const modal = ref(null)
const closeModal = () => {
  workspace.value.name = '',
  workspace.value.explanation = ''
  modal.value.close()
}

const workspace = ref({
  name: '',
  explanation: ''
});

// ボタンの色変更
let buttonColor ='gray'
watch(() => workspace.value.name, () => {
  if(workspace.value.name === ''){
    buttonColor = 'gray'
  }else{
    buttonColor ='#28385E'
  }
})

const submit = () => {
  if (!workspace.value.name) return;
  axios.post('/api/workspaces', {
    workspace: workspace.value
  }).then(response => {
    emit('workspaceCreated', response.data);
    closeModal()
  }).catch(error => {
    console.log(error);
  });
};
</script>

<style scoped>
#create-workspace-btn {
  width: 15em;
  height: 1.4em;
  cursor: pointer;
  background-color: #cccccc;
  color: black;
  border-radius: 3px;
  display: flex;
  justify-content: center;
  align-items: center;
}

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
  cursor: pointer;
}

.modal-main {
  text-align: left;
  width: 250px;
  margin: 0 auto;
}

#workspace-name {
  height: 30px;
  width: 250px;
  margin-bottom: 15px;
  border-radius: 5px;
  border: none;
}

#workspace-explanation {
  height: 60px;
  width: 250px;
  border-radius: 5px;
  border: none;
  margin-bottom: 20px;
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
