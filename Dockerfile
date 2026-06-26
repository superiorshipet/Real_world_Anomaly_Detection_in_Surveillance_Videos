FROM python:3.11-slim

WORKDIR /app

# ffmpeg + build tools
RUN apt-get update && apt-get install -y \
    ffmpeg \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Install CPU-only torch أخف بكتير في الـ container
RUN pip install --no-cache-dir torch torchvision --index-url https://download.pytorch.org/whl/cpu

# Install باقي الـ dependencies
RUN pip install --no-cache-dir \
    fastapi==0.111.0 \
    uvicorn[standard]==0.29.0 \
    pydantic==2.7.0 \
    numpy>=1.24.0 \
    Pillow>=10.0.0 \
    PyYAML>=6.0 \
    opencv-python-headless>=4.8.0

COPY . .

EXPOSE 8000
CMD ["uvicorn", "working_api:app", "--host", "0.0.0.0", "--port", "8000"]
