<template>
<div :id="`course-${ course.id }`">
  <div class="course-header">
    <div class="course-icon" @click="toggleCreate">
      <template v-if="createLoadSheet" class="course-icon">◆</template>
      <template v-else class="course-icon">◇</template>
    </div>
    <div class="course-name">{{ course.name }}</div>
    <div class="course-menu-button">・・・</div>
  </div>
  <div class="course-main">
    <slot></slot>
  </div>
</div>
</template>

<script setup>
import axios from 'axios';
import { ref } from 'vue';

const props = defineProps({
  course: {
    type: Object,
    required: true,
  },
  addresses: {
    type: Array,
  },
})

//////////// 積込み表を作成するかの切り替え機能 ////////////
const createLoadSheet = ref(props.course.create_load_sheet)
const toggleCreate = () => {
  createLoadSheet.value = !createLoadSheet.value
  updateCreateLoadSheet(createLoadSheet.value)
}

const updateCreateLoadSheet = async (new_value) => {
  await axios.patch(`/api/courses/${props.course.id}/update_create_load_sheet`, {
    create_load_sheet: new_value
  })
}

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
  font-size: 14px;
  font-weight: bolder;
  position: absolute;
  left: 5px;
  bottom: 3.5px;
  color: #28385E;
}

.course-menu-button {
  opacity: 0.5;
  letter-spacing: -10px;
  padding-right: 8px;
  display: none;
  position: absolute;
  top: 2.5px;
  right: 5px;
  cursor: pointer;
  user-select: none;
}

[id^='course']:hover .course-menu-button {
  display: block;
}

.course-menu-button:hover {
  opacity: 1;
}

.course-main {
  height: calc(400px - 25px);
  width: 250px;
}

.course-name {
  font-weight: 600;
}
</style>