# Classe que representa uma chave SSH
class SshKey
  def self.store(name, public_key)
    # Armazena a chave SSH no Redis
    $redis.set("ssh_key:#{name}", public_key)
  end

  def self.all
    # Lista todas as chaves SSH armazenadas no Redis
    keys = $redis.keys("ssh_key:*")
    keys.map { |key| key.split(":").last }
  end

  def self.fetch(name)
    # Recupera uma chave SSH pelo nome
    $redis.get("ssh_key:#{name}")
  end

  def self.delete(name)
    # Deleta uma chave SSH do Redis
    $redis.del("ssh_key:#{name}")
  end
end
