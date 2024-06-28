<template>
<div class="courses">
  <div v-for="(course, index) in courses" :key="index">
    <Course :course="course" :index="index"></Course>
  </div>
  <SheetAddCourse @courseAdded="getCourses"></SheetAddCourse>
</div>
<div class="addresses-box">
  <div class="addresses-box-header">
    <div class="addresses-box-title">住所一覧</div>
    <div class="addresses-box-button"></div>
  </div>
  <div class="addresses-box-main">
    <div v-for="(address, index) in addresses" :key="index" class="address">
      <Address :address="address" :index="index"></Address>
    </div>
    <SheetAddAddress @addressAdded="getAddresses"></SheetAddAddress>
  </div>
</div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import SheetAddCourse from './SheetAddCourse.vue';
import Course from './Course.vue';
import axios from 'axios'
import SheetAddAddress from './SheetAddAddress.vue';
import Address from './Address.vue'

const courses = ref([]);
const addresses = ref([]);

onMounted(() => {
  getCourses()
  getAddresses()
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

const getAddresses = async () => {
  const response = await axios.get('/api/addresses', {
    params: {
      sheet_id: window.sheetId
    }
  })
  addresses.value = response.data
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

.addresses-box {
  width: 80%;
  height: 30vh;
  border: 3px solid #555555;
  border-radius: 5px 5px 0 0;
  position: fixed;
  left: 10%;
  bottom: calc(-30vh + 2em);
  transition: bottom 0.3s ease-out;
  background-color: white;
}

.addresses-box:hover {
  bottom: 0px;
}

.addresses-box:hover .addresses-box-button {
  transform: translateY(-25%) rotate(135deg);
}

.addresses-box-header {
  display: flex;
  height: 2em;
  justify-content: space-between;
  padding: 5px 10px 5px 5px;
  background-color: rgb(216, 216, 216);
}

.addresses-box-button {
  display: inline-block;
  vertical-align: middle;
  color: #333;
  line-height: 1;
  width: 1em;
  height: 1em;
  border: 0.1em solid currentColor;
  border-left: 0;
  border-bottom: 0;
  box-sizing: border-box;
  transform: translateY(25%) rotate(-45deg);
}

.addresses-box-main {
  display: flex;
  flex-wrap: wrap;
}

.address {
  width: max-content;
  padding: 0 5px;
  background-color: rgb(216, 216, 216);
  border-radius: 5px;
  display: flex;
  margin: 5px;
  height: 1.2em;
}
</style>