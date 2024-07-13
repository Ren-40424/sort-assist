<template>
  <div class="header">
    <div class="user-auth-button" v-if="user">
      <a :href="`/users/${user.id}`">{{ user.name }}</a>
      <div @click="logout" class="logout-button">ログアウト</div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import axios from 'axios';

onMounted(() => {
  getCurrentUser()
})

const user = ref(null)
const isAuthenticated = ref(false)

const getCurrentUser = async () => {
  const response = await axios.get('/api/sessions/show')
  user.value = response.data;
  isAuthenticated.value = true;
}

const logout = async () => {
  await axios.delete('/users/sign_out')
  isAuthenticated.value = false
  window.location.href = '/'
}
</script>

<style scoped>

.header {
  background-color: #444444;
  height: 5vh;
  width: 100%;
  display: flex;
  align-items: center;
  color: #ffffff;
}

.user-auth-button {
  display: flex;
  margin-left: auto;
  gap: 15px;
  padding-right: 20px;
}

.user-auth-button a {
  color: #ffffff;
}

.logout-button {
  cursor: pointer;
}
</style>