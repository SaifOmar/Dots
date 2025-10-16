<template>
  <section class="min-h-screen bg-gradient-genius-hero relative overflow-hidden py-20 font-cairo">
    <!-- Animated Background Elements -->
    <div class="absolute inset-0 overflow-hidden">
      <div class="absolute -top-32 -right-32 w-96 h-96 bg-genius-blue-400/5 rounded-full animate-pulse"></div>
      <div class="absolute top-1/2 -left-40 w-80 h-80 bg-genius-purple-400/5 rounded-full animate-pulse" style="animation-delay: 2s;"></div>
      <div class="absolute bottom-0 right-1/3 w-72 h-72 bg-genius-pink-400/5 rounded-full animate-pulse" style="animation-delay: 4s;"></div>
    </div>

    <div class="container mx-auto px-4 relative z-10">
      <div class="flex justify-center">
        <div class="w-full max-w-2xl">
          <!-- Form Container -->
          <div class="bg-genius-gray-800/50 backdrop-blur-sm rounded-3xl border border-genius-gray-700 shadow-genius-xl overflow-hidden">
            <!-- Form Header -->
            <div class="bg-gradient-genius-primary p-8 text-center">
              <div class="w-20 h-20 bg-genius-white/20 rounded-full flex items-center justify-center mx-auto mb-4 backdrop-blur-sm">
                <svg class="w-10 h-10 text-genius-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                </svg>
              </div>
              <h2 class="text-4xl font-bold text-genius-white mb-2">أنشئ حسابك الآن</h2>
              <p class="text-genius-blue-300 text-lg">انضم إلى منصة Genius EG وابدأ رحلتك التعليمية</p>
            </div>

            <!-- Form Body -->
            <div class="p-8">
              <form @submit.prevent="submitForm" class="space-y-6">
                <!-- Name Fields Row -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <!-- First Name -->
                  <div class="form-group">
                    <label class="block text-genius-gray-300 font-medium mb-2 text-right">الاسم الأول</label>
                    <div class="relative">
                      <input
                        v-model="form.first_name"
                        type="text"
                        placeholder="اسمك الأول بالعربي...*"
                        class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300"
                        :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/20': errors.first_name }"
                        required>
                      <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-genius-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                      </div>
                    </div>
                    <span v-if="errors.first_name" class="text-red-400 text-sm mt-1 block text-right">{{ errors.first_name }}</span>
                  </div>

                  <!-- Last Name -->
                  <div class="form-group">
                    <label class="block text-genius-gray-300 font-medium mb-2 text-right">الاسم الأخير</label>
                    <div class="relative">
                      <input
                        v-model="form.last_name"
                        type="text"
                        placeholder="اسمك الأخير بالعربي...*"
                        class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300"
                        :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/20': errors.last_name }"
                        required>
                      <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-genius-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                      </div>
                    </div>
                    <span v-if="errors.last_name" class="text-red-400 text-sm mt-1 block text-right">{{ errors.last_name }}</span>
                  </div>
                </div>

                <!-- Email Fields -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <!-- Student Email -->
                  <div class="form-group">
                    <label class="block text-genius-gray-300 font-medium mb-2 text-right">بريد الطالب الإلكتروني</label>
                    <div class="relative">
                      <input
                        v-model="form.email"
                        type="email"
                        placeholder="بريدك الإلكتروني...*"
                        class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300"
                        :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/20': errors.email }"
                        required>
                      <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-genius-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.2a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                        </svg>
                      </div>
                    </div>
                    <span v-if="errors.email" class="text-red-400 text-sm mt-1 block text-right">{{ errors.email }}</span>
                  </div>

                  <!-- Parent Email -->
                  <div class="form-group">
                    <label class="block text-genius-gray-300 font-medium mb-2 text-right">بريد ولي الأمر الإلكتروني</label>
                    <div class="relative">
                      <input
                        v-model="form.parent_email"
                        type="email"
                        placeholder="بريد ولي الأمر...*"
                        class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300"
                        :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/20': errors.parent_email }"
                        required>
                      <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-genius-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.2a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                        </svg>
                      </div>
                    </div>
                    <span v-if="errors.parent_email" class="text-red-400 text-sm mt-1 block text-right">{{ errors.parent_email }}</span>
                  </div>
                </div>

                <!-- Phone Number -->
                <div class="form-group">
                  <label class="block text-genius-gray-300 font-medium mb-2 text-right">رقم الهاتف</label>
                  <div class="relative">
                    <input
                      v-model="form.phone_number"
                      type="tel"
                      placeholder="رقم تليفونك...*"
                      class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300"
                      :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/20': errors.phone_number }"
                      required>
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-genius-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                      </svg>
                    </div>
                  </div>
                  <span v-if="errors.phone_number" class="text-red-400 text-sm mt-1 block text-right">{{ errors.phone_number }}</span>
                </div>

                <!-- Grade Level -->
                <div class="form-group">
                  <label class="block text-genius-gray-300 font-medium mb-2 text-right">الصف الدراسي</label>
                  <div class="relative">
                    <select
                      v-model="form.level_id"
                      class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300 appearance-none cursor-pointer"
                      :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/20': errors.level_id }"
                      required>
                      <option value="" disabled>اختر صفك الدراسي...*</option>
                      <option v-for="level in levels" :key="level.value" :value="level.value">
                        {{ level.label }}
                      </option>
                    </select>
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-genius-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                      </svg>
                    </div>
                  </div>
                  <span v-if="errors.level_id" class="text-red-400 text-sm mt-1 block text-right">{{ errors.level_id }}</span>
                </div>

                <!-- Password Fields -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <!-- Password -->
                  <div class="form-group">
                    <label class="block text-genius-gray-300 font-medium mb-2 text-right">كلمة المرور</label>
                    <div class="relative">
                      <input
                        v-model="form.password"
                        :type="showPassword ? 'text' : 'password'"
                        placeholder="كلمة المرور...*"
                        class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300 pr-12"
                        :class="{ 'border-red-500 focus:border-red-500 focus:ring-red-500/20': errors.password }"
                        required>
                      <button
                        type="button"
                        @click="showPassword = !showPassword"
                        class="absolute inset-y-0 right-0 pr-3 flex items-center text-genius-gray-400 hover:text-genius-gray-300">
                        <svg v-if="showPassword" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"></path>
                        </svg>
                        <svg v-else class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                        </svg>
                      </button>
                    </div>
                    <span v-if="errors.password" class="text-red-400 text-sm mt-1 block text-right">{{ errors.password }}</span>
                  </div>

                  <!-- Confirm Password -->
                  <div class="form-group">
                    <label class="block text-genius-gray-300 font-medium mb-2 text-right">تأكيد كلمة المرور</label>
                    <div class="relative">
                      <input
                        v-model="form.password_confirmation"
                        :type="showConfirmPassword ? 'text' : 'password'"
                        placeholder="تأكيد كلمة المرور...*"
                        class="w-full px-4 py-4 bg-genius-gray-700 border border-genius-gray-500 rounded-xl text-genius-white text-lg placeholder-genius-gray-400 focus:border-genius-blue-500 focus:ring-2 focus:ring-genius-blue-500/20 focus:outline-none transition-all duration-300 pr-12"
                        required>
                      <button
                        type="button"
                        @click="showConfirmPassword = !showConfirmPassword"
                        class="absolute inset-y-0 right-0 pr-3 flex items-center text-genius-gray-400 hover:text-genius-gray-300">
                        <svg v-if="showConfirmPassword" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"></path>
                        </svg>
                        <svg v-else class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                        </svg>
                      </button>
                    </div>
                  </div>
                </div>


                <!-- Submit Buttons -->
                <div class="space-y-4 pt-6">
                  <!-- Register Button -->
                  <button
                    type="submit"
                    :disabled="isSubmitting"
                    class="group relative w-full px-8 py-4 bg-gradient-genius-primary rounded-xl text-xl font-bold text-genius-white hover:shadow-genius-lg transition-all duration-300 transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed">
>
                    <span v-if="!isSubmitting" class="relative z-10 flex items-center justify-center">
                      <svg class="w-6 h-6 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                      </svg>
                      إنشاء حساب
                    </span>
                    <span v-else class="flex items-center justify-center">
                    </span>
                      <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-genius-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      جاري الإنشاء...
