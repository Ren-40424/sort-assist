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

const fetchWorkspaces = async () => {
  const response = await axios.get('/api/workspaces')
  workspaces.value = response.data
}

const addWorkspace = (newWorkspace) => {
  workspaces.value.push(newWorkspace)
}

fetchWorkspaces()
</script>