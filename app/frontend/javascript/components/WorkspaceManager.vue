<template>
  <div>
    <WorkspaceList/>
    <CreateWorkspace @workspaceCreated="addWorkspace"/>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import CreateWorkspace from './WorkspaceCreate.vue'
import WorkspaceList from './WorkspaceList.vue'
import axios from 'axios'

// フェッチしたワークスペースをPiniaで管理
import { useWorkspacesStore } from '../stores/workspaces'
const workspacesStore = useWorkspacesStore()

// Piniaを初期化
const fetchWorkspaces = async () => {
  workspacesStore.isLoading = true
  await axios.get('/api/workspaces').then((response) => {
    workspacesStore.$patch({
      workspaces: response.data
    })
  }).then(() => {
    workspacesStore.isLoading = false
  }).catch((error) => {
    console.log(error.response.data)
  })
}

// Piniaのストアに作成したワークスペースを追加
const addWorkspace = (newWorkspace) => {
  workspacesStore.add({
    id: newWorkspace.id,
    name: newWorkspace.name,
    explanation: newWorkspace.explanation,
    users: []
  })
}

onMounted(() => {
  fetchWorkspaces()
})
</script>