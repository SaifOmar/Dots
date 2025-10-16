<script setup>
const scores = [
  {
    id: 1,
    courseName: 'البرمجة بلغة Python',
    quizName: 'الاختبار النهائي',
    score: 95,
    maxScore: 100,
    date: '2025-08-15',
    status: 'passed'
  },
  // Add more scores...
];
</script>

<template>
  <div class="space-y-6">
    <h2 class="text-2xl font-bold text-white mb-6">نتائج الاختبارات</h2>
    
    <div class="overflow-x-auto">
      <table class="w-full">
        <thead>
          <tr class="border-b border-genius-gray-600">
            <th class="py-4 px-6 text-right text-gray-400 font-medium">اسم الكورس</th>
            <th class="py-4 px-6 text-right text-gray-400 font-medium">الاختبار</th>
            <th class="py-4 px-6 text-right text-gray-400 font-medium">النتيجة</th>
            <th class="py-4 px-6 text-right text-gray-400 font-medium">التاريخ</th>
            <th class="py-4 px-6 text-right text-gray-400 font-medium">الحالة</th>
          </tr>
        </thead>
        <tbody>
          <tr 
            v-for="score in scores" 
            :key="score.id"
            class="border-b border-genius-gray-600/50"
          >
            <td class="py-4 px-6 text-white">{{ score.courseName }}</td>
            <td class="py-4 px-6 text-white">{{ score.quizName }}</td>
            <td class="py-4 px-6">
              <div class="flex items-center">
                <div class="w-16 bg-genius-gray-700 rounded-full h-2 ml-3">
                  <div 
                    class="bg-genius-blue-500 h-2 rounded-full"
                    :style="`width: ${(score.score/score.maxScore) * 100}%`"
                  ></div>
                </div>
                <span class="text-white">{{ score.score }}/{{ score.maxScore }}</span>
              </div>
            </td>
            <td class="py-4 px-6 text-gray-300">{{ score.date }}</td>
            <td class="py-4 px-6">
              <span 
                class="inline-block px-3 py-1 rounded-full text-sm"
                :class="score.status === 'passed' ? 'bg-genius-green-500/20 text-genius-green-400' : 'bg-genius-red-500/20 text-genius-red-400'"
              >
                {{ score.status === 'passed' ? 'ناجح' : 'راسب' }}
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>