<template>
<tr>
  <td><a :href='userUrl'>{{ user.name }}</a></td>
  <td>{{ userRole.name }}</td>
</tr>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
  workspaceUser: {
    type: Object,
    required: true,
  },
})

const user = props.workspaceUser.user
const userUrl = ref(`/users/${props.workspaceUser.user.id}`)
const userRole = props.workspaceUser.role.attributes
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