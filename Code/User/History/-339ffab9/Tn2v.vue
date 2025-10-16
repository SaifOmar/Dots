<script setup>
import { router } from '@inertiajs/vue3';

const props = defineProps({
  sections: {
    type: Array,
    required: true
  },
  activeSection: {
    type: String,
    required: true
  }
});

const emit = defineEmits(['section-changed']);

const logout = () => {
  router.post(route('logout'));
};
</script>

<template>
  <nav class="profile-menu">
    <button
      v-for="section in sections"
      :key="section.id"
      :class="['menu-item', { active: activeSection === section.id }]"
      @click="emit('section-changed', section.id)"
    >
      {{ section.label }}
    </button>
    
    <button @click="logout" class="menu-item logout">
      تسجيل الخروج
    </button>
  </nav>
</template>

<style scoped>
.profile-menu {
  background-color: white;
  border-radius: 0 0 12px 12px;
  overflow: hidden;
}

.menu-item {
  width: 100%;
  padding: 1rem 1.5rem;
  text-align: right;
  background: none;
  border: none;
  border-bottom: 1px solid #eaeaea;
  font-size: 1rem;
  color: #2a2a2a;
  cursor: pointer;
  transition: all 0.2s ease;
}

.menu-item:hover {
  background-color: #f5f7fa;
  color: #3cf;
}

.menu-item.active {
  background-color: #3cf;
  color: white;
}

.menu-item.logout {
  color: #dc3545;
}

.menu-item.logout:hover {
  background-color: #dc3545;
  color: white;
}
</style>