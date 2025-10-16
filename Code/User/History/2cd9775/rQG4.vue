<script setup>
defineProps({
  user: {
    type: Object,
    required: true
  }
});
</script>

<template>
  <div class="p-6 bg-gradient-to-r from-genius-blue-600 to-genius-purple-600 text-center">
    <div class="w-24 h-24 mx-auto mb-4 relative">
      <img 
        :src="user.avatar" 
        :alt="user.name"
        class="rounded-full border-4 border-white shadow-xl"
      />
      <div class="absolute bottom-0 right-0 w-6 h-6 bg-genius-green-400 rounded-full border-2 border-white"></div>
    </div>
    <h2 class="text-xl font-bold text-white mb-1">{{ user.name }}</h2>
    <p class="text-blue-200 text-sm">ID: {{ user.id }}</p>
  </div>
</template>