<template>
  <div dir="rtl" class="bg-gray-900 text-white overflow-x-hidden font-cairo">
    <!-- Hero Section -->
    <section class="min-h-screen bg-gradient-to-br from-gray-900 via-purple-900 to-blue-900 relative overflow-hidden">
      <!-- Animated Background Elements -->
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute -top-10 -right-10 w-72 h-72 bg-blue-400/10 rounded-full animate-pulse"></div>
        <div class="absolute top-1/3 -left-20 w-96 h-96 bg-purple-400/10 rounded-full animate-pulse" style="animation-delay: 1s;"></div>
        <div class="absolute bottom-10 right-1/3 w-48 h-48 bg-blue-300/10 rounded-full animate-pulse" style="animation-delay: 2s;"></div>
      </div>

      <div class="relative z-10 container mx-auto px-4 pt-32 pb-20">
        <div class="text-center">
          <h1 class="text-6xl lg:text-8xl font-bold text-white mb-8 leading-tight">
            <span class="bg-gradient-to-r from-blue-400 via-purple-400 to-pink-400 bg-clip-text text-transparent">
              أسلوب جديد
            </span>
            <br>
            للتعليم في مصر 🏆
          </h1>

          <p class="text-xl lg:text-2xl text-gray-300 mb-12 max-w-4xl mx-auto leading-relaxed">
            هذه منصة تعليمية توفر مجموعة متنوعة من الدروس والمواد التعليمية لمساعدتكم
            على تحقيق النجاح والتفوق الأكاديمي. انضموا إلينا الآن وابدأوا رحلتكم التعليمية.
          </p>

          <div class="flex flex-col sm:flex-row gap-6 justify-center items-center mb-16">
            <Link v-if="!$page.props.auth?.user" href="/register" class="group relative px-8 py-4 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full text-xl font-bold hover:from-blue-600 hover:to-purple-700 transition-all transform hover:scale-105 shadow-lg hover:shadow-2xl">
              <span class="relative z-10">انضم إلينا الآن !</span>
              <div class="absolute inset-0 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full blur opacity-30 group-hover:opacity-50 transition-opacity"></div>
            </Link>

            <Link href="/demo" class="flex items-center space-x-2 space-x-reverse px-8 py-4 border-2 border-blue-400 rounded-full text-xl font-bold text-blue-400 hover:bg-blue-400 hover:text-white transition-all">
              <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M8 5v14l11-7z"/>
              </svg>
              <span>مشاهدة العرض التجريبي</span>
            </Link>
          </div>

          <!-- Statistics -->
          <div class="grid grid-cols-2 md:grid-cols-4 gap-8 max-w-4xl mx-auto">
            <div class="text-center">
              <div class="text-4xl font-bold text-blue-400 mb-2">٣٠٠</div>
              <div class="text-gray-400">جنيه / فصل دراسي</div>
              <div class="text-sm text-gray-500">المرحلة الابتدائية</div>
            </div>
            <div class="text-center">
              <div class="text-4xl font-bold text-purple-400 mb-2">٤٠٠</div>
              <div class="text-gray-400">جنيه / فصل دراسي</div>
              <div class="text-sm text-gray-500">المرحلة الإعدادية</div>
            </div>
            <div class="text-center">
              <div class="text-4xl font-bold text-pink-400 mb-2">٢٠٪</div>
              <div class="text-gray-400">خصم</div>
              <div class="text-sm text-gray-500">للطلاب الإخوة</div>
            </div>
            <div class="text-center">
              <div class="text-4xl font-bold text-green-400 mb-2">٦</div>
              <div class="text-gray-400">معلمين خبراء</div>
              <div class="text-sm text-gray-500">في جميع المواد</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Goals Section -->
    <section class="py-20 bg-gray-900">
      <div class="container mx-auto px-4">
        <div class="text-center mb-16">
          <h2 class="text-5xl font-bold text-white mb-4">الأهداف القادمة</h2>
          <p class="text-xl text-gray-400">نحو مستقبل تعليمي أفضل</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div v-for="(goal, index) in goals" :key="index"
               class="group bg-gradient-to-br from-gray-800 to-gray-900 p-8 rounded-2xl hover:from-blue-900/50 hover:to-purple-900/50 transition-all duration-300 transform hover:scale-105 hover:shadow-2xl border border-gray-700 hover:border-blue-500">

            <div class="text-6xl mb-6 group-hover:animate-bounce">{{ goal.icon }}</div>
            <h3 class="text-2xl font-bold text-white mb-4 group-hover:text-blue-400 transition-colors">{{ goal.title }}</h3>
            <p class="text-gray-400 text-lg leading-relaxed">{{ goal.description }}</p>

            <div class="mt-6 w-12 h-1 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full group-hover:w-full transition-all duration-300"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- About Section -->
    <section class="py-20 bg-gradient-to-r from-blue-900/20 to-purple-900/20">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
          <div>
            <h2 class="text-5xl font-bold text-white mb-8">
              <span class="bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
                ما هي منصة Genius EG؟
              </span>
            </h2>
            <p class="text-xl text-gray-300 leading-relaxed mb-8">
              منصتنا التعليمية تهدف إلى تلبية احتياجات الطلاب وأولياء الأمور بشكل شامل ومتميز.
              نحن مجموعة من المدرسين المكرسين لخدمة المصلحة التعليمية، حيث نعمل بجد لتوصيل
              المعلومات بشكل فعال واحترافي. هدفنا هو تخفيف عبء مصروفات الدروس الخصوصية عن
              أولياء الأمور، وذلك من خلال تقديم محتوى تعليمي ذو جودة عالية وبأسعار معقولة.
            </p>

            <div class="space-y-4">
              <div class="flex items-center space-x-3 space-x-reverse">
                <div class="w-6 h-6 bg-green-400 rounded-full flex items-center justify-center">
                  <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                  </svg>
                </div>
                <span class="text-gray-300">شروحات تفاعلية ومبتكرة</span>
              </div>
              <div class="flex items-center space-x-3 space-x-reverse">
                <div class="w-6 h-6 bg-green-400 rounded-full flex items-center justify-center">
                  <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                  </svg>
                </div>
                <span class="text-gray-300">متابعة مستمرة مع أولياء الأمور</span>
              </div>
              <div class="flex items-center space-x-3 space-x-reverse">
                <div class="w-6 h-6 bg-green-400 rounded-full flex items-center justify-center">
                  <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                  </svg>
                </div>
                <span class="text-gray-300">أسعار مناسبة للجميع</span>
              </div>
            </div>
          </div>

          <div class="relative">
            <div class="absolute inset-0 bg-gradient-to-r from-blue-400/20 to-purple-400/20 rounded-3xl transform rotate-3"></div>
            <div class="relative bg-gray-800 p-8 rounded-3xl border border-gray-700">
              <h3 class="text-2xl font-bold text-white mb-6">المراحل التعليمية المتوفرة</h3>
              <div class="space-y-4">
                <div class="flex items-center justify-between p-4 bg-gray-700 rounded-lg">
                  <span class="text-white">المرحلة الابتدائية</span>
                  <span class="text-green-400 font-bold">متاح الآن</span>
                </div>
                <div class="flex items-center justify-between p-4 bg-gray-700 rounded-lg">
                  <span class="text-white">المرحلة الإعدادية</span>
                  <span class="text-green-400 font-bold">متاح الآن</span>
                </div>
                <div class="flex items-center justify-between p-4 bg-gray-700 rounded-lg">
                  <span class="text-white">رياض الأطفال</span>
                  <span class="text-yellow-400 font-bold">قريباً</span>
                </div>
                <div class="flex items-center justify-between p-4 bg-gray-700 rounded-lg">
                  <span class="text-white">المرحلة الثانوية</span>
                  <span class="text-yellow-400 font-bold">قريباً</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Teachers Section -->
    <section class="py-20 bg-gray-900">
      <div class="container mx-auto px-4">
        <div class="text-center mb-16">
          <h2 class="text-5xl font-bold text-white mb-4">معلمي Genius EG</h2>
          <p class="text-xl text-gray-400">فريق من أفضل المعلمين في مصر</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div v-for="(teacher, index) in teachers" :key="index"
               class="group bg-gray-800 rounded-2xl overflow-hidden hover:bg-gray-750 transition-all duration-300 transform hover:scale-105 hover:shadow-2xl border border-gray-700 hover:border-blue-500">

            <div class="relative h-64 bg-gradient-to-br from-blue-400/20 to-purple-400/20 flex items-center justify-center">
              <div class="w-32 h-32 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center">
                <span class="text-4xl font-bold text-white">{{ getTeacherInitial(teacher.name) }}</span>
              </div>
              <div class="absolute inset-0 bg-gradient-to-t from-gray-800/50 to-transparent"></div>
            </div>

            <div class="p-6">
              <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center mr-3">
                  <span class="text-xl font-bold text-white">G</span>
                </div>
              </div>
              <h3 class="text-2xl font-bold text-white mb-2 group-hover:text-blue-400 transition-colors">{{ teacher.name }}</h3>
              <p class="text-gray-400 text-lg">{{ teacher.subject }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="py-20 bg-gradient-to-br from-gray-800 to-gray-900">
      <div class="container mx-auto px-4">
        <div class="text-center mb-16">
          <h2 class="text-5xl font-bold text-white mb-4">الأسئلة الشائعة</h2>
          <p class="text-xl text-gray-400">إجابات على أهم الأسئلة</p>
        </div>

        <div class="max-w-4xl mx-auto">
          <div v-for="(faq, index) in faqData" :key="index" class="mb-4">
            <div class="bg-gray-800 rounded-lg border border-gray-700 hover:border-blue-500 transition-colors">
              <button @click="activeAccordion = activeAccordion === index ? -1 : index"
                      class="w-full px-6 py-4 text-right flex items-center justify-between hover:bg-gray-750 transition-colors rounded-lg">
                <span class="text-lg font-medium text-white">{{ faq.question }}</span>
                <svg :class="['w-6 h-6 text-blue-400 transition-transform', activeAccordion === index ? 'rotate-180' : '']"
                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                </svg>
              </button>
              <div v-show="activeAccordion === index" class="px-6 pb-4">
                <p class="text-gray-300 leading-relaxed">{{ faq.answer }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section class="py-20 bg-gray-900">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-16">
          <div class="lg:col-span-2">
            <h2 class="text-4xl font-bold text-white mb-8">نسعد بتواصلكم معنا</h2>

            <form @submit.prevent="submitForm" class="space-y-6">
              <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <input v-model="form.name" type="text" placeholder="اسمك ثلاثي...*"
                       class="bg-gray-800 border border-gray-700 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:border-blue-400 focus:outline-none transition-colors">
                <input v-model="form.email" type="email" placeholder="بريدك الإلكتروني...*"
                       class="bg-gray-800 border border-gray-700 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:border-blue-400 focus:outline-none transition-colors">
                <input v-model="form.subject" type="text" placeholder="الموضوع...*"
                       class="bg-gray-800 border border-gray-700 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:border-blue-400 focus:outline-none transition-colors">
              </div>
              <textarea v-model="form.message" placeholder="رسالتك...*" rows="6"
                        class="w-full bg-gray-800 border border-gray-700 rounded-lg px-4 py-3 text-white placeholder-gray-400 focus:border-blue-400 focus:outline-none transition-colors resize-none"></textarea>
              <button type="submit" class="px-8 py-3 bg-gradient-to-r from-blue-500 to-purple-600 rounded-lg text-white font-bold hover:from-blue-600 hover:to-purple-700 transition-all transform hover:scale-105">
                أرسل الرسالة الآن
              </button>
            </form>
          </div>

          <div class="bg-gray-800 p-8 rounded-2xl border border-gray-700">
            <h3 class="text-2xl font-bold text-white mb-6">معلومات التواصل</h3>

            <div class="space-y-6">
              <div class="flex items-center space-x-4 space-x-reverse">
                <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center">
                  <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                  </svg>
                </div>
                <div>
                  <div class="text-gray-400 text-sm">رقم الهاتف</div>
                  <a href="tel:01148279709" class="text-white font-medium hover:text-blue-400">01148279709</a>
                </div>
              </div>

              <div class="flex items-center space-x-4 space-x-reverse">
                <div class="w-12 h-12 bg-purple-500 rounded-full flex items-center justify-center">
                  <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.2a2 2 0 002.2 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                  </svg>
                </div>
                <div>
                  <div class="text-gray-400 text-sm">البريد الإلكتروني</div>
                  <a href="mailto:support@geniuseg.com" class="text-white font-medium hover:text-blue-400">support@geniuseg.com</a>
                </div>
              </div>

              <div class="flex items-center space-x-4 space-x-reverse">
                <div class="w-12 h-12 bg-pink-500 rounded-full flex items-center justify-center">
                  <span class="text-white font-bold text-xl">f</span>
                </div>
                <div>
                  <div class="text-gray-400 text-sm">الصفحة على فيسبوك</div>
                  <a href="#" class="text-white font-medium hover:text-blue-400">Genius EG</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-black py-8">
      <div class="container mx-auto px-4 text-center">
        <p class="text-gray-400">
          جميع الحقوق محفوظة ©
          <a href="#" target="_blank" class="text-blue-400 hover:text-blue-300">NSP Team 2024</a>
        </p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import Nav from "./components/Nav.vue";
import { ref, onMounted, onUnmounted } from 'vue'
import { Link } from '@inertiajs/vue3'

// Reactive data
const isMenuOpen = ref(false)
const scrollY = ref(0)
const activeAccordion = ref(0)

// Form data
const form = ref({
  name: '',
  email: '',
  subject: '',
  message: ''
})

// Static data
const goals = ref([
  { title: "الهدف الأول", description: "الشرح الأساسي للمنهج", icon: "📚" },
  { title: "الهدف الثاني", description: "الأغاني على الدروس", icon: "🎵" },
  { title: "الهدف الثالث", description: "شرح الدروس على شكل كرتون", icon: "🎬" },
  { title: "الهدف الرابع", description: "تقييم الطلاب بشكل مستمر", icon: "📊" },
  { title: "الهدف الخامس", description: "المتابعة المستمرة مع ولي الأمر", icon: "👨‍👩‍👧‍👦" },
  { title: "الهدف السادس", description: "دعم التعليم التفاعلي", icon: "💡" }
])

const teachers = ref([
  { name: "أ/ أسامة الجندي", subject: "معلم كبير لغة عربية" },
  { name: "أ/ إبتسام ياسر", subject: "معلم لغة عربية" },
  { name: "أ/ شريف زلط", subject: "معلم خبير لغة إنجليزية" },
  { name: "أ/ آية حمد", subject: "معلم أول رياضيات" },
  { name: "أ/ إيهاب ساعي الدين", subject: "معلم دراسات اجتماعية" },
  { name: "أ/ إلهام يوسف", subject: "كبير معلمي مادة العلوم" }
])

const faqData = ref([
  {
    question: "ما رسوم الاشتراك لكل فصل دراسي؟",
    answer: "٣٠٠ جنيه شاملة جميع المواد الدراسية لمرحلة التعليم الابتدائي طوال الفصل الدراسي. ٤٠٠ جنيه شاملة جميع المواد الدراسية لمرحلة التعليم الإعدادي طوال الفصل الدراسي."
  },
  {
    question: "كيف يمكنني الدفع للاشتراك في المنصة؟",
    answer: "للاشتراك: يمكنكم الاشتراك من خلال الموقع. طرق الدفع المتاحة تشمل: Instapay, Vodafone Cash, Orange Cash, Etisalat Cash."
  },
  {
    question: "ما هي الميزات التي تقدمها المنصة؟",
    answer: "المنصة تقدم شروحات ودروس تعليمية تفاعلية وأناشيد وملخص كرتوني، واختبارات تقييمية، ومتابعات من أولياء الأمور باستمرار."
  },
  {
    question: "كيف يمكنني التواصل معكم؟",
    answer: "يمكنكم التواصل معنا عبر البريد الإلكتروني (الجيميل)، أو أرقام الواتساب الموجودة على الموقع، أو من خلال صفحة الفيسبوك."
  }
])

// Methods
const handleScroll = () => {
  scrollY.value = window.scrollY
}

const getTeacherInitial = (name) => {
  const parts = name.split(' ')
  return parts.length > 1 ? parts[1][0] : parts[0][0]
}

const submitForm = () => {
  // Handle form submission with Inertia
  console.log('Form submitted:', form.value)
  // You can use router.post('/contact', form.value) here
}

// Lifecycle hooks
onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Cairo:wght@200..1000&display=swap');

.font-cairo {
  font-family: 'Cairo', sans-serif;
}

/* Custom animations */
@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

.animate-float {
  animation: float 6s ease-in-out infinite;
}

/* Gradient background animation */
@keyframes gradient {
  0%, 100% {
    background-size: 200% 200%;
    background-position: left center;
  }
  50% {
    background-size: 200% 200%;
    background-position: right center;
  }
}

.animate-gradient {
  animation: gradient 3s ease infinite;
}

/* Smooth hover effects */
.hover-lift:hover {
  transform: translateY(-8px);
}

/* Custom scrollbar for webkit browsers */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #1f2937;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(45deg, #3b82f6, #8b5cf6);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(45deg, #2563eb, #7c3aed);
}
</style>
