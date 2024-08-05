<template>
<div :id="`course-${ course.id }`">
  <div class="course-header">
    <div class="course-icon" :class="{ active: course.create_load_sheet }" @click="toggleCreate">
      ◆
    </div>
    <div class="course-name">{{ course.name }}</div>
    <div class="course-menu-button" @click="menuClicked(course.id)">・・・</div>
    <div v-if="visibleMenu === course.id" class="course-menu">
      <div class="course-edit-button" @click="openModal(course)">編集する</div>
      <div class="course-delete-button" @click="deleteCourse(course.id)">削除する</div>
    </div>
  </div>
  <div class="course-main">
    <slot></slot>
  </div>
</div>

<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">コースを編集</div>
    <div class="close-btn" @click="closeModal">✕</div>
  </div>

  <div class="modal-main">
    <form @submit.prevent="submit(selectedCourse.id)">
      <label for="course-name">コースの名前</label><br>
      <input type="text" class="input" id="input-course-name" v-model="selectedCourse.name" required="required"><br>
      <label for="input-course-explanation">コースの説明</label><br>
      <textarea class="input" id="input-course-explanation" v-model="selectedCourse.explanation"></textarea>
      <div class="checkbox">
        <input type="checkbox" id="input-create-load-sheet" v-model="selectedCourse.create_load_sheet">
        <label for="input-create-load-sheet">積込み表を生成する</label> 
      </div>
      <input type="submit" value="作成" class="submit-btn">
    </form>
  </div>
</dialog>
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
  visibleMenu: {
    type: Number,
  },
})

const emit = defineEmits(['clicked', 'courseUpdated']);

//////////// 積込み表を作成するかの切り替え機能 ////////////
const createLoadSheet = ref(props.course.create_load_sheet)
const toggleCreate = () => {
  createLoadSheet.value = !createLoadSheet.value
  updateCreateLoadSheet(createLoadSheet.value)
}

const updateCreateLoadSheet = async (new_value) => {
  await axios.patch(`/api/courses/${props.course.id}/update_create_load_sheet`, {
    create_load_sheet: new_value
  }).then(() => {
    emit('courseUpdated')
  }).catch((error) => {
    console.log(error)
  })
}

//////////// メニュー表示機能 ////////////
const menuClicked = (courseId) => {
  emit('clicked', courseId);
}

//////////// コース編集機能 ////////////
const modal = ref(null)
const selectedCourse = ref({ id: null, name: '', explanation: '', create_load_sheet: null })
const openModal = (course) => {
  Object.assign(selectedCourse.value, course)
  modal.value.showModal()
}

const closeModal = () => {
  modal.value.close()
  selectedCourse.value = { id: null, name: '', explanation: '', create_load_sheet: null }
}

const submit = (id) => {
  if (!selectedCourse.value.name) return;
  axios.put(`/api/courses/${id}`, {
    course: {
      name: selectedCourse.value.name,
      explanation: selectedCourse.value.explanation,
      create_load_sheet: selectedCourse.value.create_load_sheet,
    }
  }).then(() => {
    emit('courseUpdated');
    closeModal()
  }).catch(error => {
    console.log(error);
  });
};

//////////// コース削除機能 ////////////
const deleteCourse = (courseId) => {
  const conf = confirm('コースを削除しますか？')
  if (!conf) return;
  axios.delete(`/api/courses/${courseId}`,{
    params: {
      id: courseId
    }
  }).then(() => {
    emit('courseUpdated')
  }).catch(error => {
    console.log(error)
  })
}

</script>

<style scoped>
[id^='course-'] {
  height: 400px;
  width: 250px;
  background-color: white;
  box-shadow: 0px 0px 5px 1px rgba(0, 0, 0, 0.75);
}

.course-header {
  background-color: rgb(220, 220, 220);
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
  left: 8px;
  bottom: 3.5px;
  color: rgb(255, 255, 255);
  text-shadow: 0px 0px 3px rgb(100, 100, 100);
}

.active {
  color: #28385E;
  text-shadow: none;
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

.course-menu {
  height: max-content;
  width: max-content;
  padding: 10px;
  background-color: #6f6f6f;
  position: absolute;
  top: -10px;
  right: 40px;
  color: #ffffff;
  z-index: 999;
}

.course-menu div {
  cursor: pointer;
}

.course-edit-button {
  margin-bottom: 10px;
}

.course-delete-button {
  color: red;
}

/* モーダル */
dialog[open] {
  width: 450px;
  height: 320px;
  background-color: #dddddd;
  box-shadow: 0px 0px 10px 1px rgba(0, 0, 0, 0.30);
  border: none;
  outline: none;
  user-select: none;
}

.modal-top {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}

.close-btn {
  text-align: end;
  cursor: pointer;
}

.modal-main {
  text-align: left;
  width: 250px;
  margin: 0 auto;
}

#input-course-name {
  width: 250px;
}

#input-course-explanation {
  width: 250px;
  height: 4em;
}

.checkbox {
  display: block;
  text-align: center;
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>