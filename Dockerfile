# Imagen base de Python
FROM python:3.11-slim

# Crear y usar un entorno virtual en /opt/venv
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instalar dependencias de sistema necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements si existe
COPY requirements.txt .

# Instalar dependencias de Python (incluido Langflow si no está en requirements)
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install langflow

# Copiar el código de la app
COPY . /app
WORKDIR /app

# Exponer el puerto donde correrá Langflow
EXPOSE 7860

# Comando de inicio
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
