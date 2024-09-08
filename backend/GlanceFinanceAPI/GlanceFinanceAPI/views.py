'''Finance API Views.'''
from rest_framework.views import APIView
from rest_framework.response import Response
from .utility.finance_info import (
    get_sp500_data,
    convert_hist_to_json,
)


class SendSP500View(APIView):
    '''Send S&P 500 monthy average.'''

    def get(self, request):
        hist = get_sp500_data()
        json_hist = convert_hist_to_json(hist)
        return Response(json_hist)