<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { Head, router } from '@inertiajs/vue3'

const props = defineProps({
  quiz: {
    type: Object,
    required: true
  }
})

// Quiz state
const timeRemaining = ref(props.quiz.duration * 60) // Duration in seconds
const progress = ref(0)
const currentQuestionIndex = ref(0)
const selectedAnswer = ref(null)
const isStarted = ref(false)
const isFinished = ref(false)
const userAnswers = ref([])

// Computed properties
const currentQuestion = computed(() => {
  if (!isStarted.value || !props.quiz.questions) return null
  return props.quiz.questions[currentQuestionIndex.value]
})

const formattedTime = computed(() => {
  const minutes = Math.floor(timeRemaining.value / 60)
  const seconds = timeRemaining.value % 60
  return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
})

const progressPercentage = computed(() => {
  if (!props.quiz.questions) return 0
  return (currentQuestionIndex.value / props.quiz.questions.length) * 100
})

// Methods
const startQuiz = () => {
  isStarted.value = true
  startTimer()
}

const startTimer = () => {
  const timer = setInterval(() => {
    if (timeRemaining.value > 0) {
      timeRemaining.value--
    } else {
      clearInterval(timer)
      finishQuiz()
    }
  }, 1000)
}

const selectAnswer = (answer) => {
  selectedAnswer.value = answer
}

const submitAnswer = () => {
  if (!selectedAnswer.value) return

  userAnswers.value.push({
    questionId: currentQuestion.value.id,
    answerId: selectedAnswer.value.id
  })

  if (currentQuestionIndex.value < props.quiz.questions.length - 1) {
    currentQuestionIndex.value++
    selectedAnswer.value = null
  } else {
    finishQuiz()
  }

  progress.value = progressPercentage.value
}

const finishQuiz = () => {
  isFinished.value = true
  
  router.post(route('quiz.submit', props.quiz.id), {
    answers: userAnswers.value,
    time_taken: props.quiz.duration * 60 - timeRemaining.value
  }, {
    onSuccess: () => {
      router.visit(route('quiz.result', props.quiz.id))
    }
  })
}

// Prevent leaving the page accidentally
onMounted(() => {
  window.addEventListener('beforeunload', (e) => {
    if (isStarted.value && !isFinished.value) {
      e.preventDefault()
      e.returnValue = ''
    }
  })
})

// Watch for quiz completion
watch(isFinished, (newValue) => {
  if (newValue) {
    window.removeEventListener('beforeunload', () => {})
  }
})
</script>

<template>
  <Head :title="quiz.title" />

  <main class="min-h-screen bg-gradient-genius-hero font-cairo py-28 px-4">
    <div class="max-w-4xl mx-auto">
      <div class="bg-genius-gray-800/80 backdrop-blur-sm rounded-2xl shadow-genius overflow-hidden">
        <!-- Quiz Header -->
        <div class="bg-gradient-genius-primary p-6 text-genius-white">
          <div class="flex justify-between items-center text-sm mb-4">
            <span>المادة: {{ quiz.subject }}</span>
            <span>عدد الأسئلة: {{ quiz.questions?.length }}</span>
          </div>

          <h1 class="text-2xl font-bold mb-6">{{ quiz.title }}</h1>

          <div class="h-2 bg-genius-gray-700/50 rounded-full overflow-hidden">
            <div
              class="h-full bg-genius-blue-400 transition-all duration-300"
              :style="{ width: `${progress}%` }"
            ></div>
          </div>
        </div>

        <!-- Quiz Content -->
        <div class="p-8">
          <div v-if="!isStarted" class="text-center space-y-6">
            <div class="bg-genius-gray-750/50 rounded-xl p-6 text-genius-white">
              <h3 class="text-xl font-bold mb-4">تعليمات الاختبار</h3>
              <ul class="text-genius-gray-300 text-right space-y-2">
                <li>• مدة الاختبار: {{ quiz.duration }} دقيقة</li>
                <li>• عدد الأسئلة: {{ quiz.questions?.length }} سؤال</li>
                <li>• يجب الإجابة على جميع الأسئلة</li>
                <li>• لا يمكن العودة للسؤال السابق</li>
              </ul>
            </div>
            
            <button
              @click="startQuiz"
              class="px-8 py-4 bg-gradient-genius-primary rounded-xl text-genius-white font-bold hover:opacity-90 transition-all duration-300 transform hover:scale-105"
            >
              ابدأ الاختبار
            </button>
          </div>

          <div v-else-if="currentQuestion" class="space-y-6">
            <div class="bg-genius-gray-750 rounded-xl p-6">
              <h2 class="text-xl text-genius-white mb-4">
                {{ currentQuestion.text }}
              </h2>

              <div class="space-y-3">
                <button
                  v-for="answer in currentQuestion.answers"
                  :key="answer.id"
                  @click="selectAnswer(answer)"
                  :class="[
                    'w-full text-right px-6 py-4 rounded-xl border transition-all duration-200',
                    selectedAnswer?.id === answer.id
                      ? 'border-genius-blue-400 bg-genius-blue-400/10 text-genius-blue-400'
                      : 'border-genius-gray-700 text-genius-white hover:bg-genius-gray-700/50'
                  ]"
                >
                  {{ answer.text }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Quiz Footer -->
        <div class="bg-genius-gray-750 px-6 py-4 flex items-center justify-between">
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
            <span>الوقت المتبقي: {{ formattedTime }}</span>
          </div>

          <button
            v-if="isStarted && !isFinished"
            @click="submitAnswer"
            :disabled="!selectedAnswer"
            class="px-6 py-3 bg-gradient-genius-primary rounded-xl text-genius-white font-bold disabled:opacity-50 hover:opacity-90 transition-all duration-300"
          >
            {{ currentQuestionIndex === quiz.questions.length - 1 ? 'إنهاء الاختبار' : 'السؤال التالي' }}
          </button>
        </div>
      </div>
    </div>
  </main>
</template>
