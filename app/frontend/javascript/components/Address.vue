<template>
  <div :id="`address-${ index + 1 }`">
    {{ address.district }}
    <div v-if="address.address_from">: {{ address.address_from }}</div>
    <div v-if="address.address_to">~{{ address.address_to }}</div>
  </div>
</template>
<script setup>
const props = defineProps({
  address: {
    type: Object,
    required: true,
  },
  index: {
    type: Number,
    required: true,
  },
})
</script>
<style scoped>
* {
  font-weight: 600;
}

[id^='address-']{
  display: flex;
}
</style>