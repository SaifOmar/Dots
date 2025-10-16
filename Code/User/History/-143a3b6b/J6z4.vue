<script setup>
import { ref, onMounted } from 'vue'
import { Head } from '@inertiajs/vue3'

const props = defineProps({
  quiz: {
    type: Object,
    required: true
  }
})

const timeRemaining = ref('04:59')
const progress = ref(0)
const currentQuestion = ref(null)
const isStarted = ref(false)

const startQuiz = () => {
  isStarted.value = true
  // Add your quiz start logic here
}

const submitAnswer = () => {
  // Add your answer submission logic here
}

onMounted(() => {
  // Initialize quiz data and timer
})
</script>

<template>
  <Head :title="quiz.title" />

  <main class="min-h-screen bg-gradient-genius-hero font-cairo py-8 px-4">
    <div class="max-w-4xl mx-auto">
      <!-- Quiz Container -->
      <div class="bg-genius-gray-800/80 backdrop-blur-sm rounded-2xl shadow-genius overflow-hidden">
        <!-- Quiz Header -->
        <div class="bg-gradient-genius-primary p-6 text-genius-white">
          <div class="flex justify-between items-center text-sm mb-4">
            <span>المادة: اللغة العربية</span>
            <span>الشهر: يناير</span>
          </div>
          
          <h1 class="text-2xl font-bold mb-6">{{ quiz.title }}</h1>
          
          <!-- Progress Bar -->
          <div class="h-2 bg-genius-gray-700/50 rounded-full overflow-hidden">
            <div 
              class="h-full bg-genius-blue-400 transition-all duration-300"
              :style="{ width: `${progress}%` }"
            ></div>
          </div>
        </div>

        <!-- Quiz Content -->
        <div class="p-8">
          <div v-if="!isStarted" class="text-center">
            <button
              @click="startQuiz"
              class="px-8 py-4 bg-gradient-genius-primary rounded-xl text-genius-white font-bold hover:opacity-90 transition-all duration-300 transform hover:scale-105"
            >
              ابدأ الاختبار
            </button>
          </div>

          <div v-else class="space-y-6">
            <!-- Question Display -->
            <div v-if="currentQuestion" class="bg-genius-gray-750 rounded-xl p-6">
              <h2 class="text-xl text-genius-white mb-4">
                {{ currentQuestion.text }}
              </h2>
              
              <!-- Answers -->
              <div class="space-y-3">
                <button
                  v-for="answer in currentQuestion.answers"
                  :key="answer.id"
                  class="w-full text-right px-6 py-4 rounded-xl border border-genius-gray-700 text-genius-white hover:bg-genius-gray-700/50 transition-all duration-200"
                >
                  {{ answer.text }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Quiz Footer -->
        <div class="bg-genius-gray-750 px-6 py-4 flex items-center justify-between">
          <!-- Timer -->
          <div class="text-genius-white flex items-center">
            <svg 
              class="w-5 h-5 text-genius-blue-400 mr-2" 
              fill="none" 
              stroke="currentColor" 
              viewBox="0 0 24 24"
            >
              <path 
                stroke-linecap="round" 
                stroke-linejoin="round" 
                stroke-width="2" 
                d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
            <span>الوقت المتبقي: {{ timeRemaining }}</span>
          </div>

          <!-- Submit Button -->
          <button
            v-if="isStarted"
            @click="submitAnswer"
            class="px-6 py-3 bg-gradient-genius-primary rounded-xl text-genius-white font-bold hover:opacity-90 transition-all duration-300"
          >
            إرسال الإجابة
          </button>
        </div>
      </div>
    </div>
  </main>
</template>