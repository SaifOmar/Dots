<script setup>
import PersonalInfo from './PersonalInfo.vue';
import Subscriptions from './Subscriptions.vue';
import QuizScores from './QuizScores.vue';
import PaymentMethods from './PaymentMethods.vue';
import AccountSettings from './AccountSettings.vue';

const props = defineProps({
  activeSection: {
    type: String,
    required: true
  },
  user: {
    type: Object,
    required: true
  }
});

const emit = defineEmits(['open-password-modal']);

const components = {
  personal: PersonalInfo,
  subscriptions: Subscriptions,
  'quiz-scores': QuizScores,
  payment: PaymentMethods,
  account: AccountSettings
};
</script>

<template>
  <main class="flex-1">
    <div class="bg-genius-gray-800 rounded-lg shadow-genius p-6">
      <component 
        :is="components[activeSection]"
        :user="$page.props.auth.user"
        @open-password-modal="emit('open-password-modal')"
      />
    </div>
  </main>
</template>

<style scoped>
.profile-content {
  flex: 1;
  background-color: white;
  border-radius: 12px;
  padding: 2rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  min-height: 500px;
}

@media (max-width: 768px) {
  .profile-content {
    margin-top: 1rem;
  }
}
</style>