<template>
  <div @click="createDialog" id="create-workspace-btn">
    +新規ワークスペースを作成
  </div>
  <div v-if="showDialog" class="dialog-box">
    <div class="dialog-title">
      新しいワークスペースを作成する
    </div>
    <div @click="hideDialog" class="cancel-btn">
      ✕
    </div>
    <form class="dialog-form" @submit.prevent="submitForm">
      <div class="name-form">
        <label for="workspace-name">ワークスペースの名前</label>
        <input type="text" id="workspace-name" class="input" v-model="workspace.name" required="required">
      </div>
      <div class="explanation-form">
        <label for="workspace-explanation">ワークスペースの説明</label>
        <textarea id="workspace-explanation" v-model="workspace.explanation"></textarea>
      </div>
        <input type="submit" value="作成する" class="submit-btn">
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';

const emit = defineEmits(['workspaceCreated']);

const showDialog = ref(false);
const workspace = ref({
  name: '',
  explanation: ''
});

const createDialog = () => {
  showDialog.value = true;
};

const hideDialog = () => {
  showDialog.value = false;
};

const submitForm = () => {
  if (!workspace.value.name) return;
  axios.post('/api/workspaces', {
    workspace: workspace.value
  }).then(response => {
    emit('workspaceCreated', response.data);
    showDialog.value = false;
    workspace.value.name = '';
    workspace.value.explanation = '';
  }).catch(error => {
    console.log(error);
  });
};
</script>

<style scoped>
#create-workspace-btn {
  margin: 0 auto;
  width: 14em;
  height: 1.4em;
  text-align: center;
  cursor: pointer;
  background-color: #cccccc;
  border-radius: 3px;
}

.dialog-box {
  width: 470px;
  height: 300px;
  background-color: #dddddd;
  position: absolute;
  top: 0; right: 0; bottom: 0; left: 0; margin: auto;
  
}

.dialog-title {
  text-align: center;
  font-size: 20px;
  margin: 20px 0 20px 0;
}

.cancel-btn {
  position: absolute;
  top: 0; right: 0; bottom: 300px; left: 455px;
  cursor: pointer;
}

.dialog-form, .name-form, .explanation-form{
  display: flex;
  flex-direction: column;
  margin: auto;
  width: 80%;
}

#workspace-name {
  height: 30px;
  margin-bottom: 15px;
  border-radius: 5px;
  border: none;
}

#workspace-explanation {
  height: 60px;
  border-radius: 5px;
  border: none;
  margin-bottom: 20px;
}
</style>
