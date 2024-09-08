'''Finance info utility functions.'''
import json
import yfinance as yf


def get_sp500_data():
    sp500 = yf.Ticker('^GSPC')
    hist = sp500.history(period='1mo')
    return hist


def convert_hist_to_json(hist):
    result = {"Positive": 0, "Negative": 0}

    total_days = len(hist)
    
    if total_days == 0:
        return json.dumps(result)  # Avoid division by zero if there's no data

    for index, row in hist.iterrows():
        # Check if the Close price is higher than the Open price (Positive trend)
        if row['Close'] > row['Open']:
            result["Positive"] += 1
        else:
            result["Negative"] += 1

    # Calculate percentages
    positive_percentage = (result["Positive"] / total_days) * 100
    negative_percentage = (result["Negative"] / total_days) * 100

    # Ensure the values are between 1 and 100
    result_json = {
        "Positive": max(1, min(100, round(positive_percentage))),
        "Negative": max(1, min(100, round(negative_percentage)))
    }

    return json.dumps(result_json)
