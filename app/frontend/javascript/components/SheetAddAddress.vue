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
    <label for="address-from">番地*</label><br>
    <input type="text" class="input" id="address-from" v-model="address.address_from">から
    <input type="text" class="input" id="address-to" v-model="address.address_to">まで<br>
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

//////////// モーダル開閉機能 //////////// 
const modal = ref(null)
const closeModal = () => {
  modal.value.close()
}

////////// フォーム送信機能 ////////////
const address = reactive({
  district: '',
  address_from: '',
  address_to: '',
  name: '',
  explanation: '',
  load_place: 0,
  sheet_id: window.sheetId,
  course_id: null
})

// ボタンの色変更
let buttonColor ='gray'
watch([() => address.district, () => address.address_from], () => {
  if(address.district === '' || address.address_from === ''){
    buttonColor = 'gray'
  }else{
    buttonColor ='#28385E'
  }
})

const submit = () => {
  if (!address.district || !address.address_from) return
  axios.post('/api/addresses', {
    address: address
  }).then(() => {
    closeModal()
  }).catch(error => {
    console.log(error.response.data)
  })
}
</script>

<style scoped>
dialog[open] {
  width: 400px;
  height: 450px;
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
</style>