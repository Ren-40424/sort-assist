<template>
<div @click="modal.showModal" class="add-user-btn">ユーザーを追加する</div>
<dialog ref="modal">

  <!-- 1ページ目 -->
  <template v-if="currentPage === 1">
    {{ userIds }}
    <div class="modal-top">
      <div class="modal-title">追加するユーザーを選択してください：</div>
      
      <div class="close-btn" @click="closeModal">✕</div>
    </div>

    <div class="modal-main">
      <input class="input" placeholder="名前を入力" v-model="searchQuery" @input="searchUsers">
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
      <div class="page-change-btn" @click="nextPage">進む</div>
    </div>
  </template>

  <!-- 2ページ目 -->
  <template v-if="currentPage === 2">
    <div class="modal-top">
      <div class="modal-title">編集を許可するユーザーを選択してください</div>
      {{ allowedEditUsers }}
      <br><br>
      <div class="close-btn" @click="closeModal">✕</div>
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
    <div class="page-change-btn" @click="beforePage">戻る</div>
    <input type="submit" class="submit-btn" placeholder="ユーザーを追加する" @click="submit">
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
    // users.value = []
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
const userIds = ref([])

watch(selectedUsers, () => {
  usersData.value = selectedUsers.value
  usersData.value.sort((a, b) => a.id - b.id); // ユーザーが選択した順番によって2ページ目の表示順が変わらないようにソート
  userIds.value = usersData.value.map(user => user.id)
})

// selectedUsersとallowedEditUsersの情報をバックエンドに送信したい
// selectedUsers, allowedEditUsersの中身はUserIDの配列なので、
// まずparamsとなる配列[{user_id: 追加するユーザー, workspace_id: このワークスペースのID(getで取得が必要か?), role_id: 3}]をselectedUsersのlength分だけ作り、
// allowedEditUsersをキーにfindメソッドで取得したrole_idを2にする

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
  console.log(params)
  if (!userIds) return
  axios.post('/api/workspaces/add_user', {
    workspace_user: params
  })
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

.close-btn {
  text-align: end;
  cursor: pointer;
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
  padding: 0 10px;
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

.page-change-btn {
  background-color: #28385E;
  color: white;
  margin: 20px auto 0;
  width: 150px;
  border-radius: 5px;
}

.checkbox {
  margin-right: 60px;
}

</style>