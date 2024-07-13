<template>
<tr>
  <td><a :href='userUrl'>{{ userName }}</a></td>
  <td>{{ userRole }}</td>
</tr>
</template>

<script setup>
import { ref } from 'vue';

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
const userUrl = ref(`/users/${props.workspaceUser.user.id}`)
const userRole = props.roles.find(
  role => role.attributes.id === props.workspaceUser.role_id
).attributes.name;
</script>

<style scoped>
tr {
  height: 1.9em;
  border-bottom: 1px solid #555555;
}

a {
  color: black;
}
</style>