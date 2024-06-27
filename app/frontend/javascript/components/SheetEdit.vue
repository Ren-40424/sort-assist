<template>
<div class="courses">
  <div v-for="(course, index) in courses" :key="index">
    <Course :course="course" :index="index"></Course>
  </div>
  <SheetAddCourse @courseAdded="getCourses"></SheetAddCourse>
</div>
<div class="addresses">
  住所一覧
  
  <SheetAddAddress></SheetAddAddress>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import SheetAddCourse from './SheetAddCourse.vue';
import Course from './Course.vue';
import axios from 'axios'
import SheetAddAddress from './SheetAddAddress.vue';

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

<style scoped>
div {
  user-select: none;
}

.courses {
  display: flex;
  gap: 15px;
  flex-wrap: wrap;
  justify-content: center;
}

.addresses {
  width: 80%;
  height: 30vh;
  background-color: #BBBBBB;
  border: 3px solid #555555;
  border-radius: 5px 5px 0 0;
  position: fixed;
  left: 10%;
  bottom: 0;
}
</style>