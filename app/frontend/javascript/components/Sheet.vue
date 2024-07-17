<template>
<tr>
  <td><router-link :to="{ name: 'Sheet', params: { id: sheet.id }}">{{ sheet.name }}</router-link></td>
  <td>ここに作成者</td>
  <td>ここに更新者</td>
  <td>ここに日時</td>
</tr>
</template>

<script setup>
const props = defineProps({
  sheet: {
    type: Object,
    required: true,
  },
})
</script>

<style scoped>
tr {
  height: 2.5em;
  border-bottom: 1px solid #555555;
}
</style>