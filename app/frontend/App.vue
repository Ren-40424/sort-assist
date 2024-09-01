<template>
  <Header></Header>
  <Sidebar></Sidebar>
  <div class="router-view">
    <router-view></router-view>
  </div>
</template>

<script setup>
import Sidebar from './javascript/components/layout/Sidebar.vue';
import Header from './javascript/components/layout/Header.vue';

</script>

<style scoped>
.router-view {
  transition: transform 0.3s ease;
  height: calc(100% - 5vh);
  overflow-x: hidden;
}

@media (min-width: 1080px) {
  .router-view {
    max-width: calc(100% - 300px);
    transform: translateX(300px);
  }
}

</style>