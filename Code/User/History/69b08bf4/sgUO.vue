<template>
  <div class="min-h-screen bg-gradient-genius-hero font-cairo">
    <!-- Header Section -->
    <section class="bg-gradient-to-br from-genius-gray-900/90 via-genius-purple-900/80 to-genius-blue-600/90 relative overflow-hidden py-20">
      <!-- Animated Background Elements -->
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute -top-20 -right-20 w-80 h-80 bg-genius-blue-400/10 rounded-full animate-pulse"></div>
        <div class="absolute top-1/2 -left-32 w-72 h-72 bg-genius-purple-400/10 rounded-full animate-pulse" style="animation-delay: 1s;"></div>
u        <div class="absolute bottom-0 right-1/4 w-64 h-64 bg-genius-pink-400/10 rounded-full animate-pulse" style="animation-delay: 2s;"></div>
      </div>

      <div class="container mx-auto px-4 relative z-10">
        <div class="text-center">
          <h6 class="text-xl text-genius-gray-300 mb-4 font-medium">
            شرح لكل المواد بشكل يسهل على الطالب المذاكرة
          </h6>
          <h2 class="text-4xl lg:text-6xl font-bold text-genius-white mb-8">
            <span class="bg-gradient-genius-accent bg-clip-text text-transparent">
              {{ currentLevelTitle }}
            </span>
          </h2>
          <div class="w-24 h-1 bg-gradient-genius-primary mx-auto rounded-full"></div>
        </div>
      </div>
    </section>

    <!-- Courses Section -->
    <section class="py-20 relative">
      <!-- Background Pattern -->
      <div class="absolute inset-0 bg-genius-gray-900/50"></div>

      <div class="container mx-auto px-4 relative z-10">
        <!-- Section Header -->
        <div class="text-center mb-16">
          <h2 class="text-4xl lg:text-5xl font-bold text-genius-white mb-6">
            <span class="bg-gradient-genius-secondary bg-clip-text text-transparent">
              جميع الصفوف الدراسية
            </span>
          </h2>
          <div class="w-16 h-1 bg-gradient-genius-primary mx-auto rounded-full"></div>
        </div>

        {{ courses }}
        <!-- Courses Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-16">
          <div v-for="course in courses" :key="course.id"
               class="group relative cursor-pointer"
               @click="navigateToCourse(course)">

            <!-- Course Card -->
            <div class="bg-genius-gray-800/80 backdrop-blur-sm rounded-2xl overflow-hidden border border-genius-gray-700 hover:border-genius-blue-500 transition-all duration-500 transform hover:scale-105 hover:shadow-genius-xl">

              <!-- Course Image -->
              <div class="relative h-64 bg-gradient-to-br from-genius-gray-700 to-genius-gray-800 overflow-hidden">
                <!-- Image placeholder -->
                <div v-if="course.image" class="absolute inset-0">
                  <img :src="course.image" :alt="course.title"
                       class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                </div>
                <div v-else class="absolute inset-0 bg-gradient-to-br from-genius-blue-500/30 to-genius-purple-500/30 flex items-center justify-center">
                  <div class="text-center">
                    <div class="w-16 h-16 bg-gradient-genius-primary rounded-full flex items-center justify-center mx-auto mb-4">
                      <svg class="w-8 h-8 text-genius-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                      </svg>
                    </div>
                    <div class="text-genius-white font-semibold">{{ course.title }}</div>
                  </div>
                </div>

                <!-- Lesson Count Badge -->
                <div class="absolute top-4 right-4">
                  <div class="bg-gradient-genius-primary px-4 py-2 rounded-full backdrop-blur-sm shadow-lg">
                    <div class="text-center">
                      <div class="text-genius-white text-xs font-medium">عدد الدروس</div>
                      <div class="text-genius-white text-lg font-bold">{{ course.lessons_count || 0 }}</div>
                    </div>
                  </div>
                </div>

                <!-- Hover Overlay -->
                <div class="absolute inset-0 bg-gradient-to-t from-genius-gray-900/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                  <div class="bg-genius-white/20 backdrop-blur-sm rounded-full p-4">
                    <svg class="w-8 h-8 text-genius-white" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M8 5v14l11-7z"/>
                    </svg>
                  </div>
                </div>
              </div>

              <!-- Course Content -->
              <div class="p-6">
                <!-- Logo and Course Info -->
                <div class="flex items-center mb-4">
                  <div class="w-12 h-12 bg-gradient-genius-primary rounded-full flex items-center justify-center mr-3 flex-shrink-0">
                    <span class="text-genius-white font-bold text-lg">G</span>
                  </div>
                  <div class="min-w-0 flex-1">
                    <h4 class="text-xl font-bold text-genius-white group-hover:text-genius-blue-400 transition-colors duration-300 truncate">
                      {{ course.title }}
                    </h4>
                    <p class="text-genius-gray-400 text-sm">{{ course.level_name }}</p>
                  </div>
                </div>

                <!-- Academic Year -->
                <div class="flex items-center justify-between">
                  <div class="flex items-center">
                    <svg class="w-5 h-5 text-genius-gray-400 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                    <span class="text-genius-gray-300 font-semibold">
                      {{ course.academic_year }}
                    </span>
                  </div>

                  <!-- Arrow Icon -->
                  <div class="w-8 h-8 bg-genius-gray-700 group-hover:bg-genius-blue-500 rounded-full flex items-center justify-center transition-colors duration-300">
                    <svg class="w-4 h-4 text-genius-gray-400 group-hover:text-genius-white transition-colors duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                    </svg>
                  </div>
                </div>
              </div>

              <!-- Progress Bar (if applicable) -->
              <div v-if="course.progress !== undefined" class="px-6 pb-4">
                <div class="w-full bg-genius-gray-700 rounded-full h-2">
                  <div class="bg-gradient-genius-primary h-2 rounded-full transition-all duration-500"
                       :style="`width: ${course.progress}%`"></div>
                </div>
                <div class="text-right mt-2">
                  <span class="text-genius-gray-400 text-sm">{{ course.progress }}% مكتمل</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Pagination -->
        <div v-if="showPagination" class="flex justify-center items-center space-x-4 space-x-reverse">
          <button
            @click="previousPage"
            :disabled="currentPage === 1"
            class="px-6 py-3 bg-genius-gray-800 border border-genius-gray-600 rounded-xl text-genius-white hover:border-genius-blue-500 hover:bg-genius-blue-500/20 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
          </button>

          <div class="flex space-x-2 space-x-reverse">
            <button v-for="page in visiblePages" :key="page"
                    @click="goToPage(page)"
                    :class="[
                      'px-4 py-2 rounded-lg transition-all duration-300',
                      page === currentPage
                        ? 'bg-gradient-genius-primary text-genius-white shadow-lg'
                        : 'bg-genius-gray-800 text-genius-gray-300 hover:bg-genius-gray-700 hover:text-genius-white'
                    ]">
              {{ page }}
            </button>
          </div>

          <button
            @click="nextPage"
            :disabled="currentPage === totalPages"
            class="px-6 py-3 bg-genius-gray-800 border border-genius-gray-600 rounded-xl text-genius-white hover:border-genius-blue-500 hover:bg-genius-blue-500/20 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
            <svg class="w-5 h-5 rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
          </button>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-genius-black py-8">
      <div class="container mx-auto px-4 text-center">
        <p class="text-genius-gray-400">
          Copyright ©
          <a href="https://www.facebook.com/profile.php?id=100090024653201&mibextid=ZbWKwL"
             target="_blank"
             class="text-genius-blue-400 hover:text-genius-blue-300 transition-colors">
            NSP Team 2024
          </a>
          . All Rights Reserved
        </p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

