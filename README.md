# Financial Market Widget

## Overview

This project consists of a SwiftUI-based iPhone widget and a Django backend. The iPhone widget displays a pie chart representing the current state of the financial market, while the Django backend provides the necessary API to supply financial data to the widget.

## Features

- **iPhone Widget**: Built using SwiftUI, the widget displays a pie chart showing the current state of the financial market.
- **Django Backend**: Provides a RESTful API that supplies the financial data to the SwiftUI widget.

## Installation

### Backend Setup (Django)

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/financial-market-widget.git
    cd financial-market-widget/backend
    ```

2. **Create and activate a virtual environment:**

    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. **Install dependencies:**

    ```bash
    pip install -r requirements.txt
    ```

4. **Run migrations:**

    ```bash
    python manage.py migrate
    ```

5. **Start the Django server:**

    ```bash
    python manage.py runserver
    ```

   The API will be available at `http://localhost:8000/api/sp500/`.

### Frontend Setup (SwiftUI)

1. **Open the SwiftUI project in Xcode.**

2. **Update the API endpoint in the project to point to your Django server.**

3. **Build and run the project on your iPhone or simulator.**

## API

The Django backend provides the following endpoint:

- **`GET /api/sp500/`**: Returns the current state of the financial market as a JSON object.

  Example response:
  
  ```json
  {
    "Positive": 55,
    "Negative": 45
  }
