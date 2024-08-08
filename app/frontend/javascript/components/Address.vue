<template>
  <div :data-address-id="address.id" :data-course-id="address.course_id" class="address">
    {{ address.district }}
    <template v-if="address.address_from">: {{ address.address_from }}</template>
    <template v-if="address.address_to">~{{ address.address_to }}</template>
  </div>
</template>

<script setup>
const props = defineProps({
  address: {
    type: Object,
    required: true,
  },
})
</script>

<style scoped>
* {
  font-weight: 600;
}

.address {
  width: max-content;
  min-width: 150px;
  max-width: 200px;
  overflow: hidden;
  padding: 0 5px;
  background-color: rgb(216, 216, 216);
  border-radius: 5px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 5px;
  height: 1.4em;
}
</style>