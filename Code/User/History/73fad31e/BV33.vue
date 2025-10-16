<template>
  <section class="min-h-screen bg-gradient-genius-hero relative overflow-hidden py-16">
    <!-- Decorative blobs -->
    <div class="absolute inset-0 overflow-hidden">
      <div class="absolute -top-20 -right-20 w-80 h-80 bg-genius-blue-400/20 rounded-full blur-3xl animate-pulse"></div>
      <div class="absolute top-1/2 -left-32 w-72 h-72 bg-genius-purple-400/20 rounded-full blur-3xl animate-pulse delay-1000"></div>
      <div class="absolute bottom-0 right-1/3 w-64 h-64 bg-genius-pink-400/20 rounded-full blur-3xl animate-pulse delay-2000"></div>
    </div>

    <div class="container mx-auto px-4 max-w-2xl relative z-10">
      <!-- Header -->
      <div class="bg-gradient-genius-primary p-8 text-center rounded-t-2xl">
        <div class="w-16 h-16 bg-genius-white/15 rounded-full flex items-center justify-center mx-auto mb-4 shadow-genius">
          <!-- Contact icon -->
          <svg class="w-8 h-8 text-genius-white" viewBox="0 0 24 24" fill="none">
            <path d="M4 4H20C21.1 4 22 4.9 22 6V18C22 19.1 21.1 20 20 20H4C2.9 20 2 19.1 2 18V6C2 4.9 2.9 4 4 4Z"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M22 6L12 13L2 6"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        </div>
        <h2 class="text-3xl font-extrabold text-genius-white mb-2">تواصل معنا</h2>
      </div>

      <!-- Success Message -->
      <div v-if="showSuccess" 
           class="bg-genius-green-400/90 border border-genius-green-400 text-genius-white px-6 py-4 rounded-none flex items-center">
        <svg class="w-6 h-6 mr-3 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
        </svg>
        <span>{{ successMessage }}</span>
      </div>

      <!-- Form -->
      <div class="bg-genius-gray-800/80 backdrop-blur-sm p-8 rounded-b-2xl shadow-genius">
        <form @submit.prevent="submitForm" class="space-y-6">
          <!-- Name -->
          <div class="form-group text-right">
            <label class="block text-genius-gray-300 font-medium mb-2 text-base">الاسم</label>
            <input
              v-model="form.name"
              type="text"
              placeholder="أدخل اسمك..."
              class="w-full px-4 py-3 bg-genius-gray-700/70 border border-genius-gray-500/50 rounded-xl text-genius-white placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/40 focus:outline-none transition-all duration-300"
              :class="{ 'border-genius-pink-400 focus:border-genius-pink-400 focus:ring-genius-pink-400/40': form.errors.name }"
              required>
            <span v-if="form.errors.name" class="text-genius-pink-400 text-sm mt-1 block">{{ form.errors.name }}</span>
          </div>

          <!-- Email -->
          <div class="form-group text-right">
            <label class="block text-genius-gray-300 font-medium mb-2 text-base">البريد الإلكتروني</label>
            <input
              dir="ltr"
              v-model="form.email"
              type="email"
              placeholder="أدخل بريدك الإلكتروني..."
              class="w-full px-4 py-3 bg-genius-gray-700/70 border border-genius-gray-500/50 rounded-xl text-genius-white placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/40 focus:outline-none transition-all duration-300"
              :class="{ 'border-genius-pink-400 focus:border-genius-pink-400 focus:ring-genius-pink-400/40': form.errors.email }"
              required>
            <span v-if="form.errors.email" class="text-genius-pink-400 text-sm mt-1 block">{{ form.errors.email }}</span>
          </div>

          <!-- Subject -->
          <div class="form-group text-right">
            <label class="block text-genius-gray-300 font-medium mb-2 text-base">الموضوع</label>
            <input
              v-model="form.subject"
              type="text"
              placeholder="أدخل موضوع الرسالة..."
              class="w-full px-4 py-3 bg-genius-gray-700/70 border border-genius-gray-500/50 rounded-xl text-genius-white placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/40 focus:outline-none transition-all duration-300"
              :class="{ 'border-genius-pink-400 focus:border-genius-pink-400 focus:ring-genius-pink-400/40': form.errors.subject }"
              required>
            <span v-if="form.errors.subject" class="text-genius-pink-400 text-sm mt-1 block">{{ form.errors.subject }}</span>
          </div>

          <!-- Message -->
          <div class="form-group text-right">
            <label class="block text-genius-gray-300 font-medium mb-2 text-base">الرسالة</label>
            <textarea
              v-model="form.message"
              rows="4"
              placeholder="اكتب رسالتك هنا..."
              class="w-full px-4 py-3 bg-genius-gray-700/70 border border-genius-gray-500/50 rounded-xl text-genius-white placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/40 focus:outline-none transition-all duration-300 resize-none"
              :class="{ 'border-genius-pink-400 focus:border-genius-pink-400 focus:ring-genius-pink-400/40': form.errors.message }"
              required></textarea>
            <span v-if="form.errors.message" class="text-genius-pink-400 text-sm mt-1 block">{{ form.errors.message }}</span>
          </div>

          <!-- Submit button -->
          <div class="pt-4">
            <button
              type="submit"
              :disabled="form.processing"
              class="group relative w-full px-6 py-4 bg-gradient-genius-primary rounded-xl text-lg font-bold text-genius-white hover:opacity-90 transition-all duration-300 transform hover:scale-105 shadow-genius hover:shadow-genius-lg disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none">
              <span v-if="!form.processing" class="relative z-10 flex items-center justify-center">
                <svg class="w-5 h-5 ml-2" viewBox="0 0 24 24" fill="none">
                  <path d="M2 21L23 12L2 3V10L17 12L2 14V21Z"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                إرسال الرسالة
              </span>
              <span v-else class="flex items-center justify-center">
                <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-genius-white" viewBox="0 0 24 24" fill="none">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor"
                        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042
                           1.135 5.824 3 7.938l3-2.647z"/>
                </svg>
                جاري الإرسال...
              </span>
              <div class="absolute inset-0 bg-gradient-genius-secondary rounded-xl blur opacity-30 group-hover:opacity-50 transition-opacity"></div>
            </button>
          </div>
        </form>
      </div>
    </div>
  </section>
</template>

<script setup>
import { useForm } from '@inertiajs/vue3'
import { ref } from 'vue'

const form = useForm({
  name: '',
  email: '',
  subject: '',
  message: ''
})

const showSuccess = ref(false)
const successMessage = ref('')

const submitForm = () => {
  form.post(route('contact.store'), {
    onSuccess: () => {
      form.reset()
      successMessage.value = 'تم إرسال رسالتك بنجاح! شكراً لتواصلك معنا.'
      showSuccess.value = true
      window.scrollTo({ top: 0, behavior: 'smooth' })

      // Hide success message after 5 seconds
      setTimeout(() => {
        showSuccess.value = false
      }, 5000)
    },
    onError: () => {
      showSuccess.value = false
    }
  })
}
</script>
