<template>
<div :class="{ open: isOpen }" class="side-bar">
  <button class="hamburger" @click="toggleSidebar">☰</button>
  <Transition>
    <div v-show="isOpen || !isMobile">
      <div class="side-bar__top">
        <div class="logo"> <!-- ルートへのパスを指定する 当日の仕分け表がメインに表示されている画面 -->
          Sort-Assist
        </div>
      </div>
      <div class="side-bar__main">
        <WorkspaceManager></WorkspaceManager>
      </div>
    </div>
  </Transition>
</div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import WorkspaceManager from '../WorkspaceManager.vue'

const isOpen = ref(false)
const isMobile = ref(false)

const toggleSidebar = () => {
  isOpen.value = !isOpen.value
}

const handleResize = () => {
  isMobile.value = window.innerWidth <= 768;
};

onMounted(() => {
  window.addEventListener('resize', handleResize);
  handleResize();
});

onUnmounted(() => {
  window.removeEventListener('resize', handleResize);
});

</script>

<style scoped>
.side-bar {
  height: 100%;
  width: 300px;
  position: fixed;
  top: 0;
  left: 0;
  width: 250px;
  height: 100%;
  transition: transform 0.3s ease;
}

.side-bar .hamburger {
  display: none;
  background: none;
  border: none;
  color: #fff;
  font-size: 24px;
  position: absolute;
  top: 8px;
  right: -90px;
  cursor: pointer;
}

.side-bar__top {
  background-color: #333333;
  height: 5vh;
  width: 300px;
  display: flex;
  align-items: center;
}

.logo {
  width: 100%;
  color: #ffffff;
  font-size: 20px;
  text-align: center;
}

.side-bar__main {
  background-color: #333333;
  width: 300px;
  height: calc(100vh - 5vh);
  padding: 20px 0;
}

@media (max-width: 768px) {
  .side-bar {
    transform: translateX(-300px);
  }

  .side-bar.open {
    transform: translateX(0);
  }

  .side-bar .hamburger {
    display: block;
  }
}

.v-enter-active,
.v-leave-active {
  transition: all 0.3s ease;
}

.v-enter-from,
.v-leave-to {
  transition: all 0.3s ease;
}
</style>