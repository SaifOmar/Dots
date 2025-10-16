<script setup>
import { useForm } from '@inertiajs/vue3';

const emit = defineEmits(['close']);

const form = useForm({
  current_password: '',
  password: '',
  password_confirmation: '',
});

const submit = () => {
  form.put(route('password.update'), {
    preserveScroll: true,
    onSuccess: () => {
      emit('close');
    },
  });
};
</script>

<template>
  <div class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center">
    <div class="bg-genius-gray-800 rounded-2xl p-6 w-full max-w-md mx-4">
      <h3 class="text-xl font-bold text-white mb-6">تغيير كلمة المرور</h3>
      
      <form @submit.prevent="submit" class="space-y-4">
        <div class="space-y-2">
          <label class="block text-gray-300">كلمة المرور الحالية</label>
          <input
            v-model="form.current_password"
            type="password"
            class="w-full px-4 py-3 bg-genius-gray-700/50 border border-genius-gray-600 rounded-xl text-white"
          />
        </div>
        
        <!-- Add new password and confirmation fields -->
        
        <div class="flex justify-end space-x-4">
          <button
            type="button"
            @click="emit('close')"
            class="px-6 py-3 bg-genius-gray-700 text-white rounded-xl hover:bg-genius-gray-600"
          >
            إلغاء
          </button>
          <button
            type="submit"
            :disabled="form.processing"
            class="px-6 py-3 bg-gradient-to-r from-genius-blue-500 to-genius-purple-500 text-white rounded-xl hover:from-genius-blue-600 hover:to-genius-purple-600"
          >
            تأكيد
          </button>
        </div>
      </form>
    </div>
  </div>
</template>