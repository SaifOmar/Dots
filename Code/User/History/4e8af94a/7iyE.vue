<script setup>
import { ref } from 'vue';
import { Head } from '@inertiajs/vue3';
import ProfileHeader from './Components/ProfileHeader.vue';
import ProfileMenu from './Components/ProfileMenu.vue';
import ProfileContent from './Components/ProfileContent.vue';
import ChangePassword from './Modals/ChangePassword.vue';

const activeSection = ref('personal');
const showPasswordModal = ref(false);

const sections = [
  { id: 'personal', label: 'البيانات الشخصية' },
  { id: 'subscriptions', label: 'الاشتراكات' },
  { id: 'quiz-scores', label: 'درجات الكويزات' },
  { id: 'payment', label: 'طرق الدفع' },
  { id: 'account', label: 'تفاصيل الحساب' }
];
</script>

<template>
  <Head title="الملف الشخصي" />

  <div class="min-h-screen bg-gray-100">
    <div class="profile-container">
      <aside class="profile-sidebar">
        <ProfileHeader :user="$page.props.auth.user" />
        <ProfileMenu 
          :sections="sections" 
          :active-section="activeSection"
          @section-changed="activeSection = $event"
        />
      </aside>

      <ProfileContent 
        :active-section="activeSection"
        :user="$page.props.auth.user"
        @open-password-modal="showPasswordModal = true"
      />
    </div>

    <ChangePassword 
      v-if="showPasswordModal"
      @close="showPasswordModal = false"
    />
  </div>
</template>

<style scoped>
.profile-container {
  display: flex;
  gap: 2rem;
  max-width: 1400px;
  margin: 0 auto;
  padding: 2rem 1rem;
}

.profile-sidebar {
  width: 300px;
  flex-shrink: 0;
}

@media (max-width: 768px) {
  .profile-container {
    flex-direction: column;
  }

  .profile-sidebar {
    width: 100%;
  }
}
</style>