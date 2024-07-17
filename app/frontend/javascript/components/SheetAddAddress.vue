<template>
<div class="add-address" @click="modal.showModal">
  +
</div>
<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">住所を追加する</div>
    <div class="close-btn" @click="closeModal">✕</div>
  </div>

  <div class="modal-main">
    <label for="district">大字などの地区名*</label><br>
    <input type="text" class="input" id="district" v-model="address.district"><br>
    <label for="address-from">番地</label><br>
    <input type="text" class="input" id="address-from" v-model="address.address_from" :class="{'input-error': errors.address_from}">から
    <input type="text" class="input" id="address-to" v-model="address.address_to" :class="{'input-error': errors.address_to}">まで<br>
    <div v-if="errors" class="errors">
      <span v-if="errors.address_from">{{ errors.address_from[0] }}<br><br></span>
      <span v-if="errors.address_to">{{ errors.address_to[0] }}<br></span>
    </div>
    <label for="name">名前</label><br>
    <input type="text" class="input" id="name" v-model="address.name"><br>
    <label for="explanation">備考</label><br>
    <textarea class="input" id="explanation" v-model="address.explanation"></textarea>
    <input type="submit" class="submit-btn" value="作成" :style="{ backgroundColor: buttonColor }" @click="submit">
  </div>
</dialog>
</template>

<script setup>
import axios from 'axios';
import { reactive, ref, watch } from 'vue'

const props = defineProps({
  sheetId: String
})

//////////// モーダル開閉機能 //////////// 
const modal = ref(null)
const closeModal = () => {
  modal.value.close()
  resetForm()
}

////////// フォーム送信機能 ////////////
const address = reactive({
  district: '',
  address_from: '',
  address_to: '',
  name: '',
  explanation: '',
  load_place: 0,
  sheet_id: props.sheetId,
  course_id: null
})

const errors = ref({})

////////// フォーム初期化 ////////////
const resetForm = () => {
  address.district = ''
  address.address_from = ''
  address.address_to = ''
  address.name = ''
  address.explanation = ''
  address.load_place = 0
  address.sheet_id = props.sheetId
  address.course_id = null

  errors.value = {}
}

// ボタンの色変更
let buttonColor ='gray'
watch([() => address.district, () => address.address_from], () => {
  if(address.district === ''){
    buttonColor = 'gray'
  }else{
    buttonColor ='#28385E'
  }
})

const emit = defineEmits(['addressAdded'])
const submit = () => {
  if (!address.district) return
  axios.post('/api/addresses', {
    address: address
  }).then(() => {
    emit('addressAdded', address)
    closeModal()
  }).catch(error => {
    if (error.response && error.response.status === 422) {
      errors.value = error.response.data
    }
  })
}
</script>

<style scoped>
.add-address {
  font-size: 30px;
  line-height: 0.55em;
}

dialog[open] {
  width: 400px;
  min-height: 450px;
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

.input {
  width: 250px;
}

input[id^="address-"]{
  width: 90px;
}

#explanation {
  height: 4em;
  width: 250px;
}

.submit-btn {
  display: block;
  margin: 10px auto;
}

.input-error {
  border: 2px solid rgb(220, 70, 70);
}

.errors {
  width: 100%;
  text-align: center;
  color: rgb(220, 70, 70);
}
</style>