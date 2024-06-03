<template>
  <div>
    <WorkspaceList :workspaces="workspaces"></WorkspaceList>
    <CreateWorkspace @workspaceCreated="addWorkspace"/>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import CreateWorkspace from './CreateWorkspace.vue'
import WorkspaceList from './WorkspaceList.vue'
import axios from 'axios'

const workspaces = ref([])

const fetchWorkspaces = async () => {
  const response = await axios.get('/api/workspaces')
  workspaces.value = response.data
}

const addWorkspace = (newWorkspace) => {
  workspaces.value.push(newWorkspace)
  console.log(workspaces.value)
}

fetchWorkspaces()
</script>