FROM python:3.11-slim

# Evita que o Python grave arquivos .pyc e força logs sem buffer
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

# Instala as dependências Python
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código do projeto
COPY . /app/

# Expõe a porta interna do Gunicorn
EXPOSE 8000

# Executa as migrações do banco e sobe o Gunicorn na porta 8000
CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn --bind 0.0.0.0:8000 --workers 3 nome_do_projeto.wsgi:application"]