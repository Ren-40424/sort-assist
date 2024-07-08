<template>
<tr>
  <td>{{ userName }}</td>
  <td>{{ userRole }}</td>
</tr>
</template>

<script setup>
const props = defineProps({
  workspaceUser: {
    type: Object,
    required: true,
  },
  roles: {
    type: Object,
    required: true,
  },
})

const userName = props.workspaceUser.user.name
const userRole = props.roles.find(
  role => role.attributes.id === props.workspaceUser.role_id
).attributes.name;
</script>

<style scoped>
tr {
  height: 1.9em;
  border-bottom: 1px solid #555555;
}
</style>