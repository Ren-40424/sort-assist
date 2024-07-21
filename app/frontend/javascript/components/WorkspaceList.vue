<template>
  <div class="list-top">ワークスペース一覧</div>
<ul>
  <li v-for="workspace in workspaces" :key="workspace.id" class="workspace-list" :class="{ active: currentWorkspaceId == workspace.id || visibleMenu === workspace.id }">
    <router-link :to="{ name: 'Workspace', params: { id: workspace.id } }" class="workspace-link">
      {{ workspace.name }}
    </router-link>
    <div class="workspace-menu-button" @click="toggleMenu(workspace.id)">
      ・・・
    </div>
    <div v-if="visibleMenu === workspace.id" class="workspace-menu">
      <div class="workspace-edit-button" @click="openModal(workspace)">編集する</div>
      <div class="workspace-delete-button" @click="deleteWorkspace(workspace.id)" :workspaceId="workspace.id">削除する</div>
    </div>
  </li>
</ul>

<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">ワークスペースを編集</div>
    <div class="close-btn" @click="closeModal">✕</div>
  </div>
  <div class="modal-main">
    <form @submit.prevent="submit(selectedWorkspace.id)">
      <label for="workspace-name">ワークスペースの名前</label>
      <input type="text" id="workspace-name" class="input" v-model="selectedWorkspace.name" required="required"><br>
      <label for="workspace-explanation">ワークスペースの説明</label>
      <textarea id="workspace-explanation" v-model="selectedWorkspace.explanation"></textarea><br>
      <input type="submit" value="送信"  class="submit-btn">
    </form>
  </div>
</dialog>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

const props = defineProps({
  workspaces: Array
});

//////////// 表示中のワークスペースを目立たせる ////////////
const route = useRoute()
const currentWorkspaceId = ref(route.params.id)
watch(route, () => {
  if (route.name === 'Workspace') {
    currentWorkspaceId.value = route.params.id
  } else if (route.fullPath === '/') {
    currentWorkspaceId.value = null
  }
})

//////////// メニューボタンクリックでメニューを表示させる ////////////
const visibleMenu = ref(null);
const toggleMenu = (workspaceId) => {
  if (visibleMenu.value === workspaceId) {
    visibleMenu.value = null;
  } else {
    visibleMenu.value = workspaceId;
  }
};

//////////// メニュー以外をクリックするとメニューが閉じる ////////////
const handleClickOutside = (event) => {
  if (!event.target.closest('.workspace-menu') && !event.target.closest('.workspace-menu-button')) {
    visibleMenu.value = null;
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});


//////////// ワークスペースの編集 ////////////
const modal = ref(null)
const selectedWorkspace = ref({ id: null, name: '', explanation: '' })
const openModal = (workspace) => {
  Object.assign(selectedWorkspace.value, workspace)
  modal.value.showModal()
}

const closeModal = () => {
  modal.value.close()
  selectedWorkspace.value = { id: null, name: '', explanation: '' }
}

const emit = defineEmits(['workspaceUpdated']);
const submit = (id) => {
  if (!selectedWorkspace.value.name) return;
  axios.put(`/api/workspaces/${id}`, {
    workspace: selectedWorkspace.value
  }).then(() => {
    emit('workspaceUpdated', id == route.params.id);
    closeModal()
  }).catch(error => {
    console.log(error);
  });
};

//////////// ワークスペースを削除 ////////////
const router = useRouter()
const deleteWorkspace = async (id) => {
  const conf = confirm('ワークスペースを削除しますか？')
  if (conf) {
    await axios.delete(`/api/workspaces/${id}`,{
      params: {
        id: id
      }
    }).then(() => {
      if (route.params.id == id) {
        router.replace('/')
      }
      emit('workspaceUpdated');
    }).catch(error => {
      console.log(error)
    })
  }
}
</script>

<style scoped>
a, .workspace-menu-button, .workspace-edit-button, .list-top {
  color: #ffffff;
}

.active {
  background-color: #555555;
}

.active .workspace-menu-button {
  display: block;
}

.list-top {
  display: flex;
  justify-content: center;
  align-items: center;
  border-bottom: 1px solid #ffffff;
  margin: 0 40px;
  padding-bottom: 2px;
}

.workspace-list {
  height: 30px;
  width: 90%;
  margin-bottom: 5px;
  position: relative;
}

.workspace-list:hover {
  background-color: #555555;
}

.workspace-list:hover .workspace-menu-button {
  display: block;
}

.workspace-link {
  height: 100%;
  width: 100%;
  display: flex;
  align-items: center;
  padding: 0 5px;
  margin-right: 10px;
}

.workspace-menu-button {
  opacity: 0.5;
  letter-spacing: -10px;
  padding-right: 8px;
  display: none;
  position: absolute;
  top: 6px;
  right: 10px;
  cursor: pointer;
  user-select: none;
}

.workspace-menu-button:hover {
  opacity: 1;
}

.workspace-menu {
  height: max-content;
  width: max-content;
  padding: 10px;
  background-color: #555555;
  position: absolute;
  top: -18px;
  right: -100px;
}

.workspace-menu div {
  cursor: pointer;
}

.workspace-edit-button {
  margin-bottom: 10px;
}

.workspace-delete-button {
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