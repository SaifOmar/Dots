<script setup>
import { ref, onUnmounted, onMounted } from 'vue'
import { Link } from '@inertiajs/vue3'

defineProps({
    levels:  Array,
})

const isMenuOpen = ref(false)

const scrollY = ref(0)
// Methods
const handleScroll = () => {
  scrollY.value = window.scrollY
}
onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<template>
<nav :class="['fixed top-0 w-full z-50 transition-all duration-300', scrollY > 50 ? 'bg-gray-900/95 backdrop-blur-md shadow-lg' : 'bg-transparent']">
	  <div class="container mx-auto px-4 py-4">
		<div class="flex justify-between items-center">
		  <!-- Logo -->
		  <div class="flex items-center space-x-3 space-x-reverse">
			<div class="w-12 h-12 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full flex items-center justify-center">
			  <span class="text-xl font-bold text-white">G</span>
			</div>
			<span class="text-2xl font-bold bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">
			  Genius EG
			</span>
		  </div>

		  <!-- Desktop Navigation -->
		  <div class="hidden lg:flex items-center space-x-8 space-x-reverse text-white">
			<Link href="/" class="hover:text-blue-400 transition-colors">الصفحة الرئيسية</Link>

			<!-- Courses Dropdown -->
			<div class="group relative">
			  <button class="flex items-center hover:text-blue-400 transition-colors">
				<span>الدورات</span>
				<svg class="w-4 h-4 mr-1 group-hover:rotate-180 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
				</svg>
			  </button>

				<div class="absolute top-full right-0 mt-2 w-48 bg-gray-800 rounded-lg shadow-xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
					<Link :href="route('courses.index')" class="block px-4 py-2 hover:bg-gray-700 rounded-t-lg">جميع الدورات</Link>
					<Link 
						v-for="level in levels" 
						:key="level.id" 
						:href="route('courses.by_level', { level: level.slug })" 
						class="block px-4 py-2 hover:bg-gray-700"
						:class="{ 'rounded-b-lg': levels.indexOf(level) === levels.length - 1 }"
					>
						{{ level.name }}
					</Link>
				</div>
			</div>

			<Link href="/demo" class="hover:text-blue-400 transition-colors">العرض التجريبي</Link>
			<Link href="/about" class="hover:text-blue-400 transition-colors">من نحن</Link>
			<Link href="/contact" class="hover:text-blue-400 transition-colors">تواصل معنا</Link>

			<!-- User Profile/Login -->
			<div v-if="$page.props.auth?.user" class="group relative">
			  <button class="flex items-center bg-gradient-to-r from-blue-500 to-purple-600 px-4 py-2 rounded-full hover:from-blue-600 hover:to-purple-700 transition-all">
				<span>الملف الشخصي</span>
				<svg class="w-4 h-4 mr-2 group-hover:rotate-180 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
				</svg>
			  </button>
			  <div class="absolute top-full right-0 mt-2 w-40 bg-gray-800 rounded-lg shadow-xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
				<Link href="/dashboard" class="block px-4 py-2 hover:bg-gray-700 rounded-t-lg">لوحة التحكم</Link>
				<Link href="/profile" class="block px-4 py-2 hover:bg-gray-700">الإعدادات</Link>
				<Link href="/logout" method="post" class="block px-4 py-2 hover:bg-gray-700 rounded-b-lg text-red-400">تسجيل الخروج</Link>
			  </div>
			</div>
			<div v-else class="flex space-x-2 space-x-reverse">
			  <Link href="/login" class="px-4 py-2 border border-blue-400 text-blue-400 rounded-full hover:bg-blue-400 hover:text-white transition-all">
				تسجيل الدخول
			  </Link>
			  <Link href="/register" class="px-4 py-2 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full hover:from-blue-600 hover:to-purple-700 transition-all">
				انضم إلينا
			  </Link>
			</div>
		  </div>

		  <!-- Mobile menu button -->
		  <button class="lg:hidden text-white" @click="isMenuOpen = !isMenuOpen">
			<svg v-if="!isMenuOpen" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
			  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
			</svg>
			<svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
			  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
			</svg>
		  </button>
		</div>

		<!-- Mobile Navigation -->
		<div v-show="isMenuOpen" class="lg:hidden mt-4 bg-gray-800 rounded-lg p-4 space-y-2 text-white">
		  <Link href="/" class="block py-2 hover:text-blue-400">الصفحة الرئيسية</Link>
		  <Link href="/courses" class="block py-2 hover:text-blue-400">جميع الدورات</Link>
		  <Link href="/demo" class="block py-2 hover:text-blue-400">العرض التجريبي</Link>
		  <Link href="/about" class="block py-2 hover:text-blue-400">من نحن</Link>
		  <Link href="/contact" class="block py-2 hover:text-blue-400">تواصل معنا</Link>
		  <div v-if="!$page.props.auth?.user" class="pt-4 border-t border-gray-700">
			<Link href="/register" class="block w-full mb-2 px-4 py-2 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full text-center">
			  انضم إلينا
			</Link>
			<Link href="/login" class="block w-full px-4 py-2 border border-blue-400 text-blue-400 rounded-full text-center">
			  تسجيل الدخول
			</Link>
		  </div>
		</div>
	  </div>
	</nav>
</template>

