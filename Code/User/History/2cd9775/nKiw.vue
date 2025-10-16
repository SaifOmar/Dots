<script setup>
defineProps({
  user: {
    type: Object,
    required: true
  }
});
</script>

<template>
  <div class="profile-header">
    <div class="profile-avatar">
      <img 
        :src="user.avatar.startsWith('https') ? user.avatar : `/storage/${user.avatar}`" 
        :alt="user.name"
      >
    </div>
    <h2 class="profile-name">{{ user.name }}</h2>
    <div class="profile-id">كود الطالب: {{ user.student_id }}</div>
  </div>
</template>

<style scoped>
.profile-header {
  background: linear-gradient(to right, #3cf, #6366f1);
  color: white;
  padding: 2rem 1.5rem;
  text-align: center;
  border-radius: 12px 12px 0 0;
}

.profile-avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  margin: 0 auto 1rem;
  border: 4px solid white;
  overflow: hidden;
}

.profile-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.profile-name {
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0;
}

.profile-id {
  font-size: 0.875rem;
  opacity: 0.9;
}
</style>