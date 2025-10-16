<x-layout>
    <section class="heading-page header-text" id="top">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h6><big>{{ $course->level->title }}</big></h6>
                    <h2><big>{{ $course->title }}</big></h2>
                </div>
            </div>
        </div>
    </section>

    <section class="meetings-page" id="meetings">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="meeting-single-item">
                                <div class="thumb">
                                    <img src="{{ asset('images/single-meeting.jpg') }}" alt="">
                                </div>
                                <div class="down-content">
                                    <h2 style="text-align: center;"><b><big>{{ $course->title }}</big></b></h2>
                                    <h6 style="text-align: center;">
                                        <b><big><big>{{ $course->level->title }}</b></big></big>
                                    </h6>
                                    <br>
                                    <h6 style="text-align: center;"><b><big>٢٠٢٤ - ٢٠٢٥</big></b></h6>
                                    <hr>
                                    <br>
                                    <div class="col-lg-12">
                                        <div class="row">
                                            <div class="col-lg-12" style="text-align: center;">
                                                <div style="box-shadow: 0 4px 8px rgba(51, 51, 51, 0.6);">
                                                    <div class="date">
                                                        <a @if ($lesson) href="{{ route('lesson', ['level' => $level, 'course' => $course, 'lesson' => $lesson]) }}"><img
                                                            src="{{ Storage::url($course->image) }}" alt="Genius Logo"
                                                                style="width: 200px; height: 200px; margin-top: 20px;"></a>
                                                    @else
                                                        <div>
                                                            no lessons yet
                                                        </div> @endif
                                                            </div>
                                                            <div class="down-content">
                                                                @if ($lesson)
                                                                    <a
                                                                        href="{{ route('lesson', ['lesson' => $lesson]) }}">
                                                                        <h4><big>الدروس</big></h4>
                                                                    </a>
                                                                @endif
                                                                <h6>الشرح الأساسي للمنهج</h6>
                                                            </div>
                                                    </div>
                                                </div>
                                                <br>
                                                <div class="col-lg-12" style="text-align: center; margin-top: 30px;">
                                                    <div style="box-shadow: 0 4px 8px rgba(51, 51, 51, 0.6);">
                                                        <div class="date">

                                                        </div>
                                                        <div class="down-content">
                                                            <h6>الأغاني أو الكرتون للدروس</h6>

                                                                </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <hr>
                                            <br>
                                            <div class="row" style="text-align: center;">
                                                <div class="col-lg-4">
                                                    <div class="teacher-name">
                                                        <h4 style="color: #3cf;">اسم المعلم</h4>
                                                        <br>
                                                        <h5>أ/ أسامة الجندي</h5>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="degree">
                                                        <h4 style="color: #3cf;">الدرجة العلمية</h4>
                                                        <br>
                                                        <h5>معلم كبير لغة عربية</h5>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="teacher-photo">
                                                        <h4 style="color: #3cf;">صورة المعلم</h4>
                                                    </div>
                                                    <img src="{{ asset('images/aa.png') }}" alt="صورة المعلم"
                                                        style="width:80px; height:auto;">
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="main-button-red">
                                        <a href="{{ route('courses') }}">
                                            <h5>العودة إلى صفحة كل المواد</h5>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer">
                    <p>Copyright © <a href="https://www.facebook.com/profile.php?id=100090024653201&mibextid=ZbWKwL"
                            target="_blank">NSP Team 2024</a>. All Rights Reserved
                </div>
    </section>
</x-layout>
