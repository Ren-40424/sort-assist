<template>
<div class="user-list">
  <div class="user-list-top">
    <strong>ユーザー一覧：</strong>
    <WorkspaceAddUser @userAdded="getUsers" :workspaceId="workspaceId"></WorkspaceAddUser>
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
          <User :workspaceUser="workspaceUser" :roles="roles"></User>
        </template>
      </tbody>
    </table>
  </div>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios';
import WorkspaceAddUser from './WorkspaceAddUser.vue';
import User from './User.vue';

const props = defineProps({
  workspaceId: String,
})

onMounted(() => {
  getUsers()
})

const workspaceUsers = ref(null)
const roles = ref(null)
const getUsers = async () => {
  const usersResponse = await axios.get('/api/users', {
    params: {
      workspace_id: props.workspaceId
    }
  })
  const rolesResponse = await axios.get('/api/roles')
  workspaceUsers.value = usersResponse.data
  roles.value = rolesResponse.data
}
</script>

<style scoped>
.user-list {
  width: 270px;
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
  max-height: 320px;
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