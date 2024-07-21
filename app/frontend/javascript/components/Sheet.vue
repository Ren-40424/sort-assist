<template>
<tr v-if="isTightScreen">
  <td><router-link :to="{ name: 'Sheet', params: { id: sheet.id }}">{{ sheet.name }}</router-link></td>
  <td>ここに日時</td>
  <div class="sheet-menu-button">
    ・・・
  </div>
</tr>
<tr v-else>
  <td><router-link :to="{ name: 'Sheet', params: { id: sheet.id }}">{{ sheet.name }}</router-link></td>
  <td>ここに作成者</td>
  <td>ここに更新者</td>
  <td>ここに日時</td>
  <div class="sheet-menu-button">
    ・・・
  </div>
</tr>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const props = defineProps({
  sheet: {
    type: Object,
    required: true,
  },
})

//////////// レスポンシブ対応 ////////////
const isTightScreen = ref(window.innerWidth < 1024)
const handleResize = () => {
  isTightScreen.value = window.innerWidth < 1024
}

onMounted(() => {
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
})
</script>

<style scoped>
tr {
  height: 2.5em;
  border-bottom: 1px solid #555555;
  position: relative;
}

.sheet-menu-button {
  opacity: 0.5;
  letter-spacing: -10px;
  padding-right: 8px;
  display: none;
  position: absolute;
  top: 12px;
  right: 0px;
  cursor: pointer;
  user-select: none;
}

tr:hover .sheet-menu-button {
  display: block;
}

.sheet-menu-button:hover {
  opacity: 1;
}
</style>