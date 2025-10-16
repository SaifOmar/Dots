<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Level;

return new class() extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        $levels = [
            1  => 'الصف الأول الابتدائي',
            2  => 'الصف الثاني الابتدائي',
            3  => 'الصف الثالث الابتدائي',
            4  => 'الصف الرابع الابتدائي',
            5  => 'الصف الخامس الابتدائي',
            6  => 'الصف السادس الابتدائي',
            7  => 'الصف الأول الإعدادي',
            8  => 'الصف الثاني الإعدادي',
            9  => 'الصف الثالث الإعدادي',
        ];
        Schema::create('levels', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('slug')->default('slug');
            $table->timestamps();
        });
        for ($i = 1; $i <= 6; $i++) {
            Level::create(
                [
                    'title' => "Level $i",

                ]
            );
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('levels');
    }
};
