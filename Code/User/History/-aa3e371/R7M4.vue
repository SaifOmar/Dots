<script setup>
import { ref } from 'vue';
import { useForm } from '@inertiajs/vue3';

const emit = defineEmits(['open-password-modal']);

const settings = ref({
  emailNotifications: true,
  twoFactorAuth: false,
  language: 'ar'
});

const form = useForm({
  email_notifications: settings.value.emailNotifications,
  two_factor_auth: settings.value.twoFactorAuth,
  language: settings.value.language
});

const updateSettings = () => {
  form.put(route('settings.update'), {
    preserveScroll: true
  });
};

const deleteAccount = () => {
  if (confirm('هل أنت متأكد من حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.')) {
    // Implement account deletion
  }
};
</script>

<template>
  <div class="space-y-8">
    <h2 class="text-2xl font-bold text-white mb-6">إعدادات الحساب</h2>

    <div class="space-y-6">
      <!-- Notifications -->
      <div class="flex items-center justify-between p-4 bg-genius-gray-700/30 rounded-xl">
        <div>
          <h3 class="text-white font-medium">إشعارات البريد الإلكتروني</h3>
          <p class="text-gray-400 text-sm">استلام إشعارات عن الكورسات والتحديثات</p>
        </div>
        <label class="relative inline-flex items-center cursor-pointer">
          <input 
            type="checkbox"
            v-model="form.email_notifications"
            class="sr-only peer"
          >
          <div class="w-11 h-6 bg-genius-gray-600 peer-focus:outline-none rounded-full peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:right-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-genius-blue-500"></div>
        </label>
      </div>

      <!-- Two Factor Auth -->
      <div class="flex items-center justify-between p-4 bg-genius-gray-700/30 rounded-xl">
        <div>
          <h3 class="text-white font-medium">المصادقة الثنائية</h3>
          <p class="text-gray-400 text-sm">تأمين إضافي لحسابك</p>
        </div>
        <label class="relative inline-flex items-center cursor-pointer">
          <input 
            type="checkbox"
            v-model="form.two_factor_auth"
            class="sr-only peer"
          >
          <div class="w-11 h-6 bg-genius-gray-600 peer-focus:outline-none rounded-full peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:right-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-genius-blue-500"></div>
        </label>
      </div>

      <!-- Language Selection -->
      <div class="flex items-center justify-between p-4 bg-genius-gray-700/30 rounded-xl">
        <div>
          <h3 class="text-white font-medium">اللغة</h3>
          <p class="text-gray-400 text-sm">اختر لغة التطبيق</p>
        </div>
        <select 
          v-model="form.language"
          class="bg-genius-gray-700 text-white rounded-lg px-4 py-2 border border-genius-gray-600"
        >
          <option value="ar">العربية</option>
          <option value="en">English</option>
        </select>
      </div>

      <!-- Password Change -->
      <div class="flex items-center justify-between p-4 bg-genius-gray-700/30 rounded-xl">
        <div>
          <h3 class="text-white font-medium">كلمة المرور</h3>
          <p class="text-gray-400 text-sm">تغيير كلمة المرور الخاصة بك</p>
        </div>
        <button 
          @click="emit('open-password-modal')"
          class="px-4 py-2 bg-genius-blue-500 hover:bg-genius-blue-600 text-white rounded-lg transition-colors"
        >
          تغيير
        </button>
      </div>

      <!-- Save Settings Button -->
      <button
        @click="updateSettings"
        :disabled="form.processing"
        class="w-full px-6 py-3 bg-gradient-to-r from-genius-blue-500 to-genius-purple-500 text-white rounded-xl hover:from-genius-blue-600 hover:to-genius-purple-600 transition-all"
      >
        حفظ التغييرات
      </button>

      <!-- Delete Account -->
      <div class="border-t border-genius-gray-600 pt-6">
        <h3 class="text-white font-medium mb-4">حذف الحساب</h3>
        <p class="text-gray-400 text-sm mb-4">
          عند حذف حسابك، سيتم حذف جميع بياناتك بشكل نهائي. هذا الإجراء لا يمكن التراجع عنه.
        </p>
        <button
          @click="deleteAccount"
          class="px-6 py-3 bg-genius-red-500/20 text-genius-red-400 rounded-xl hover:bg-genius-red-500/30 transition-colors"
        >
          حذف الحساب
        </button>
      </div>
    </div>
  </div>
</template>