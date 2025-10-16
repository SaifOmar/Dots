<script setup>
import { Head, Link } from '@inertiajs/vue3'
import { ref, computed } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps({
  course: {
    type: Object,
    required: true
  },
  level: {
    type: Object,
    required: true
  },
  lessons: {
    type: Array,
    required: true
  }
})

const activeSection = ref(null)

const toggleSection = (sectionId) => {
  activeSection.value = activeSection.value === sectionId ? null : sectionId
}

const groupedLessons = computed(() => {
  return props.lessons.reduce((acc, lesson) => {
    if (!acc[lesson.section_id]) {
      acc[lesson.section_id] = []
    }
    acc[lesson.section_id].push(lesson)
    return acc
  }, {})
})

const redirectToPayment = () => {
  router.get(route('payment.show', { course: props.course.id }))
}
</script>

<template>
  <Head :title="course.title" />

  <div class="min-h-screen bg-genius-gray-900">
    <!-- Course Hero Section -->
    <section class="relative py-16 overflow-hidden">
      <div class="absolute inset-0 bg-gradient-genius-primary opacity-10"></div>
      <div class="container mx-auto px-4 relative z-10">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <!-- Course Info -->
          <div>
            <div class="flex items-center gap-2 text-genius-gray-400 mb-4">
              <Link :href="route('courses.index')" class="hover:text-genius-blue-400">
                الدورات
              </Link>
              <span>/</span>
              <span>{{ level.name }}</span>
            </div>
            
            <h1 class="text-4xl font-bold text-genius-white mb-6">
              {{ course.title }}
            </h1>
            
            <p class="text-genius-gray-300 text-lg mb-8">
              {{ course.description }}
            </p>

            <div class="flex flex-wrap gap-4 mb-8">
              <div class="bg-genius-gray-800/50 px-4 py-2 rounded-lg">
                <span class="text-genius-gray-400">عدد الدروس:</span>
                <span class="text-genius-white mr-2">{{ lessons.length }}</span>
              </div>
              <div class="bg-genius-gray-800/50 px-4 py-2 rounded-lg">
                <span class="text-genius-gray-400">المستوى:</span>
                <span class="text-genius-white mr-2">{{ level.name }}</span>
              </div>
            </div>

            <button 
              @click="redirectToPayment"
              class="bg-gradient-genius-primary text-genius-white px-8 py-4 rounded-xl font-bold hover:opacity-90 transition-opacity"
            >
              اشترك الآن
            </button>
          </div>

          <!-- Course Thumbnail -->
          <div class="relative">
            <img 
              :src="course.thumb" 
              :alt="course.title"
              class="w-full rounded-2xl shadow-genius"
            >
            <div class="absolute inset-0 bg-gradient-genius-primary opacity-10 rounded-2xl"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- Course Content -->
    <section class="py-16">
      <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-genius-white mb-8">
          محتوى الدورة
        </h2>

        <div class="bg-genius-gray-800 rounded-2xl overflow-hidden">
          <div v-for="(sectionLessons, sectionId) in groupedLessons" :key="sectionId" class="border-b border-genius-gray-700 last:border-0">
            <button 
              @click="toggleSection(sectionId)"
              class="w-full px-6 py-4 flex items-center justify-between text-genius-white hover:bg-genius-gray-750 transition-colors"
            >
              <span class="font-bold">{{ sectionLessons[0].section.title }}</span>
              <svg 
                class="w-5 h-5 transition-transform" 
                :class="{ 'rotate-180': activeSection === sectionId }"
                fill="none" 
                stroke="currentColor" 
                viewBox="0 0 24 24"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </button>

            <div v-show="activeSection === sectionId" class="bg-genius-gray-750/50">
              <div v-for="lesson in sectionLessons" :key="lesson.id" 
                   class="px-6 py-4 border-t border-genius-gray-700 flex items-center gap-4">
                <!-- Free Lesson -->
                <template v-if="lesson.is_free">
                  <Link 
                    :href="route('lessons.show', lesson.id)"
                    class="flex-1 flex items-center gap-4 text-genius-white hover:text-genius-blue-400 transition-colors"
                  >
                    <span class="w-8 h-8 rounded-full bg-genius-blue-500/20 text-genius-blue-400 flex items-center justify-center">
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                    </span>
                    {{ lesson.title }}
                    <span class="text-genius-blue-400 text-sm">مجاني</span>
                  </Link>
                </template>

                <!-- Locked Lesson -->
                <template v-else>
                  <div class="flex-1 flex items-center gap-4 text-genius-gray-400">
                    <span class="w-8 h-8 rounded-full bg-genius-gray-700 flex items-center justify-center">
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                      </svg>
                    </span>
                    {{ lesson.title }}
                  </div>
                </template>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>