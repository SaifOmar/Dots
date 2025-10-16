<template>
  <div class="min-h-screen bg-gradient-genius-hero font-cairo">
    <!-- Header Section -->
    <section class="relative overflow-hidden py-24">
      <!-- Enhanced Background Elements -->
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute -top-40 -right-40 w-96 h-96 bg-genius-blue-400/8 rounded-full animate-pulse"></div>
        <div class="absolute top-1/3 -left-40 w-80 h-80 bg-genius-purple-400/8 rounded-full animate-pulse" style="animation-delay: 1.5s;"></div>
        <div class="absolute bottom-10 right-1/4 w-72 h-72 bg-genius-pink-400/8 rounded-full animate-pulse" style="animation-delay: 3s;"></div>
        
        <!-- Geometric shapes -->
        <div class="absolute top-20 right-20 w-4 h-4 bg-genius-blue-400/20 rotate-45 animate-float"></div>
        <div class="absolute bottom-32 left-16 w-6 h-6 bg-genius-purple-400/20 rounded-full animate-float" style="animation-delay: 2s;"></div>
        <div class="absolute top-1/2 right-1/3 w-3 h-3 bg-genius-pink-400/20 rotate-45 animate-float" style="animation-delay: 4s;"></div>
      </div>

      <div class="container mx-auto px-6 relative z-10">
        <div class="text-center max-w-4xl mx-auto">
          <!-- Subtitle with icon -->
          <div class="flex items-center justify-center mb-6">
            <div class="w-12 h-0.5 bg-gradient-genius-primary"></div>
            <div class="mx-4 p-3 bg-genius-white/10 backdrop-blur-sm rounded-full">
              <svg class="w-6 h-6 text-genius-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
              </svg>
            </div>
            <div class="w-12 h-0.5 bg-gradient-genius-primary"></div>
          </div>
          
          <p class="text-xl text-genius-gray-300 mb-8 font-medium leading-relaxed">
            شرح لكل المواد بشكل يسهل على الطالب المذاكرة
          </p>
          
          <h1 class="text-5xl lg:text-7xl font-bold text-genius-white mb-8 leading-tight">
            <span class="bg-gradient-genius-accent bg-clip-text text-transparent drop-shadow-lg">
              {{ currentLevelTitle }}
            </span>
          </h1>
          
          <!-- Decorative elements -->
          <div class="flex items-center justify-center space-x-4 space-x-reverse">
            <div class="w-16 h-1 bg-gradient-genius-primary rounded-full shadow-lg"></div>
            <div class="w-3 h-3 bg-genius-blue-400 rounded-full animate-pulse"></div>
            <div class="w-8 h-1 bg-gradient-genius-secondary rounded-full shadow-lg"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- Courses Section -->
    <section class="relative py-20 bg-genius-gray-900/30 backdrop-blur-sm">
      <!-- Subtle grid pattern -->
      <div class="absolute inset-0 opacity-5">
        <div class="absolute inset-0" style="background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.15) 1px, transparent 0); background-size: 20px 20px;"></div>
      </div>
      
      <div class="container mx-auto px-6 relative z-10">
        <!-- Enhanced Section Header -->
        <div class="text-center mb-20">
          <div class="inline-flex items-center px-6 py-3 bg-genius-gray-800/50 backdrop-blur-sm border border-genius-gray-700 rounded-full mb-8">
            <div class="w-2 h-2 bg-genius-green-400 rounded-full animate-pulse mr-3"></div>
            <span class="text-genius-gray-400 font-medium">جميع المواد الدراسية</span>
          </div>
          
          <h2 class="text-4xl lg:text-6xl font-bold mb-6 leading-tight">
            <span class="bg-gradient-genius-secondary bg-clip-text text-transparent">
              المقررات المتاحة
            </span>
          </h2>
          
          <p class="text-genius-gray-400 text-lg max-w-2xl mx-auto leading-relaxed">
            اختر المادة التي تريد دراستها واستمتع بشرح مبسط وتفاعلي
          </p>
        </div>

        <!-- Enhanced Courses Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8 mb-20">
          <div v-for="(course, index) in courses" :key="course.id" 
               class="group relative cursor-pointer transform hover:scale-105 transition-all duration-500"
               @click="navigateToCourse(course)">
            
            <!-- Course Card with enhanced design -->
            <div class="relative bg-gradient-to-br from-genius-gray-800/90 to-genius-gray-900/90 backdrop-blur-sm rounded-3xl overflow-hidden border border-genius-gray-700/50 hover:border-genius-blue-500/50 transition-all duration-500 shadow-genius hover:shadow-genius-xl">
              
              <!-- Glow effect -->
              <div class="absolute inset-0 bg-gradient-to-r from-genius-blue-500/5 via-genius-purple-500/5 to-genius-pink-500/5 opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
              
              <!-- Course Image with enhanced overlay -->
              <div class="relative h-56 overflow-hidden">
                <!-- Background pattern -->
                <div class="absolute inset-0 bg-gradient-to-br from-genius-blue-500/20 via-genius-purple-500/20 to-genius-pink-500/20">
                  <div class="absolute inset-0" style="background-image: radial-gradient(circle at 2px 2px, rgba(255,255,255,0.1) 1px, transparent 0); background-size: 30px 30px;"></div>
                </div>
                
                <!-- Course icon/illustration -->
                <div class="absolute inset-0 flex items-center justify-center">
                  <div class="relative">
                    <!-- Main icon circle -->
                    <div class="w-20 h-20 bg-gradient-genius-primary rounded-full flex items-center justify-center shadow-genius-lg group-hover:scale-110 transition-transform duration-300">
                      <svg class="w-10 h-10 text-genius-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                      </svg>
                    </div>
                    
                    <!-- Floating elements -->
                    <div class="absolute -top-2 -right-2 w-4 h-4 bg-genius-yellow-400 rounded-full animate-bounce opacity-80"></div>
                    <div class="absolute -bottom-1 -left-1 w-3 h-3 bg-genius-green-400 rounded-full animate-pulse opacity-70"></div>
                  </div>
                </div>
                
                <!-- Enhanced lesson count badge -->
                <div class="absolute top-4 right-4">
                  <div class="bg-genius-black/60 backdrop-blur-sm px-4 py-2 rounded-2xl border border-genius-gray-600/50">
                    <div class="text-center">
                      <div class="text-genius-blue-400 text-xs font-medium leading-tight">عدد الدروس</div>
                      <div class="text-genius-white text-xl font-bold">{{ course.lessons_count || 0 }}</div>
                    </div>
                  </div>
                </div>

                <!-- Status indicator -->
                <div class="absolute top-4 left-4">
                  <div class="flex items-center space-x-2 space-x-reverse">
                    <div class="w-2 h-2 bg-genius-green-400 rounded-full animate-pulse"></div>
                    <span class="text-genius-green-400 text-xs font-medium bg-genius-black/60 backdrop-blur-sm px-2 py-1 rounded-full">متاح</span>
                  </div>
                </div>

                <!-- Play button overlay -->
                <div class="absolute inset-0 bg-genius-black/40 opacity-0 group-hover:opacity-100 transition-all duration-300 flex items-center justify-center backdrop-blur-sm">
                  <div class="w-16 h-16 bg-genius-white/20 backdrop-blur-sm rounded-full flex items-center justify-center transform scale-75 group-hover:scale-100 transition-transform duration-300 border border-genius-white/30">
                    <svg class="w-8 h-8 text-genius-white mr-1" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M8 5v14l11-7z"/>
                    </svg>
                  </div>
                </div>
              </div>

              <!-- Enhanced Course Content -->
              <div class="p-6 relative">
                <!-- Header with logo -->
                <div class="flex items-start justify-between mb-4">
                  <div class="flex items-center flex-1 min-w-0">
                    <div class="w-12 h-12 bg-gradient-genius-primary rounded-2xl flex items-center justify-center mr-4 flex-shrink-0 shadow-lg">
                      <span class="text-genius-white font-bold text-lg">G</span>
                    </div>
                    <div class="min-w-0 flex-1">
                      <h3 class="text-xl font-bold text-genius-white group-hover:text-genius-blue-400 transition-colors duration-300 mb-1 leading-tight">
                        {{ course.title }}
                      </h3>
                      <p class="text-genius-gray-400 text-sm font-medium">{{ course.level_name }}</p>
                    </div>
                  </div>
                  
                  <!-- Arrow with enhanced design -->
                  <div class="w-10 h-10 bg-genius-gray-700/50 group-hover:bg-genius-blue-500 rounded-xl flex items-center justify-center transition-all duration-300 ml-4">
                    <svg class="w-5 h-5 text-genius-gray-400 group-hover:text-genius-white transition-colors duration-300 transform group-hover:translate-x-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                    </svg>
                  </div>
                </div>

                <!-- Academic year with enhanced styling -->
                <div class="flex items-center justify-between mb-4">
                  <div class="flex items-center bg-genius-gray-700/30 px-3 py-2 rounded-xl">
                    <svg class="w-4 h-4 text-genius-blue-400 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                    <span class="text-genius-gray-300 font-semibold text-sm">
                      {{ course.academic_year }}
                    </span>
                  </div>
                  
                  <div class="text-genius-gray-400 text-xs">
                    انقر للعرض
                  </div>
                </div>

                <!-- Enhanced Progress Bar -->
                <div v-if="course.progress !== undefined" class="mt-4">
                  <div class="flex justify-between items-center mb-2">
                    <span class="text-genius-gray-400 text-sm font-medium">التقدم</span>
                    <span class="text-genius-blue-400 text-sm font-bold">{{ course.progress }}%</span>
                  </div>
                  <div class="w-full bg-genius-gray-700/50 rounded-full h-2 overflow-hidden">
                    <div class="bg-gradient-genius-primary h-full rounded-full transition-all duration-700 shadow-lg relative" 
                         :style="`width: ${course.progress}%`">
                      <div class="absolute inset-0 bg-gradient-to-r from-transparent via-genius-white/30 to-transparent animate-pulse"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Enhanced Pagination -->
        <div v-if="showPagination" class="flex flex-col sm:flex-row justify-center items-center space-y-4 sm:space-y-0 sm:space-x-6 sm:space-x-reverse">
          <!-- Previous button -->
          <button 
            @click="previousPage" 
            :disabled="currentPage === 1"
            class="group flex items-center px-6 py-3 bg-genius-gray-800/80 backdrop-blur-sm border border-genius-gray-600/50 rounded-2xl text-genius-white hover:border-genius-blue-500/50 hover:bg-genius-blue-500/10 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg">
            <svg class="w-5 h-5 ml-2 group-hover:translate-x-0.5 transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
            <span class="font-medium">السابق</span>
          </button>

          <!-- Page numbers -->
          <div class="flex items-center space-x-2 space-x-reverse bg-genius-gray-800/50 backdrop-blur-sm rounded-2xl p-2 border border-genius-gray-700/50">
            <button v-for="page in visiblePages" :key="page"
                    @click="goToPage(page)"
                    :class="[
                      'w-12 h-12 rounded-xl font-bold text-sm transition-all duration-300 relative overflow-hidden',
                      page === currentPage 
                        ? 'bg-gradient-genius-primary text-genius-white shadow-lg transform scale-105' 
                        : 'text-genius-gray-300 hover:bg-genius-gray-700/50 hover:text-genius-white'
                    ]">
              {{ page }}
              <div v-if="page === currentPage" class="absolute inset-0 bg-gradient-to-r from-transparent via-genius-white/20 to-transparent animate-pulse"></div>
            </button>
          </div>

          <!-- Next button -->
          <button 
            @click="nextPage" 
            :disabled="currentPage === totalPages"
            class="group flex items-center px-6 py-3 bg-genius-gray-800/80 backdrop-blur-sm border border-genius-gray-600/50 rounded-2xl text-genius-white hover:border-genius-blue-500/50 hover:bg-genius-blue-500/10 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg">
            <span class="font-medium">التالي</span>
            <svg class="w-5 h-5 mr-2 rotate-180 group-hover:-translate-x-0.5 transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
          </button>
        </div>
      </div>
    </section>

    <!-- Enhanced Footer -->
    <footer class="bg-genius-black border-t border-genius-gray-800/50 py-12">
      <div class="container mx-auto px-6">
        <div class="text-center">
          <!-- Logo section -->
          <div class="mb-8">
            <div class="w-16 h-16 bg-gradient-genius-primary rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-genius-lg">
              <span class="text-genius-white font-bold text-2xl">G</span>
            </div>
            <h3 class="text-genius-white font-bold text-xl mb-2">Genius EG</h3>
            <p class="text-genius-gray-400">منصة تعليمية متطورة</p>
          </div>
          
          <!-- Copyright -->
          <div class="pt-8 border-t border-genius-gray-800/50">
            <p class="text-genius-gray-400 leading-relaxed">
              Copyright © 
              <a href="https://www.facebook.com/profile.php?id=100090024653201&mibextid=ZbWKwL" 
                 target="_blank" 
                 class="text-genius-blue-400 hover:text-genius-blue-300 transition-colors font-medium">
                NSP Team 2024
              </a>
              . All Rights Reserved
            </p>
          </div>
        </div>
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
const courses = ref([
  {
    id: 1,
    title: 'اللغة العربية',
    level_name: 'الصف الرابع الابتدائي',
    lessons_count: 24,
    academic_year: '2024-2025',
    progress: 65,
    slug: 'arabic-4th-grade'
  },
  {
    id: 2,
    title: 'الرياضيات',
    level_name: 'الصف الرابع الابتدائي',
    lessons_count: 18,
    academic_year: '2024-2025',
    progress: 40,
    slug: 'math-4th-grade'
  },
  {
    id: 3,
    title: 'العلوم',
    level_name: 'الصف الرابع الابتدائي', 
    lessons_count: 16,
    academic_year: '2024-2025',
    progress: 80,
    slug: 'science-4th-grade'
  },
  {
    id: 4,
    title: 'اللغة الإنجليزية',
    level_name: 'الصف الرابع الابتدائي',
    lessons_count: 20,
    academic_year: '2024-2025',
    progress: 25,
    slug: 'english-4th-grade'
  },
  {
    id: 5,
    title: 'الدراسات الاجتماعية',
    level_name: 'الصف الرابع الابتدائي',
    lessons_count: 14,
    academic_year: '2024-2025',
    progress: 90,
    slug: 'social-studies-4th-grade'
  },
  {
    id: 6,
    title: 'التربية الدينية',
    level_name: 'الصف الرابع الابتدائي',
    lessons_count: 12,
    academic_year: '2024-2025',
    progress: 55,
    slug: 'religion-4th-grade'
  }
])

