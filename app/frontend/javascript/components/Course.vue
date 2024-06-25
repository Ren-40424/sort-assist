<template>
<div :id="`course-${ index + 1 }`">
  <div class="course-head">
    <div class="course-name">{{ course.name }}</div>
  </div>
  <div class="course-main">

  </div>
</div>
</template>

<script setup>
const props = defineProps({
  course: {
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
[id^='course-'] {
  height: 400px;
  width: 250px;
  border: 3px solid rgb(70, 70, 70);
  border-radius: 5px;
}

.course-head {
  border-bottom: 3px solid rgb(70, 70, 70);
  background-color: rgb(216, 216, 216);
  height: 25px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.course-name {
  font-weight: 600;
}
</style>