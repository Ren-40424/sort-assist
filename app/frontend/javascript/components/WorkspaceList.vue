<template>
    <ul>
      <li v-for="workspace in workspaces" :key="workspace.id" class="workspace-list" :class="{ active: activeWorkspace === workspace.id }" @click="toggleActiveWorkspace(workspace.id)">
        <router-link :to="{ name: 'Workspace', params: { id: workspace.id } }" class="workspace-link">
          {{ workspace.name }}
        </router-link>
        <div class="workspace-menu-button" @click="toggleMenu(workspace.id)">
          ・・・
        </div>
        <div v-if="visibleMenu === workspace.id" class="workspace-menu">
          <!-- ここにメニューを記述する -->
        </div>
      </li>
    </ul>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
  workspaces: Array
});

//////////// 表示中のワークスペースを目立たせる ////////////
const activeWorkspace = ref(null)
const toggleActiveWorkspace = (workspaceId) => {
  if (activeWorkspace.value === workspaceId) {
    return;
  } else {
    activeWorkspace.value = workspaceId;
  }
};

//////////// メニューボタンクリックでメニューを表示させる ////////////
const visibleMenu = ref(null);
const toggleMenu = (workspaceId) => {
  if (visibleMenu.value === workspaceId) {
    visibleMenu.value = null;
  } else {
    visibleMenu.value = workspaceId;
  }
};
</script>

<style scoped>
* {
  text-decoration: none;
  color: #ffffff;
}

.active {
  background-color: #555555;
}

.active .workspace-menu-button {
  display: block;
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
}

.workspace-menu-button:hover {
  opacity: 1;
}
</style>