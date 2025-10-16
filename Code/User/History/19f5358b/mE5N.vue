<script setup>
import { ref, onUnmounted, onMounted } from 'vue'
import { Link } from '@inertiajs/vue3'  
import Nav from './components/Nav.vue';
</script>
<template>
  <div dir="rtl" class="bg-gray-900 text-white overflow-x-hidden font-cairo">
    <Nav />
    section class="container mx-auto px-4 py-8">
      <h1 class="text-4xl font-bold mb-4">من نحن</h1>
      <p class="text-lg mb-4">
        نحن فريق Genius EG، نعمل على تقديم أفضل الدورات التعليمية للطلاب في مصر. هدفنا هو تمكين الطلاب من تحقيق إمكاناتهم الكاملة من خلال التعليم المتميز.
        </p>    
  </div>
</template>