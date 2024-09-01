<template>
<div class="user-list">
  <div class="user-list-top">
    <strong>ユーザー一覧：</strong>
    <WorkspaceAddUser :workspaceId="workspaceId"></WorkspaceAddUser>
  </div>

  <table>
    <thead>
      <tr>
        <th>ユーザー名</th>
        <th>権限</th>
      </tr>
    </thead>
  </table>

  <div class="table-body">
    <table>
      <tbody>
        <template v-for="(workspaceUser) in workspaceUsers">
          <User :workspaceUser="workspaceUser"></User>
        </template>
      </tbody>
    </table>
  </div>
</div>
</template>

<script setup>
import { ref } from 'vue'
import WorkspaceAddUser from './WorkspaceAddUser.vue';
import User from './User.vue';
import { useWorkspacesStore } from '../stores/workspaces';
import { useRoute } from 'vue-router';

const route = useRoute()
const workspaceId = ref(route.params.id)

const workspacesStore = useWorkspacesStore()
const currentWorkspace = workspacesStore.findWorkspace(workspace => workspace.id == workspaceId.value)
const workspaceUsers = currentWorkspace.users
</script>

<style scoped>
.user-list {
  width: 400px;
}

.user-list-top {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 20px;
}

table {
  margin: 0 auto;
  width: 100%;
  border-collapse: collapse;
}

th {
  border-bottom: 2px solid #505050
}

.table-body {
  max-height: 250px;
  overflow-y: auto;
  overflow-x: hidden;
}

.table-body::-webkit-scrollbar {
  margin-left: 5px;
  width: 8px;
  border-radius: 4px;
  background-color: #ebebeb; 
}

.table-body::-webkit-scrollbar-thumb {
  width: 6px;
  border-radius: 3px;
  background-color: #505050;
}

.table-body::-webkit-scrollbar-track {
  margin: 0 2px;
}
</style>