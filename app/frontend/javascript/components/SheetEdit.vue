<template>
<div class="courses">
  <div v-for="(course, index) in courses" :key="index">
    <Course :course="course" :index="index"></Course>
  </div>
  <SheetAddCourse @courseAdded="getCourses"></SheetAddCourse>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import SheetAddCourse from './SheetAddCourse.vue';
import Course from './Course.vue';
import axios from 'axios'

const courses = ref([]);

onMounted(() => {
  getCourses()
})

// ビューからカレントページのsheet_idを受け取り、該当するsheet_idのコースを取得
const getCourses = async () => {
  const response = await axios.get('/api/courses', {
    params: {
      sheet_id: window.sheetId
    }
  })
  courses.value = response.data
}

</script>

<style>
.courses {
  display: flex;
  gap: 15px;
  flex-wrap: wrap;
}
</style>