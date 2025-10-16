<script setup>
const props = defineProps({
  activeTab: {
    type: String,
    required: true
  }
});

const emit = defineEmits(['change-tab']);

const menuItems = [
  { id: 'personal', label: 'المعلومات الشخصية', icon: 'user' },
  { id: 'subscriptions', label: 'الاشتراكات', icon: 'star' },
  { id: 'scores', label: 'نتائج الاختبارات', icon: 'chart' },
  { id: 'payments', label: 'طرق الدفع', icon: 'credit-card' },
  { id: 'settings', label: 'إعدادات الحساب', icon: 'cog' }
];
</script>

<template>
  <nav class="py-2">
    <button
      v-for="item in menuItems"
      :key="item.id"
      @click="emit('change-tab', item.id)"
      :class="[
        'w-full px-6 py-4 text-right flex items-center justify-between transition-all',
        activeTab === item.id
          ? 'bg-genius-blue-600 text-white'
          : 'text-gray-300 hover:bg-genius-gray-700/50 hover:text-white'
      ]"
    >
      <span class="text-lg">{{ item.label }}</span>
      <!-- Add your icons here -->
    </button>
  </nav>
</template>