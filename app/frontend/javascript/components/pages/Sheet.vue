<template>
<div class="sheet-wrapper">
  <div v-if="sheet" class="sheet-name">{{ sheet.name }}</div>
  <div class="courses">
    <template v-for="(course) in courses">
      <Course :course="course" :addresses="course.addresses" :visibleMenu="visibleMenu" @clicked="manageMenu" @courseUpdated="fetchData">
        <VueDraggable v-model="course.addresses" group="addresses" :data-course-id="course.id" class="course-addresses" @add="onAdd">
          <template v-for="(address) in course.addresses">
            <Address :address="address" @click="removeAddress(course, address.id)"></Address>
          </template>
        </VueDraggable>
      </Course>
    </template>
    <SheetAddCourse @courseAdded="getCourses" :sheetId="sheetId"></SheetAddCourse>
  </div>

  <div class="addresses-box">
    <div class="addresses-box-header">
      <div class="addresses-box-title">住所一覧</div>
      <VueDraggable v-model="addresses" group="addresses" @add="deleteAddress" class="delete-address" ghostClass="hidden">削除</VueDraggable>
      <div class="addresses-box-menu">
        <SheetAddAddress @addressAdded="getAddresses" :sheetId="sheetId"></SheetAddAddress>
      </div>
    </div>
    <VueDraggable v-model="addresses" group="addresses" class="addresses" @add="onAdd">
      <template v-for="(address) in addresses">
        <Address :address="address"></Address>
      </template>
    </VueDraggable>
  </div>
</div>

</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import SheetAddCourse from '../SheetAddCourse.vue';
import Course from '../Course.vue';
import axios from 'axios'
import SheetAddAddress from '../SheetAddAddress.vue';
import Address from '../Address.vue'
import { VueDraggable } from 'vue-draggable-plus';
import { useRoute } from 'vue-router';

const sheet = ref(null);
const courses = ref([]);
const addresses = ref([]);
const routes = useRoute();
const sheetId = ref(routes.params.id);

onMounted(() => {
  getSheet()
  fetchData()
})

const fetchData = () => {
  getCourses()
  getAddresses()
}

const getSheet = async () => {
  const response = await axios.get(`/api/sheets/${sheetId.value}`)
  sheet.value = response.data
}

// カレントページのsheet_idを受け取り、該当するsheet_idのコースを取得
const getCourses = async () => {
  const response = await axios.get('/api/courses', {
    params: {
      sheet_id: sheetId.value
    }
  })
  courses.value = response.data
}

const getAddresses = async () => {
  const response = await axios.get('/api/addresses', {
    params: {
      sheet_id: sheetId.value
    }
  })

  // すでにコースに配置されている住所は住所一覧に表示しない
  response.data = response.data.filter(address => address.course_id === null);
  addresses.value = response.data
}

//////////// ドラッグアンドドロップで住所を各コースに配置する機能 ////////////

// 追加予定：ドラッグ中のみ要素の色を変える //

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

//////////// 住所削除機能 ////////////
const deleteAddress = async (event) => {
  const id = event.item.dataset.addressId
  const response = await axios.delete(`/api/addresses/${id}`)
  if (response.status === 200) {
    getAddresses()
  } else {
    console.log(response)
  }
}

//////////// メニュー管理 ////////////
const visibleMenu = ref(null)
const manageMenu = (courseId) => {
  if (visibleMenu.value === courseId) {
    visibleMenu.value = null
  } else {
    visibleMenu.value = courseId
  }
}

//////////// メニュー以外の場所をクリックするとメニューを閉じる ////////////
const handleClickOutside = (event) => {
  if (!event.target.closest('.course-menu') && !event.target.closest('.course-menu-button')) {
    visibleMenu.value = null;
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});

</script>

<style scoped>
div {
  user-select: none;
}

.sheet-name {
  font-size: 36px;
  text-align: center;
  padding: 10px 0;
}

.sheet-wrapper {
  height: 100%;
  width: 100%;
}

.courses {
  display: flex;
  gap: 20px;
  margin: auto;
  overflow-x: scroll;
  overflow-y: hidden;
  padding: 10px 160px 10px 80px;
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
  height: 375px;
  width: 250px;
  padding: 5px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.addresses-box {
  background-color: white;
  width: 80%;
  height: 30vh;
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.75);
  position: fixed;
  left: 10%;
  bottom: 0
}

.addresses-box-header {
  display: flex;
  height: 2em;
  justify-content: space-between;
  padding: 5px 10px 5px 5px;
  background-color: rgb(220, 220, 220);
  position: relative;
}

.delete-address {
  position: absolute;
  right: 3rem;
  height: 1rem;
  width: 2rem;
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

.delete-address {
  background-color: rgb(255, 120, 120);
  color: white;
  height: max-content;
  width: max-content;
  padding: 2px 4px;
}

.hidden {
  display: none;
}
</style>