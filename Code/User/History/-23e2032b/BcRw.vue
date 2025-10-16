<script setup>
const subscriptions = [
  {
    id: 1,
    name: 'الباقة الذهبية',
    status: 'active',
    startDate: '2025-08-01',
    endDate: '2025-09-01',
    price: '199',
    features: ['جميع الكورسات', 'دعم فني 24/7', 'شهادات معتمدة']
  }
];
</script>

<template>
  <div class="space-y-6">
    <h2 class="text-2xl font-bold text-white mb-6">الاشتراكات</h2>
    
    <div class="grid grid-cols-1 gap-6">
      <div 
        v-for="sub in subscriptions" 
        :key="sub.id"
        class="bg-genius-gray-700/30 rounded-2xl p-6 border border-genius-gray-600"
      >
        <div class="flex items-center justify-between mb-4">
          <div>
            <h3 class="text-xl font-bold text-white">{{ sub.name }}</h3>
            <span 
              class="inline-block px-3 py-1 rounded-full text-sm mt-2"
              :class="sub.status === 'active' ? 'bg-genius-green-500/20 text-genius-green-400' : 'bg-genius-red-500/20 text-genius-red-400'"
            >
              {{ sub.status === 'active' ? 'نشط' : 'منتهي' }}
            </span>
          </div>
          <div class="text-right">
            <p class="text-gray-400 text-sm">تاريخ الانتهاء</p>
            <p class="text-white font-medium">{{ sub.endDate }}</p>
          </div>
        </div>

        <div class="grid grid-cols-3 gap-4 mb-6">
          <div 
            v-for="feature in sub.features" 
            :key="feature"
            class="flex items-center text-gray-300"
          >
            <svg class="w-5 h-5 text-genius-green-400 ml-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
            </svg>
            {{ feature }}
          </div>
        </div>

        <div class="flex justify-between items-center pt-4 border-t border-genius-gray-600">
          <span class="text-2xl font-bold text-white">{{ sub.price }} ج.م</span>
          <button class="px-6 py-2 bg-genius-blue-500 hover:bg-genius-blue-600 text-white rounded-xl transition-colors">
            تجديد الاشتراك
          </button>
        </div>
      </div>
    </div>
  </div>
</template>