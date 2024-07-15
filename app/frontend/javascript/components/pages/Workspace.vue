<template>
<div v-if="workspace" class="workspace-container">
  <div class="workspace-name">
    {{ workspace.name }}
  </div>
  <div class="workspace-main">
    <SheetList :key="routeKey" :workspaceId="workspaceId"></SheetList>
    <h2>ワークスペースの情報</h2><br>
    <div class="workspace-detail">
      <div class="workspace-explanation">
        <strong>説明：</strong><br>
        {{ workspace.explanation }}<br><br>
      </div>
      <WorkspaceUserList :key="routeKey" :workspaceId="workspaceId"></WorkspaceUserList>
    </div>
  </div>
</div>
<!-- ロードインジケータのコンポーネントを作ろう -->
<div v-else>
  ロード中...
</div>
</template>

<script setup>
import axios from 'axios';
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';
import SheetList from '../SheetList.vue'
import WorkspaceUserList from '../WorkspaceUserList.vue'

const route = useRoute()
const routeKey = ref(route.fullPath)
const workspaceId = ref(route.params.id)
const workspace = ref(null)

const fetchWorkspaceData = async (id) => {
  const response = await axios.get(`/api/workspaces/${id}`)
  return response.data
}

const fetchData = async (id) => {
  workspace.value = await fetchWorkspaceData(id)
}

onMounted(() => {
  fetchData(workspaceId.value)
})

watch(() => route.params.id, (newId) => {
  workspaceId.value = newId
  fetchData(workspaceId.value)
})

watch(
  () => route.fullPath,
  (newPath, oldPath) => {
    if (newPath !== oldPath) {
      routeKey.value = newPath;
    }
  }
);

</script>

<style scoped>
.workspace-container {
  margin: 0 auto;
  min-width: 430px;
  padding: 20px 20px 60px 20px;
  z-index: 0;
}

@media (min-width: 768px) {
  .workspace-container {
    min-width: calc(100% - 300px);
  }
}

@media (max-width: 768px) {
  .workspace-container {
    max-width: 100%;
  }
}

.workspace-name {
  font-size: 35px;
  text-align: center;
  margin-bottom: 40px;
}

.workspace-main {
  display: block;
}

.workspace-detail {
  display: flex;
  max-width: calc(100% - 300px);
  flex-wrap: wrap;
  row-gap: 30px;
  margin: 0 auto;
  justify-content: space-around;
}

.workspace-explanation {
  text-align: center;
  width: 320px;
}
</style>