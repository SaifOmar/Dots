<script setup>
import { ref } from 'vue';
import { Head } from '@inertiajs/vue3';
import ProfileSidebar from './Components/ProfileSidebar.vue';
import ProfileContent from './Components/ProfileContent.vue';
import ChangePasswordModal from './Modals/ChangePassword.vue';

const props = defineProps({
  user: Object
});

const activeSection = ref('personal');
const showPasswordModal = ref(false);

const handleSectionChange = (section) => {
  activeSection.value = section;
};
</script>

<template>
  <Head title="الملف الشخصي" />

  <div class="min-h-screen bg-genius-gray-900">
    <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <div class="flex flex-col md:flex-row gap-6">
        <ProfileSidebar 
          :active-section="activeSection"
          @change-section="handleSectionChange"
        />

        <ProfileContent 
          :active-section="activeSection"
          @open-password-modal="showPasswordModal = true"
        />
      </div>
    </div>

    <ChangePasswordModal 
      v-if="showPasswordModal"
      @close="showPasswordModal = false"
    />
  </div>
</template>

<style>
:root {
  --primary-color: #3cf;
  --secondary-color: #28a745;
  --text-dark: #2a2a2a;
  --text-light: #555;
  --background-light: #f5f7fa;
  --border-color: #eaeaea;
  --spacing-unit: 1rem;
  --header-height: 80px;
}

.profile-container {
  display: flex;
  gap: 2rem;
  max-width: 1400px;
  margin: 0 auto;
  padding: 2rem var(--spacing-unit);
  margin-top: var(--header-height);
}

@media (max-width: 768px) {
  .profile-container {
    flex-direction: column;
  }
}
</style>
