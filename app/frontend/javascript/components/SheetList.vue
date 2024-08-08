<template>
<div class="sheet-list">
  <div class="sheet-list-top">
    <strong>表一覧：</strong>
    <SheetCreate @sheetAdded="getSheets" :workspaceId="workspaceId"></SheetCreate>
  </div>
  <div class="sheets">
    <table>
      <thead>
        <tr v-if="isTightScreen">
          <th>表の名前</th>
          <th>更新日時</th>
        </tr>
        <tr v-else>
          <th>表の名前</th>
          <th>作成者</th>
          <th>最終更新者</th>
          <th>更新日時</th>
        </tr>
      </thead>
      <tbody>
        <template v-for="(sheet) in sheets">
          <Sheet :sheet="sheet" @sheetUpdated="getSheets" :visibleMenu="visibleMenu" @clicked="manageMenu"></Sheet>
        </template>
      </tbody>
    </table>
  </div>
</div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import axios from 'axios';
import Sheet from './Sheet.vue';
import SheetCreate from './SheetCreate.vue';

const props = defineProps({
  workspaceId: String,
})

onMounted(() => {
  getSheets()
})

const sheets = ref(null)
const getSheets = async () => {
  const response = await axios.get('/api/sheets', {
    params: {
      workspace_id: props.workspaceId
    }
  })
  sheets.value = response.data
}

//////////// メニュー管理 ////////////
const visibleMenu = ref(null)
const manageMenu = (sheetId) => {
  if (visibleMenu.value === sheetId) {
    visibleMenu.value = null
  } else {
    visibleMenu.value = sheetId
  }
}

//////////// メニュー以外の場所をクリックするとメニューを閉じる ////////////
const handleClickOutside = (event) => {
  if (!event.target.closest('.sheet-menu') && !event.target.closest('.sheet-menu-button')) {
    visibleMenu.value = null;
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});

//////////// レスポンシブ対応 ////////////
const isTightScreen = ref(window.innerWidth < 1080)
const handleResize = () => {
  isTightScreen.value = window.innerWidth < 1080
}

onMounted(() => {
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
})
</script>

<style scoped>
.sheet-list {
  margin: 20px 0 40px 0;
  min-height: 200px;
  min-width: 100%;
}

.sheet-list-top {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 20px;
}

.sheets {
  margin: 0 auto;
}

table {
  border-collapse: collapse;
}

thead {
  border-bottom: 2px solid #505050;
}

</style>