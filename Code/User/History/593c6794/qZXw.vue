<template>
  <section dir="rtl" class="min-h-screen bg-gradient-to-br from-genius-gray-900 via-genius-purple-900 to-genius-blue-600 relative overflow-hidden py-24"> <!-- Increased padding -->
    <!-- Decorative blobs - Made larger and more visible -->
    <div class="absolute inset-0 overflow-hidden">
      <div class="absolute -top-32 -right-32 w-120 h-120 bg-genius-blue-400/20 rounded-full blur-3xl animate-pulse"></div>
      <div class="absolute top-1/2 -left-40 w-100 h-100 bg-genius-purple-400/20 rounded-full blur-3xl animate-pulse delay-2000"></div>
      <div class="absolute bottom-0 right-1/3 w-96 h-96 bg-genius-pink-400/20 rounded-full blur-3xl animate-pulse delay-4000"></div>
    </div>

    <!-- Form Container - Made slightly larger -->
    <div class="container mx-auto px-6 relative z-10">
      <div class="flex justify-center">
        <div class="w-full max-w-2xl"> <!-- Increased max-width -->
          <div class="bg-genius-gray-800/80 backdrop-blur-xl rounded-3xl border border-genius-gray-700/50 shadow-2xl overflow-hidden">

            <!-- Header - Enhanced styling -->
            <div class="bg-gradient-to-r from-blue-600 to-purple-700 p-12 text-center">
              <div class="w-24 h-24 bg-white/15 rounded-full flex items-center justify-center mx-auto mb-6 shadow-xl">
                <!-- Updated user icon -->
                <svg class="w-12 h-12 text-white" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  <path d="M20 21C20 18.2386 16.4183 16 12 16C7.58172 16 4 18.2386 4 21" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
              </div>
              <h2 class="text-5xl font-extrabold text-white mb-3">تسجيل الدخول</h2>
              <p class="text-blue-200 text-xl">مرحباً بعودتك إلى منصة Genius EG</p>
            </div>

            <!-- Body - Enhanced input styling -->
            <div class="p-12">
              <form @submit.prevent="submitForm" class="space-y-8">
                <!-- Email field -->
                <div class="form-group text-right">
                  <label class="block text-gray-200 font-medium mb-3 text-lg">البريد الإلكتروني</label>
                  <div class="relative">
                    <input
                      v-model="form.email"
                      type="email"
                      placeholder="أدخل بريدك الإلكتروني..."
                      class="w-full px-5 py-4 bg-gray-700/70 border border-gray-500/50 rounded-2xl text-white text-xl placeholder-gray-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-500/40 focus:outline-none transition-all duration-300"
                      :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/40': errors.email }"
                      required>
                    <!-- Updated email icon -->
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                      <svg class="w-6 h-6 text-gray-400" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 8L10.89 13.26C11.2187 13.4793 11.6049 13.5963 12 13.5963C12.3951 13.5963 12.7813 13.4793 13.11 13.26L21 8M5 19H19C19.5304 19 20.0391 18.7893 20.4142 18.4142C20.7893 18.0391 21 17.5304 21 17V7C21 6.46957 20.7893 5.96086 20.4142 5.58579C20.0391 5.21071 19.5304 5 19 5H5C4.46957 5 3.96086 5.21071 3.58579 5.58579C3.21071 5.96086 3 6.46957 3 7V17C3 17.5304 3.21071 18.0391 3.58579 18.4142C3.96086 18.7893 4.46957 19 5 19Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                      </svg>
                    </div>
                  </div>
                  <span v-if="errors.email" class="text-red-400 text-sm mt-2 block">{{ errors.email }}</span>
                </div>

                <!-- Password field -->
                <div class="form-group text-right">
                  <label class="block text-gray-200 font-medium mb-3 text-lg">كلمة المرور</label>
                  <div class="relative">
                    <input
                      v-model="form.password"
                      :type="showPassword ? 'text' : 'password'"
                      placeholder="أدخل كلمة المرور..."
                      class="w-full px-5 py-4 bg-gray-700/70 border border-gray-500/50 rounded-2xl text-white text-xl placeholder-gray-400 focus:border-blue-500 focus:ring-2 focus:ring-blue-500/40 focus:outline-none transition-all duration-300 pr-12"
                      :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/40': errors.password }"
                      required>
                    <!-- Updated eye icons -->
                    <button
                      type="button"
                      @click="showPassword = !showPassword"
                      class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-gray-200 transition-colors">
                      <svg v-if="showPassword" class="w-6 h-6" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 3L21 21M10.584 10.587C10.2087 10.962 9.99775 11.4708 9.99775 12C9.99775 12.5292 10.2087 13.038 10.584 13.413C10.9593 13.788 11.4681 13.999 11.9973 13.999C12.5265 13.999 13.0353 13.788 13.4105 13.413M9.363 5.365C10.2204 5.11972 11.1082 4.99684 12 5C16 5 19.333 7.333 22 12C21.222 13.361 20.388 14.524 19.497 15.488M17.357 17.349C15.726 18.449 13.942 19 12 19C8 19 4.667 16.667 2 12C3.369 9.605 4.913 7.825 6.632 6.659" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                      </svg>
                      <svg v-else class="w-6 h-6" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15 12C15 13.6569 13.6569 15 12 15C10.3431 15 9 13.6569 9 12C9 10.3431 10.3431 9 12 9C13.6569 9 15 10.3431 15 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M2 12C3.892 7.725 7.51 5 12 5C16.49 5 20.108 7.725 22 12C20.108 16.275 16.49 19 12 19C7.51 19 3.892 16.275 2 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                      </svg>
                    </button>
                  </div>
                  <span v-if="errors.password" class="text-red-400 text-sm mt-2 block">{{ errors.password }}</span>
                </div>

                <!-- Buttons - Enhanced styling -->
                <div class="space-y-6 pt-8">
                  <!-- Login button -->
                  <button
                    type="submit"
                    :disabled="isSubmitting"
                    class="group relative w-full px-8 py-5 bg-gradient-to-r from-blue-500 to-purple-600 rounded-2xl text-2xl font-bold text-white hover:from-blue-600 hover:to-purple-700 transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-2xl disabled:opacity-50 disabled:cursor-not-allowed">
                    <span v-if="!isSubmitting" class="relative z-10 flex items-center justify-center">
                      <svg class="w-7 h-7 ml-2" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15 3H19C19.5304 3 20.0391 3.21071 20.4142 3.58579C20.7893 3.96086 21 4.46957 21 5V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H15M10 17L15 12M15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                      </svg>
                      تسجيل الدخول
                    </span>
                    <span v-else class="flex items-center justify-center">
                      <svg class="animate-spin -ml-1 mr-3 h-6 w-6 text-white" viewBox="0 0 24 24" fill="none">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      جاري تسجيل الدخول...
                    </span>
                    <div class="absolute inset-0 bg-gradient-to-r from-blue-400 to-purple-500 rounded-2xl blur opacity-30 group-hover:opacity-50 transition-opacity"></div>
                  </button>

                  <!-- Google button -->
                  <button
                    type="button"
                    @click="registerWithGoogle"
                    class="w-full px-8 py-5 bg-white hover:bg-gray-50 border border-gray-200 rounded-2xl text-xl font-medium text-gray-700 transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl flex items-center justify-center">
                    <svg class="w-7 h-7 ml-3" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M23.766 12.2764C23.766 11.4607 23.6999 10.6406 23.5588 9.83807H12.24V14.4591H18.7217C18.4528 15.9494 17.5885 17.2678 16.323 18.1056V21.1039H20.19C22.4608 19.0139 23.766 15.9274 23.766 12.2764Z" fill="#4285F4"/>
                      <path d="M12.24 24.0008C15.4764 24.0008 18.2058 22.9382 20.1944 21.1039L16.3274 18.1055C15.2516 18.8375 13.8626 19.252 12.24 19.252C9.07109 19.252 6.40935 17.1399 5.47126 14.3003H1.47583V17.3912C3.45889 21.4434 7.55824 24.0008 12.24 24.0008Z" fill="#34A853"/>
                      <path d="M5.47126 14.3003C5.23441 13.5591 5.10148 12.7737 5.10148 11.9997C5.10148 11.2257 5.23441 10.4404 5.47126 9.69922V6.60827H1.47583C0.536328 8.23827 0 10.0657 0 11.9997C0 13.9337 0.536328 15.7611 1.47583 17.3912L5.47126 14.3003Z" fill="#FBBC05"/>
                      <path d="M12.24 4.74966C14.0291 4.74966 15.6265 5.36715 16.8732 6.54838L20.2695 3.12262C18.2015 1.18838 15.4764 0 12.24 0C7.55824 0 3.45889 2.55742 1.47583 6.60827L5.47126 9.69922C6.40935 6.85965 9.07109 4.74966 12.24 4.74966Z" fill="#EA4335"/>
                    </svg>
                    تسجيل الدخول باستخدام Google
                  </button>
                </div>

                <!-- Link to register - Enhanced styling -->
                <div class="text-center pt-8 border-t border-gray-700/50">
                  <p class="text-gray-400 text-lg">
                    ليس لديك حساب؟
                    <a href="/register" class="text-blue-400 hover:text-blue-300 font-medium transition-colors mr-2">
                      إنشاء حساب جديد
                    </a>
                  </p>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer - Enhanced styling -->
    <div class="text-center pt-20 text-gray-400">
      <p class="text-lg">
        حقوق النشر ©
        <a href="https://www.facebook.com/profile.php?id=100090024653201&mibextid=ZbWKwL"
           target="_blank"
           class="text-blue-400 hover:text-blue-300 transition-colors">
          فريق NSP ٢٠٢٤
        </a>
        . جميع الحقوق محفوظة
      </p>
    </div>
  </section>
