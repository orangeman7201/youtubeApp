<template>
  <div class="user-content">
    <img v-if="user.image_url" :src="user.image_url" art="" class="user-image" />
    <img v-else src="~user_default.svg" art="" class="user-image"/>
    <div class="user-info">
      <div class="user-name-text">
        {{ user.name }}
      </div>
      <div class="user-uuid-text">
        ID:{{ user.uuid}}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["user"],
}
</script>

<style scoped>
.user-content {
  display: grid;
  gap: 0 16px;
  grid-template-columns: 45px 1fr;
  background: #F1F1F1;
  margin-bottom: 30px;
  padding: 16px;
}
.user-image {
  width: 45px;
  height: 45px;
}
.user-name-text {
  font-size: 15px;
}
.user-uuid-text {
  font-size: 13px;
  color: #858585
}
</style>
