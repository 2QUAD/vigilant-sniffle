# Classe para fazer upload de arquivos via SCP usando SSH
class SshUploader
  def initialize(name, host, user, local_path, remote_path)
    @name = name
    @host = host
    @user = user
    @local_path = local_path
    @remote_path = remote_path
  end

  def upload
    # Busca a chave SSH no Redis
    public_key = SshKey.fetch(@name)

    if public_key.nil?
      raise "Chave SSH não encontrada!"
    end

    # Conectar via SSH e fazer o upload usando SCP
    Net::SSH.start(@host, @user, keys: [ public_key ]) do |ssh|
      ssh.scp.upload!(@local_path, @remote_path)
      puts "Arquivo enviado com sucesso!"
    end
  end
end
