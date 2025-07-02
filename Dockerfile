# 1. Usar a imagem base Alpine, conforme solicitado. É leve e segura.
FROM python:3.13.5-alpine3.22

# 2. Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker
COPY requirements.txt .

# 4. Instalar as dependências
# --no-cache-dir para não armazenar o cache do pip e manter a imagem menor
# --upgrade pip para garantir que a versão mais recente do pip está sendo usada
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho
COPY . .

# 6. Expor a porta em que a aplicação vai rodar
EXPOSE 8000

# 7. Comando para iniciar a aplicação quando o contêiner for executado
# --host 0.0.0.0 é necessário para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
