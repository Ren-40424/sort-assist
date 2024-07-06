<template>
<div @click="modal.showModal" id="add-user-btn">追加</div>
<dialog ref="modal">

  <!-- 1ページ目 -->
  <template v-if="currentPage === 1">
    <div class="modal-top">
      <div class="modal-title">追加するユーザーを選択してください</div>
      <div class="close" @click="closeModal">✕</div>
    </div>

    <div class="modal-main">
      <div class="search-input">
        <input class="input" placeholder="名前を入力" v-model="searchQuery" @input="searchUsers">
      </div>
      <div class="search-result">
        <div v-for="user in searchResults" :key="user.id">
          <div class="user" :id="'user-' + user.id">
            <div class="user-name">
              <input type="checkbox" name="user-name" :id="user.id" v-model="selectedUsers" :value="user">
              <label :for="user.id">{{ user.name }}</label>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-bottom-buttons">
        <div class="page-change-btn" @click="nextPage" :style="{ backgroundColor: buttonColor }">進む</div>
      </div>
    </div>
  </template>

  <!-- 2ページ目 -->
  <template v-if="currentPage === 2">
    <div class="modal-top">
      <div class="modal-title">編集を許可するユーザーを選択してください</div>
      <br><br>
      <div class="close" @click="closeModal">✕</div>
    </div>
    
    <div class="modal-main">
      <div class="search-result">
        <div v-for="user in usersData">
          <div class="user" :id="'user-' + user">
            <div class="user-name">
              <input type="checkbox" name="user-name" :id="user.id" :value="user.id" v-model="allowedEditUsers">
              <label :for="user.id">{{ user.name }}</label>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-bottom-buttons">
      <div class="page-change-btn" @click="beforePage">戻る</div>
      <div class="submit-btn" @click="submit">ユーザーを追加する</div>
    </div>
  </template>

</dialog>
</template>

<script setup>
import { ref, watch } from 'vue';
import axios from 'axios';

// モーダル開閉用
const modal = ref(null)

const closeModal = () => {
  selectedUsers.value = []
  searchQuery.value = ''
  currentPage.value = 1
  modal.value.close()
}

// ページ変更機能
const currentPage = ref(1)
const nextPage = () => {
  // 何も選択していないときはページを変更しない
  if (usersData.value.length === 0) return
  currentPage.value++
}

const beforePage = () => {
  allowedEditUsers.value = []
  currentPage.value--
}

// ユーザー検索機能
const searchQuery = ref('')
const searchResults = ref([])

const searchUsers = async () => {
  // クエリが空の場合は検索を行わない
  if (searchQuery.value.trim() === '') {
    return
  }
  try {
    const response = await axios.get('/users/search', {
      params: {
        workspace_id: window.workspaceId,
        query: searchQuery.value
      }
    })
    searchResults.value = response.data
  } catch (error) {
    console.error('Error fetching users:', error)
  }
}

// ユーザー選択機能
const selectedUsers = ref([])
const allowedEditUsers = ref([])
const usersData = ref([]) // ユーザー選択後に検索を行った場合でも動くように値を保存しておく

watch(selectedUsers, () => {
  usersData.value = selectedUsers.value
  usersData.value.sort((a, b) => a.id - b.id); // ユーザーが選択した順番によって2ページ目の表示順が変わらないようにソート
})

// ボタンの色変更
let buttonColor ='gray'
watch(() => selectedUsers.value, () => {
  if(selectedUsers.value.length === 0){
    buttonColor = 'gray'
  }else{
    buttonColor ='#28385E'
  }
})

// paramsに含める値を整形する
const formatParams = (users, allowedId) => {
  const params = []
  users.forEach((user) => {
    params.push({ workspace_id: window.workspaceId, user_id: user.id, role_id: isAllowed(user.id) })
  })

  function isAllowed(id) { // role.idが2なら編集可能
    if (allowedId.includes(id)) {
      return 2
    } else {
      return 3
    }
  }
  return params
}

const submit = () => {
  const params = formatParams(usersData.value, allowedEditUsers.value)
  if (usersData.value.length === 0) return
  
  axios.post('/api/workspaces/add_user', {
    workspace_user: params
  })
  closeModal()
}
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

.close {
  text-align: end;
  cursor: pointer;
}

.search-input {
  width: 100%;
  display: flex;
  justify-content: center;
}

.search-result {
  padding: 30px 45px;
  background-color: #ebebeb;
  border-radius: 10px;
  width: 80%;
  height: 400px;
  margin: auto;
  overflow: auto;
  position: relative;
}

.search-result::-webkit-scrollbar {
  width: 8px;
  border-radius: 4px;
  background-color: #ebebeb; 
}

.search-result::-webkit-scrollbar-thumb {
  width: 6px;
  border-radius: 3px;
  background-color: #505050;
}

.user {
  display: flex;
  margin-bottom: 10px;
  cursor: default;
}

.user-name {
  display: flex;
  margin: auto;
}

.user-name input{
  display: none;
}

.user-name label {
  display: block;
  padding: 2px 10px;
  text-align: center;
  text-decoration: none;
  border-radius: 5px;
}

.user-name label:hover {
  background-color: #bbbbbb;
}

.user-name input:checked+label {
  background-color: #28385E;
  color: white;
}

.modal-bottom-buttons {
  width: 75%;
  margin: 30px auto;
  display: flex;
  justify-content: space-around;
  align-items: center;
}


div[class$='-btn']{
  width: 150px;
  height: 30px;
  border: none;
  border-radius: 5px;
  background-color: #28385E;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
}

.checkbox {
  margin-right: 60px;
}

.submit-btn {
  margin: 0;
}
</style>