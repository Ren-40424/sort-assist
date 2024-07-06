<template>
<div :id="`course-${ course.id }`">
  <div class="course-header">
    <div class="course-name">{{ course.name }}</div>
    <div v-if="course.create_load_sheet" class="course-icon"><span style="font-size: 12px;">◆</span></div>
  </div>
  <div class="course-main">
    <slot></slot>
  </div>
</div>
</template>

<script setup>
const props = defineProps({
  course: {
    type: Object,
    required: true,
  },
  addresses: {
    type: Array,
  },
})
</script>

<style scoped>
[id^='course-'] {
  height: 400px;
  width: 250px;
  border: 3px solid rgb(70, 70, 70);
  border-radius: 5px;
}

.course-header {
  border-bottom: 3px solid rgb(70, 70, 70);
  background-color: rgb(216, 216, 216);
  height: 25px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

.course-icon {
  position: absolute;
  right: 5px;
  bottom: 3.5px;
  color: #28385E;
}

.course-main {
  height: calc(400px - 25px);
  width: 250px;
}

.course-name {
  font-weight: 600;
}
</style>