from django.urls import path
from django.http import StreamingHttpResponse
from camera import VideoCamera, gen
from . import views

urlpatterns = [
    path('', views.start, name='start'),
    path('training/', views.index, name='index'),
    path('camera/', lambda r: StreamingHttpResponse(gen(VideoCamera()),
                                                    content_type='multipart/x-mixed-replace; boundary=frame')),
]