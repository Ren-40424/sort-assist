<template>

<div class="courses">
  <template v-for="(course) in courses">
    <Course :course="course" :addresses="course.addresses">
      <VueDraggable v-model="course.addresses" group="addresses" :data-course-id="course.id" class="course-addresses" @add="onAdd">
        <template v-for="(address) in course.addresses">
          <Address :address="address" @click="removeAddress(course, address.id)"></Address>
        </template>
      </VueDraggable>
    </Course>
  </template>
  <SheetAddCourse @courseAdded="getCourses"></SheetAddCourse>
</div>

<div class="addresses-box">
  <div class="addresses-box-header">
    <div class="addresses-box-title">住所一覧</div>
    <div class="addresses-box-menu">
      <SheetAddAddress @addressAdded="getAddresses"></SheetAddAddress>
    </div>
  </div>
  <VueDraggable v-model="addresses" group="addresses" class="addresses" @add="onAdd">
    <template v-for="(address) in addresses">
        <Address :address="address"></Address>
    </template>
  </VueDraggable>
</div>

</template>

<script setup>
import { ref, onMounted } from 'vue'
import SheetAddCourse from './SheetAddCourse.vue';
import Course from './Course.vue';
import axios from 'axios'
import SheetAddAddress from './SheetAddAddress.vue';
import Address from './Address.vue'
import { VueDraggable } from 'vue-draggable-plus';

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

  // すでにコースに配置されている住所は住所一覧に表示しない
  response.data = response.data.filter(address => address.course_id === null);
  addresses.value = response.data
}

//////////// ドラッグアンドドロップで住所を各コースに配置する機能 ////////////
const onStart = (event) => {
  console.log('start')
}
const onEnd = () => {

}

// 住所がコースにドラッグアンドドロップされた時にcourse_idを更新
const onAdd = (event) => {
  const addressId = event.item.dataset.addressId;
  let courseId = event.to.dataset.courseId
  // 住所一覧に戻された場合はcourse_idをnullに戻す
  if (typeof courseId === 'undefined') {
    courseId = null
  }
  axios.put(`/api/addresses/${addressId}`, {
    course_id: courseId
  }).then(() => {
    console.log('Update!')
  }).catch(error => {
    console.log(error.response.data)
  })
}

// コースに配置された住所をクリックした時に住所一覧に戻す
const removeAddress = (course, addressId) => {
  axios.put(`/api/addresses/${addressId}`, {
    course_id: null
  }).then(() => {
    const target = course.addresses.findIndex(address => address.id === addressId)
    const item = course.addresses.splice(target, 1)[0]
    addresses.value.push(item)
  }).catch(error => {
    console.log(error.response.data)
  })
}

</script>

<style scoped>
div {
  user-select: none;
}

.courses {
  display: flex;
  gap: 15px;
  width: 100vw;
  margin: 0 auto;
  overflow-x: scroll;
  overflow-y: hidden;
  padding: 0 160px 0 80px;
}

.courses::-webkit-scrollbar {
  height: 8px;
  border-radius: 4px;
  background-color: #ebebeb; 
}

.courses::-webkit-scrollbar-thumb {
  height: 6px;
  border-radius: 3px;
  background-color: #505050;
}

.course-addresses {
  height: 400px;
  width: 250px;
}

.addresses-box {
  background-color: white;
  width: 80%;
  height: 30vh;
  border: 3px solid #555555;
  border-radius: 5px 5px 0 0;
  position: fixed;
  left: 10%;
  bottom: 0
}

.addresses-box-header {
  display: flex;
  height: 2em;
  justify-content: space-between;
  padding: 5px 10px 5px 5px;
  background-color: rgb(216, 216, 216);
}

.course {
  width: 100%;
  height: 100%;
}

.addresses {
  width: 100%;
  height: max-content;
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