</template>

<script setup>
import { ref, reactive } from 'vue'

// Form state
const form = reactive({
  email: '',
  password: '',
})

// UI state
const isSubmitting = ref(false)
const showPassword = ref(false)
const errors = ref({})

// Grade levels

// Form submission
const submitForm = async () => {
  isSubmitting.value = true
  errors.value = {}

  try {
    console.log('Form submitted:', form)

    await new Promise(resolve => setTimeout(resolve, 2000))

    alert('تم إنشاء الحساب بنجاح!')

  } catch (error) {
    if (error.response && error.response.data.errors) {
      errors.value = error.response.data.errors
    } else {
      console.error('Registration error:', error)
    }
  } finally {
    isSubmitting.value = false
  }
}

const registerWithGoogle = () => {
  window.location.href = '/auth/google'
}
</script>

<style scoped>
/* Custom select arrow */
select {
  background-image: url("data:image/svg+xml;charset=US-ASCII,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m1 6 6 6 6-6'/%3e%3c/svg%3e");
  background-repeat: no-repeat;
  background-position: left 0.75rem center;
  background-size: 16px 12px;
}

/* Focus ring improvements */
.focus\:ring-blue-500\/20:focus {
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.2);
}

.focus\:ring-red-500\/20:focus {
  box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.2);
}

/* Loading spinner */
@keyframes spin {
  to { transform: rotate(360deg); }
}

.animate-spin {
  animation: spin 1s linear infinite;
}
</style>
