require "redis"

class PasswordGeneratorService
  CHARSETS = {
    lowercase: ("a".."z").to_a,
    uppercase: ("A".."Z").to_a,
    digits: ("0".."9").to_a,
    symbols: %w[! @ # $ % ^ & * ( ) _ + = - ~ ` { } [ ] | ; : ' " , . / ? > <]
  }

  def self.generate_password(length, options = {})
    # Valida o comprimento da senha
    raise ArgumentError, "Comprimento inválido" if length <= 0

    # Valida opções para garantir que são válidas
    validate_options(options)

    charset = build_charset(options)
    password = Array.new(length) { charset.sample }.join

    # Armazena a senha gerada no Redis
    store_password(password)

    password
  end

  private

  # Valida se as opções fornecidas são válidas
  def self.validate_options(options)
    valid_keys = [:lowercase, :uppercase, :digits, :symbols]
    options.each_key do |key|
      unless valid_keys.include?(key)
        raise ArgumentError, "Opção inválida: #{key}"
      end
    end
  end

  # Constrói o conjunto de caracteres baseado nas opções fornecidas
  def self.build_charset(options = {})
    charset = []
    charset += CHARSETS[:lowercase] if options[:lowercase]
    charset += CHARSETS[:uppercase] if options[:uppercase]
    charset += CHARSETS[:digits] if options[:digits]
    charset += CHARSETS[:symbols] if options[:symbols]

    # Se nenhum conjunto de caracteres for escolhido, gera erro
    raise ArgumentError, "Pelo menos uma opção de caractere deve ser selecionada" if charset.empty?

    charset
  end

  # Armazena a senha gerada no Redis
  def self.store_password(password)
    # Verifica se a conexão com o Redis está funcionando antes de armazenar
    begin
      redis.set("password_#{SecureRandom.uuid}", password)
    rescue => e
      raise "Erro ao armazenar a senha no Redis: #{e.message}"
    end
  end

  # Conecta ao Redis
  def self.redis
    @redis ||= Redis.new(url: ENV["REDIS_URL"] || "redis://localhost:6379/0")
  end
end
