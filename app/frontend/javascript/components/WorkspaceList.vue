<template>
  <div>
    <ul>
      <li v-for="workspace in workspaces" :key="workspace.id" class="workspace-list">
        <router-link :to="{ name: 'Workspace', params: { id: workspace.id, }}" class="workspace-link">
          {{ workspace.name }}
        </router-link>
        <div class="workspace-edit-button" :data-workspace-id="workspace.id">
          ...
        </div>
      </li>
    </ul>
  </div>
</template>

<script setup>
const props = defineProps({
  workspaces: Array
})

</script>

<style scoped>
* {
  text-decoration: none;
  color: #ffffff;
}

.workspace-list {
  height: 30px;
  width: 90%;
  margin-bottom: 5px;
  position: relative;
}

.workspace-link {
  height: 100%;
  width: 100%;
  display: flex;
  align-items: center;
  padding: 0 5px;
  margin-right: 10px;
}

.workspace-list:hover {
  background-color: #555555;
}

.workspace-list:hover .workspace-edit-button {
  display: block;
}

.workspace-edit-button {
  opacity: 0.5;
  position: absolute;
  top: -6.5px;
  right: 10px;
  font-size: 24px;
  cursor: pointer;
  display: none;
}

.workspace-edit-button:hover {
  opacity: 1;
}
</style>