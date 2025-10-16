<script setup>
import { router } from '@inertiajs/vue3';

defineProps({
  activeSection: {
    type: String,
    required: true
  }
});

const emit = defineEmits(['change-section']);

const menuItems = [
  { id: 'personal', label: 'البيانات الشخصية' },
  { id: 'subscriptions', label: 'الاشتراكات' },
  { id: 'quiz-scores', label: 'درجات الكويزات' },
  { id: 'payment', label: 'طرق الدفع' },
  { id: 'account', label: 'تفاصيل الحساب' }
];

const logout = () => {
  router.post(route('logout'));
};
</script>

<template>
  <div class="profile-sidebar">
    <div class="profile-header">
      <div class="profile-avatar">
        <img 
          :src="$page.props.auth.user.avatar"
          :alt="$page.props.auth.user.name"
        >
      </div>
      <h2 class="profile-name">{{ $page.props.auth.user.name }}</h2>
      <div class="profile-id">كود الطالب: {{ $page.props.auth.user.student_id }}</div>
    </div>

    <ul class="profile-menu">
      <li v-for="item in menuItems" :key="item.id">
        <button 
          :class="['menu-button', { active: activeSection === item.id }]"
          @click="emit('change-section', item.id)"
        >
          {{ item.label }}
        </button>
      </li>
      <li>
        <button @click="logout" class="menu-button logout">
          تسجيل الخروج
        </button>
      </li>
    </ul>
  </div>
</template>

<style scoped>
.profile-sidebar {
  width: 300px;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  overflow: hidden;
  height: fit-content;
}

.profile-header {
  background-color: var(--primary-color);
  color: white;
  padding: 2rem 1.5rem;
  text-align: center;
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

.profile-menu {
  list-style: none;
  padding: 0;
  margin: 0;
}

.menu-button {
  width: 100%;
  padding: 1rem 1.5rem;
  text-align: right;
  background: none;
  border: none;
  border-bottom: 1px solid var(--border-color);
  font-size: 1rem;
  color: var(--text-dark);
  cursor: pointer;
  transition: all 0.2s ease;
}

.menu-button:hover {
  background-color: var(--background-light);
  color: var(--primary-color);
}

.menu-button.active {
  background-color: var(--primary-color);
  color: white;
}

.menu-button.logout {
  color: #dc3545;
}

.menu-button.logout:hover {
  background-color: #dc3545;
  color: white;
}
</style>