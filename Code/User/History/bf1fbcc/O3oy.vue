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
  <Modal :show="true" @close="$emit('close')">
    <div class="p-6">
      <h2 class="text-xl font-bold text-genius-white mb-6">
        تغيير كلمة المرور
      </h2>

      <form @submit.prevent="submit" class="space-y-4">
        <div>
          <InputLabel for="current_password" value="كلمة المرور الحالية" />
          <TextInput
            id="current_password"
            type="password"
            class="mt-1 block w-full"
            v-model="form.current_password"
          />
          <InputError :message="form.errors.current_password" class="mt-2" />
        </div>

        <div>
          <InputLabel for="password" value="كلمة المرور الجديدة" />
          <TextInput
            id="password"
            type="password"
            class="mt-1 block w-full"
            v-model="form.password"
          />
          <InputError :message="form.errors.password" class="mt-2" />
        </div>

        <div>
          <InputLabel for="password_confirmation" value="تأكيد كلمة المرور" />
          <TextInput
            id="password_confirmation"
            type="password"
            class="mt-1 block w-full"
            v-model="form.password_confirmation"
          />
        </div>

        <div class="flex items-center justify-end mt-6">
          <PrimaryButton :disabled="form.processing">
            حفظ التغييرات
          </PrimaryButton>
        </div>
      </form>
    </div>
  </Modal>
</template>