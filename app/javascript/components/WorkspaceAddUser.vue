<template>
<div @click="modal.showModal" class="add-user-btn">ユーザーを追加する</div>
<dialog ref="modal">
  <div class="modal-top">
    <div class="modal-title">追加するユーザーを選択してください：</div>
    <div class="close-btn" @click="modal.close">✕</div>
  </div>
  <div class="modal-main">
    <input :name type="text" placeholder="検索">
    <div class="search-result">
      <ul>
        <li v-for="user in users"></li>
      </ul>
    </div>
  </div>
</dialog>
</template>



<script setup>
import { onMounted, ref } from 'vue';
const modal = ref(null)
onMounted(() => {
  console.log(modal)
})
</script>



<style scoped>
dialog[open] {
  width: 500px;
  height: 600px;
  background-color: #dddddd;
  box-shadow: 0px 0px 10px 1px rgba(0, 0, 0, 0.30);
  border: none;
  outline: none;
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

.search-result {
  background-color: #eeeeee;
  width: 80%;
  height: 400px;
  margin: auto;
}

</style>