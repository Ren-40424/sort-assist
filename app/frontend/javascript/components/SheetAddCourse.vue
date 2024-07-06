<template>
<div class="add-course">
  <div class="button" @click="modal.showModal">
    +
  </div>
</div>
<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">コースを追加する</div>
    <div class="close-btn" @click="closeModal">✕</div>
  </div>

  <div class="modal-main">
    <form @submit.prevent="submit">
      <label for="course-name">コースの名前</label><br>
      <input type="text" class="input" id="course-name" v-model="course.name" required="required"><br>
      <label for="course-explanation">コースの説明</label><br>
      <textarea class="input" id="course-explanation" v-model="course.explanation"></textarea>
      <div class="checkbox">
        <input type="checkbox" id="create-load-sheet" v-model="course.create_load_sheet">
        <label for="create-load-sheet">積込み表を生成する</label> 
      </div>
      <input type="submit" value="作成" :style="{ backgroundColor: buttonColor }" class="submit-btn">
    </form>
  </div>
</dialog>

</template>
  
<script setup>
import { ref, watch } from 'vue'
import axios from 'axios'

//////////// モーダル開閉機能 //////////// 
const modal = ref(null)
const closeModal = () => {
  course.value.name = ''
  course.value.explanation = ''
  course.value.create_load_sheet = false
  modal.value.close()
}

////////// フォーム送信機能 ////////////
const course = ref({
  name: '',
  explanation: '',
  create_load_sheet: false,
  sheet_id: window.sheetId
})

// ボタンの色変更
let buttonColor ='gray'
watch(() => course.value.name, () => {
  if(course.value.name === ''){
    buttonColor = 'gray'
  }else{
    buttonColor ='#28385E'
  }
})

const emit = defineEmits(['courseAdded'])
const submit = () => {
 if (!course.value.name) return
 axios.post('/api/courses',  {
  course: course.value
 }).then(() => {
  emit('courseAdded', course.value.name)
  closeModal()
 }).catch(error => {
  console.log(error)
 })
}

</script>
  
<style scoped>
* {
  user-select: none;
}

.add-course {
  height: 400px;
  width: 50px;
  margin: 0 0 0 100px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.button {
  height: 50px;
  width: 50px;
  font-size: 24px;
  background-color: #28385E;
  color: white;
  font-weight: 600;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

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

#course-name {
  width: 250px;
}

#course-explanation {
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