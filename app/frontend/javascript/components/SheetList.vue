<template>
<div class="sheet-list">
  <div class="sheet-list-top">
    <strong>表一覧：</strong>
    <SheetCreate @sheetAdded="getSheets" :workspaceId="workspaceId"></SheetCreate>
  </div>
  <div class="sheets">
    <table>
      <thead>
        <tr>
          <th>ワークスペース名</th>
          <th>作成者</th>
          <th>最終更新者</th>
          <th>更新日時</th>
        </tr>
      </thead>
      <tbody>
        <template v-for="(sheet) in sheets">
          <Sheet :sheet="sheet"></Sheet>
        </template>
      </tbody>
    </table>
  </div>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
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

table {
  margin: 0 auto;
  width: 60%;
  border-collapse: collapse;
}

thead {
  border-bottom: 2px solid #505050;
}
</style>