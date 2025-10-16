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
            1  => 'المستوى الأول',
            2  =>  'المستوى الثاني',
            3 =>  'المستوى الثالث',
            4 =>  'المستوى الرابع',
            5 =>  'المستوى الخامس',
            6 =>  'المستوى السادس',
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
