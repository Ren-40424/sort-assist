<template>
<!-- ロードインジケータのコンポーネントを作ろう -->
<div v-if="workspacesStore.isLoading">
  ロード中...
</div>
<div v-else-if="workspace" class="workspace-container">
  <div class="workspace-name">
    {{ workspace.name }}
  </div>
  <div class="workspace-main">
    <SheetList :key="routeKey" :workspaceId="workspaceId"></SheetList>
    <h2>ワークスペースの情報</h2><br>
    <div class="workspace-detail">
      <div v-if="workspace.explanation !== ''" class="workspace-explanation">
        <strong>説明</strong><br><br>
        {{ workspace.explanation }}<br><br>
      </div>
      <WorkspaceUserList :key="routeKey" :workspaceUsers="workspace.users"></WorkspaceUserList>
    </div>
  </div>
</div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import SheetList from '../SheetList.vue'
import WorkspaceUserList from '../WorkspaceUserList.vue'

const route = useRoute()
const router = useRouter()
const routeKey = ref(route.fullPath)
const workspaceId = ref(route.params.id)

import { useWorkspacesStore } from '../../stores/workspaces';
const workspacesStore = useWorkspacesStore()
const workspace = ref(null)

// 表示するワークスペースを変更する処理
const changeWorkspace = (id) => {
  const currentWorkspace = workspacesStore.findWorkspace(workspace => workspace.id == id)
  if (currentWorkspace) {
    workspace.value = currentWorkspace
    workspacesStore.isLoading = false
    // 他人のワークスペースへのアクセスを試みた場合ホームページへリダイレクト
  } else if (!currentWorkspace && !workspacesStore.isLoading) {
    router.push('/')
  }
}

onMounted(() => {
  changeWorkspace(workspaceId.value)
})

watch(() => route.params.id, (newId) => {
  workspaceId.value = newId
  changeWorkspace(workspaceId.value)
})

watch(() => route.fullPath, (newPath, oldPath) => {
  if (newPath !== oldPath) {
    routeKey.value = newPath;
  }
});

workspacesStore.$subscribe((mutation) => {
  if (mutation.type === 'patch object') {
    workspacesStore.isLoading = false
    changeWorkspace(workspaceId.value)
  }
})
</script>

<style scoped>
.workspace-container {
  margin: 0 auto;
  min-width: 430px;
  padding: 20px 20px 60px 20px;
  z-index: 0;
}

@media (min-width: 1080px) {
  .workspace-container {
    min-width: calc(100% - 300px);
  }

  .workspace-explanation {
    width: 60%;
    max-width: 500px;
  }
}

@media (max-width: 1080px) {
  .workspace-container {
    max-width: 100%;
    padding: 20px 0;
  }

  .workspace-explanation {
    width: 80%;
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
  flex-wrap: wrap;
  row-gap: 30px;
  justify-content: space-around;
}

.workspace-explanation {
  text-align: center;
}
</style>