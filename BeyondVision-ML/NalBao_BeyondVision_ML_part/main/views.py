from django.shortcuts import render
from rest_framework import generics
from django.http import HttpResponse
import ready as ready
import speechRecognition.tts as tts

import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))


def index(request):
    ready.selectExercise()
    return render(request, 'main/main.html')


def start(request):
    tts.q.queue.clear()
    return render(request, 'main/start.html')
