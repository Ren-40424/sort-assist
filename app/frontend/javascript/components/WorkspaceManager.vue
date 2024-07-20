<template>
  <div>
    <WorkspaceList :workspaces="workspaces" @workspaceEdited="fetchWorkspaces"></WorkspaceList>
    <CreateWorkspace @workspaceCreated="addWorkspace"/>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import CreateWorkspace from './WorkspaceCreate.vue'
import WorkspaceList from './WorkspaceList.vue'
import axios from 'axios'

const workspaces = ref([])
const emit = defineEmits(['sidebarUpdated'])
const fetchWorkspaces = async (isCurrentPage) => {
  const response = await axios.get('/api/workspaces')
  workspaces.value = response.data
  // 現在開いているワークスペースの内容を編集した際に再レンダリングするための処理
  if (isCurrentPage) {
    emit('sidebarUpdated')
  }
}

const addWorkspace = (newWorkspace) => {
  workspaces.value.push(newWorkspace)
}

fetchWorkspaces()
</script>