// Props (would come from your Laravel backend)
const props = defineProps({
  level: Object,
  courses: Array,
  currentPage: { type: Number, default: 1 },
  totalPages: { type: Number, default: 1 },
  showPagination: { type: Boolean, default: true }
})

// Reactive data

const currentPage = ref(1)
const totalPages = ref(2)

// Computed properties
const currentLevelTitle = computed(() => {
  // This would come from your Laravel props
  return props.level?.title || 'جميع الصفوف الدراسية'
})

const visiblePages = computed(() => {
  const pages = []
  const start = Math.max(1, currentPage.value - 2)
  const end = Math.min(totalPages.value, start + 4)

  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  return pages
})

// Methods
const navigateToCourse = (course) => {
  // This would integrate with your Laravel routing
  const levelSlug = props.level?.slug || 'all-levels'
  window.location.href = `/courses/${levelSlug}/${course.slug}`
}

const previousPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
    // Make API call to get previous page data
    // window.location.href = `?page=${currentPage.value}`
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
    // Make API call to get next page data
    // window.location.href = `?page=${currentPage.value}`
  }
}

const goToPage = (page) => {
  currentPage.value = page
  // Make API call to get specific page data
  // window.location.href = `?page=${page}`
}

// Lifecycle
onMounted(() => {
  // Initialize any data from Laravel props
  if (props.courses) {
    courses.value = props.courses
  }
  if (props.currentPage) {
    currentPage.value = props.currentPage
  }
  if (props.totalPages) {
    totalPages.value = props.totalPages
  }
})
</script>

<style scoped>
/* Custom animations for course cards */
@keyframes cardFloat {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

.group:hover {
  animation: cardFloat 2s ease-in-out infinite;
}

/* Smooth transitions */
* {
  transition-property: transform, opacity, border-color, background-color, color;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: theme('colors.genius-gray.900');
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(45deg, theme('colors.genius-blue.500'), theme('colors.genius-purple.500'));
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(45deg, theme('colors.genius-blue.600'), theme('colors.genius-purple.600'));
}
</style>
