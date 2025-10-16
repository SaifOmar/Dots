<script setup>
import { useForm } from '@inertiajs/vue3';

const form = useForm({
  name: '',
  email: '',
  phone: '',
  address: '',
});

const submit = () => {
  form.put(route('profile.update'), {
    preserveScroll: true,
    onSuccess: () => {
      // Show success message
    },
  });
};
</script>

<template>
  <div class="space-y-6">
    <h2 class="text-2xl font-bold text-white mb-6">المعلومات الشخصية</h2>
    
    <form @submit.prevent="submit" class="space-y-6">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="block text-gray-300">الاسم</label>
          <input
            v-model="form.name"
            type="text"
            class="w-full px-4 py-3 bg-genius-gray-700/50 border border-genius-gray-600 rounded-xl text-white"
          />
        </div>
        
        <!-- Add more form fields -->
      </div>
      
      <button
        type="submit"
        :disabled="form.processing"
        class="px-6 py-3 bg-gradient-to-r from-genius-blue-500 to-genius-purple-500 text-white rounded-xl hover:from-genius-blue-600 hover:to-genius-purple-600 transition-all"
      >
        حفظ التغييرات
      </button>
    </form>
  </div>
</template>