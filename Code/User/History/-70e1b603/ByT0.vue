<script setup>
import { ref } from 'vue';

const paymentMethods = ref([
  {
    id: 1,
    type: 'visa',
    last4: '4242',
    expiry: '12/25',
    isDefault: true
  }
]);

const showNewCardForm = ref(false);

const form = ref({
  cardNumber: '',
  expiry: '',
  cvc: '',
  name: ''
});

const addNewCard = () => {
  // Implement card addition logic
  showNewCardForm.value = false;
};

const removeCard = (id) => {
  // Implement card removal logic
};

const setDefault = (id) => {
  // Implement set default logic
};
</script>

<template>
  <div class="space-y-6">
    <h2 class="text-2xl font-bold text-white mb-6">طرق الدفع</h2>
    
    <div class="grid grid-cols-1 gap-4">
      <div 
        v-for="method in paymentMethods" 
        :key="method.id"
        class="bg-genius-gray-700/30 rounded-2xl p-6 border border-genius-gray-600"
      >
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <!-- Add card type icon here -->
            <div class="mr-4">
              <p class="text-white font-medium">•••• •••• •••• {{ method.last4 }}</p>
              <p class="text-gray-400 text-sm">تنتهي في {{ method.expiry }}</p>
            </div>
          </div>
          
          <div class="flex items-center gap-4">
            <button 
              v-if="!method.isDefault"
              @click="setDefault(method.id)"
              class="text-genius-blue-400 hover:text-genius-blue-300 text-sm"
            >
              تعيين كافتراضي
            </button>
            <button 
              @click="removeCard(method.id)"
              class="text-genius-red-400 hover:text-genius-red-300"
            >
              حذف
            </button>
          </div>
        </div>
      </div>
    </div>

    <button
      v-if="!showNewCardForm"
      @click="showNewCardForm = true"
      class="px-6 py-3 bg-genius-gray-700 text-white rounded-xl hover:bg-genius-gray-600 transition-colors"
    >
      إضافة بطاقة جديدة
    </button>

    <form 
      v-else 
      @submit.prevent="addNewCard"
      class="bg-genius-gray-700/30 rounded-2xl p-6 border border-genius-gray-600 space-y-4"
    >
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div class="space-y-2">
          <label class="block text-gray-300">رقم البطاقة</label>
          <input
            v-model="form.cardNumber"
            type="text"
            class="w-full px-4 py-3 bg-genius-gray-700/50 border border-genius-gray-600 rounded-xl text-white"
          />
        </div>
        <!-- Add more form fields -->
      </div>

      <div class="flex justify-end gap-4">
        <button
          type="button"
          @click="showNewCardForm = false"
          class="px-6 py-3 bg-genius-gray-700 text-white rounded-xl hover:bg-genius-gray-600"
        >
          إلغاء
        </button>
        <button
          type="submit"
          class="px-6 py-3 bg-gradient-to-r from-genius-blue-500 to-genius-purple-500 text-white rounded-xl hover:from-genius-blue-600 hover:to-genius-purple-600"
        >
          إضافة البطاقة
        </button>
      </div>
    </form>
  </div>
</template>