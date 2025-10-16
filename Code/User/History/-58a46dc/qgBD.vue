<script setup>
import { router } from '@inertiajs/vue3';

const props = defineProps({
  user: {
    type: Object,
    required: true
  },
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
  <div class="w-full md:w-80 flex-shrink-0">
    <div class="bg-genius-gray-800 rounded-lg overflow-hidden shadow-genius">
      <div class="bg-gradient-genius-primary p-6 text-center">
        <div class="relative w-24 h-24 mx-auto mb-4">
          <img
            :src="$page.props.auth.user.avatar"
            :alt="$page.props.auth.user.name"
            class="rounded-full border-4 border-genius-white object-cover w-full h-full"
          >
        </div>
        <h2 class="text-genius-white text-xl font-bold mb-1">
          {{ $page.props.auth.user.name }}
        </h2>
        <p class="text-genius-gray-300 text-sm">
          كود الطالب: {{ $page.props.auth.user.student_id }}
        </p>
      </div>

      <nav class="p-2">
        <button
          v-for="item in menuItems"
          :key="item.id"
          :class="[
            'w-full text-right px-4 py-3 rounded-lg transition-all duration-200',
            activeSection === item.id
              ? 'bg-gradient-genius-primary text-genius-white'
              : 'text-genius-gray-300 hover:bg-genius-gray-750 hover:text-genius-white'
          ]"
          @click="emit('change-section', item.id)"
        >
          {{ item.label }}
        </button>

        <button
          @click="logout"
          class="w-full text-right px-4 py-3 mt-2 text-genius-pink-400 hover:bg-genius-pink-400/10 rounded-lg transition-all duration-200"
        >
          تسجيل الخروج
        </button>
      </nav>
    </div>
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
