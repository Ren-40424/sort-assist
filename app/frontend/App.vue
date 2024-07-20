<template>
  <Header></Header>
  <Sidebar @sidebarUpdated="updateRouterView"></Sidebar>
  <div class="router-view">
    <router-view :key="updateDate"></router-view>
  </div>
</template>

<script setup>
import Sidebar from './javascript/components/layout/Sidebar.vue';
import Header from './javascript/components/layout/Header.vue';
import { ref } from 'vue';

const updateDate = ref(null)
const updateRouterView = () => {
  updateDate.value = Date.now()
}
</script>

<style scoped>
.router-view {
  transition: transform 0.3s ease;
  height: calc(100% - 5vh);
}

@media (min-width: 768px) {
  .router-view {
    max-width: calc(100% - 300px);
    transform: translateX(300px);
  }
}

</style>