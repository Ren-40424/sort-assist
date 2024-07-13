<template>
  <div class="header">
    <div class="user-auth-button">
    <!--
      <% if user_signed_in? %>
        <%= link_to current_user[:name], user_path(current_user), data: { turbo: false } %> さん
        <%= link_to 'ログアウト', destroy_user_session_path, data: { turbo: true, turbo_method: :delete } %>
      <% else %>
        <%= link_to '新規登録', new_user_registration_path %>
        <%= link_to 'ログイン', new_user_session_path %>
      <% end %>
    -->
    </div>
  </div>
</template>

<script setup>


</script>

<style scoped>

.header {
  background-color: #444444;
  height: 5vh;
  width: 100%;
  display: flex;
  align-items: center;
  color: #ffffff;
}

.user-auth-button {
  margin-left: auto;
  padding-right: 20px;
}

.user-auth-button a {
  color: #ffffff;
}
</style>