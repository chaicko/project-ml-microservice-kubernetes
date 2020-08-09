FROM python:3.7.3-stretch

# Working Directory
WORKDIR /app

# Copy requirements file first (to make use of cache)
COPY requirements.txt .

# Then run pip so we generally use caching
# hadolint ignore=DL3013
RUN pip install --upgrade pip &&\
    pip install --trusted-host pypi.python.org -r requirements.txt

# Copy source code to working directory
COPY . app.py /app/

# Expose port 80
EXPOSE 80

# Run app.py at container launch
CMD ["python", "app.py"]

