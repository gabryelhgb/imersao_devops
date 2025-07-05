# Etapa 1: Escolher a imagem base do Python.
# A imagem 'slim' é uma boa escolha por ser menor que a padrão,
# mas ainda ter as ferramentas necessárias para a maioria dos pacotes.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
# Isso evita que os arquivos da aplicação se espalhem pelo sistema de arquivos.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências.
# Copiamos este arquivo separadamente para aproveitar o cache do Docker.
# A camada de instalação de dependências só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# Usamos --no-cache-dir para manter a imagem final menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
EXPOSE 8000

# Etapa 7: Definir o comando para iniciar a aplicação com Uvicorn.
# Usamos --host 0.0.0.0 para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]