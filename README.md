# Password Generator Service

Este projeto é um gerador de senhas personalizáveis implementado em Ruby, que também armazena as senhas geradas no Redis.

## Funcionalidades

- Gera senhas com comprimento e tipos de caracteres personalizáveis.
- Suporte para caracteres:
  - Letras minúsculas
  - Letras maiúsculas
  - Dígitos
  - Símbolos especiais
- Armazena as senhas geradas no Redis com um tempo de expiração.
- Valida as opções de geração para garantir integridade.

## Tecnologias Usadas

- **Ruby**: Linguagem de programação principal.
- **Redis**: Usado para armazenar senhas temporariamente.
- **Rails**: Para disponibilizar endpoints REST.

## Como Usar

### Pré-requisitos

1. **Ruby** instalado (>= 2.7).
2. **Redis** em execução. Certifique-se de que o Redis está configurado e funcionando. Você pode usar o comando abaixo para iniciar o Redis:

   ```bash
   redis-server
   ```
3. Variáveis de ambiente configuradas:
   - `REDIS_URL`: URL do servidor Redis (opcional, padrão: `redis://localhost:6379/0`).

### Configuração

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git
   cd seu-repositorio
   ```

2. Instale as dependências:

   ```bash
   bundle install
   ```

### Executando a Aplicação

#### Geração de Senhas

A classe `PasswordGeneratorService` é responsável por gerar senhas. Você pode usá-la diretamente:

```ruby
require './password_generator_service'

options = {
  lowercase: true,
  uppercase: true,
  digits: true,
  symbols: true
}

password = PasswordGeneratorService.generate_password(12, options)
puts "Senha gerada: #{password}"
```

#### Usando com Rails

O projeto também inclui um controlador Rails (`PasswordsController`) para expor a geração de senhas via API.

1. Inicie o servidor Rails:

   ```bash
   rails server
   ```

2. Acesse o endpoint para criar uma senha via POST:

   ```bash
   curl -X POST http://localhost:3000/passwords -d 'length=12&lowercase=true&uppercase=true&digits=true&symbols=true'
   ```

   Exemplo de resposta:

   ```json
   {
     "password": "aB3!cD4@Ef5$"
   }
   ```

### Testes

O projeto inclui testes automatizados. Para executá-los, use:

```bash
rspec
```

Certifique-se de que o Redis esteja em execução antes de rodar os testes.

## Estrutura do Projeto

- `password_generator_service.rb`: Classe principal que implementa a lógica de geração de senhas e armazenamento no Redis.
- `app/controllers/passwords_controller.rb`: Controlador para expor a API de geração de senhas.
- `config/routes.rb`: Configuração de rotas para a API.
- `spec/`: Testes automatizados.

## Configuração do Redis

Por padrão, a aplicação tenta conectar ao Redis na URL `redis://localhost:6379/0`. Você pode configurar uma URL personalizada definindo a variável de ambiente `REDIS_URL`:

```bash
export REDIS_URL=redis://custom-redis-url:6379/0
```

## Melhorias Futuras

- Adicionar suporte a autenticação no Redis.
- Implementar um painel para visualizar as senhas geradas.
- Adicionar logs detalhados para fins de auditoria.

## Contribuição

Contribuições são bem-vindas! Siga estes passos para contribuir:

1. Fork o repositório.
2. Crie um branch para suas alterações:

   ```bash
   git checkout -b minha-feature
   ```

3. Submeta suas alterações e abra um Pull Request.