const currentPage = ref(1)
const totalPages = ref(2)

// Computed properties
const currentLevelTitle = computed(() => {
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
  const levelSlug = props.level?.slug || 'all-levels'
  window.location.href = `/courses/${levelSlug}/${course.slug}`
}

const previousPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

const goToPage = (page) => {
  currentPage.value = page
}

// Lifecycle
onMounted(() => {
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
/* Enhanced animations */
@keyframes float {
  0%, 100% { 
    transform: translateY(0px) rotate(0deg); 
  }
  50% { 
    transform: translateY(-10px) rotate(5deg); 
  }
}

.animate-float {
  animation: float 6s ease-in-out infinite;
}

/* Course card hover effects */
.group:hover {
  transform: translateY(-8px) scale(1.02);
}

/* Glassmorphism effect */
.backdrop-blur-sm {
  backdrop-filter: blur(8px);
}

/* Custom gradient text */
.bg-gradient-genius-accent {
  background: linear-gradient(135deg, #60a5fa, #a78bfa, #f472b6);
}

.bg-gradient-genius-secondary {
  background: linear-gradient(135deg, #60a5fa, #a78bfa);
}

/* Enhanced shadows */
.shadow-genius {
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

.shadow-genius-lg {
  box-shadow: 0 20px 40px -12px rgba(59, 130, 246, 0.25), 0 8px 16px -4px rgba(139, 92, 246, 0.15);
}

.shadow-genius-xl {
  box-shadow: 0 25px 50px -12px rgba(59, 130, 246, 0.4), 0 12px 24px -6px rgba(139, 92, 246, 0.25);
}

/* Smooth transitions for all elements */
* {
  transition-property: all;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 300ms;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #111827;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(45deg, #3b82f6, #8b5cf6);
  border-radius: 6px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(45deg, #2563eb, #7c3aed);
}
</style>