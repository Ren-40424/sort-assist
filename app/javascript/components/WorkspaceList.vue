<template>
  <div>
    <ul>
      <li v-for="workspace in workspaces" :key="workspace.id" class="workspace-list">
        <a :href="`/api/workspaces/${workspace.id}`" data-turbo="false">{{ workspace.name }}</a>
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
a {
  text-decoration: none;
  color: #ffffff;
}
.workspace-list {
  height: 20px;
  margin-bottom: 5px;
}
</style>