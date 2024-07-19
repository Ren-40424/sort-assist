<template>
    <ul>
      <li v-for="workspace in workspaces" :key="workspace.id" class="workspace-list" :class="{ active: currentWorkspaceId == workspace.id || visibleMenu === workspace.id }">
        <router-link :to="{ name: 'Workspace', params: { id: workspace.id } }" class="workspace-link">
          {{ workspace.name }}
        </router-link>
        <div class="workspace-menu-button" @click="toggleMenu(workspace.id)">
          ・・・
        </div>
        <div v-if="visibleMenu === workspace.id" class="workspace-menu">
          <div class="workspace-edit-button">編集する</div>
          <div class="workspace-delete-button">削除する</div>
        </div>
      </li>
    </ul>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue';
import { useRoute } from 'vue-router';

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
</style>