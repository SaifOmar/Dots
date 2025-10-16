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
    <h3 class="text-2xl font-bold text-genius-white">
      البيانات الشخصية
    </h3>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div class="bg-genius-gray-750 rounded-lg p-4">
        <label class="text-genius-gray-400 text-sm">الاسم الكامل</label>
        <p class="text-genius-white mt-1">{{ user.name }}</p>
      </div>

      <div class="bg-genius-gray-750 rounded-lg p-4">
        <label class="text-genius-gray-400 text-sm">البريد الإلكتروني</label>
        <p class="text-genius-white mt-1">{{ user.email }}</p>
      </div>

      <div class="bg-genius-gray-750 rounded-lg p-4">
        <label class="text-genius-gray-400 text-sm">كود الطالب</label>
        <p class="text-genius-white mt-1">{{ user.student_id }}</p>
      </div>

      <div class="bg-genius-gray-750 rounded-lg p-4">
        <label class="text-genius-gray-400 text-sm">المرحلة الدراسية</label>
        <p class="text-genius-white mt-1">{{ user.level?.name ?? 'غير محدد' }}</p>
      </div>
    </div>
  </div>
</template>