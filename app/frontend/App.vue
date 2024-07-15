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
}

@media (min-width: 768px) {
  .router-view {
    max-width: calc(100% - 300px);
    transform: translateX(300px);
  }
}

</style>