<template>

<div @click="modal.showModal" class="create-sheet-btn">表を作成する</div>
<dialog ref="modal">
  <div class="modal-top">
      <div class="modal-title">表を作成する</div>
      
      <div class="close-btn" @click="closeModal">✕</div>
    </div>

</dialog>

</template>



<script setup>
import { ref } from 'vue'

const modal = ref(null)
const closeModal = () => {
  modal.value.close()
}

</script>


<style>

dialog[open] {
  width: 500px;
  height: 600px;
  background-color: #dddddd;
  box-shadow: 0px 0px 10px 1px rgba(0, 0, 0, 0.30);
  border: none;
  outline: none;
}

</style>