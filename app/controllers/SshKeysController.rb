# controlador das ssh_key
class SshKeysController < ApplicationController
  def index
    # Exibe todas as chaves armazenadas no Redis
    @keys = SshKey.all
  end

  def new
    # Exibe o formulário para cadastrar uma nova chave
    @ssh_key = SshKey.new
  end

  def create
    # Cadastra uma nova chave SSH
    name = params[:name]
    public_key = params[:public_key]

    if name.present? && public_key.present?
      SshKey.store(name, public_key)
      redirect_to ssh_keys_path, notice: "Chave SSH cadastrada com sucesso!"
    else
      render :new, alert: "Nome ou chave pública inválidos"
    end
  end

  def destroy
    # Deleta uma chave SSH
    SshKey.delete(params[:name])
    redirect_to ssh_keys_path, notice: "Chave SSH deletada com sucesso!"
  end

  def upload
    # Realiza o upload do arquivo para o servidor remoto
    name = params[:name]
    host = params[:host]
    user = params[:user]
    local_path = params[:local_path]
    remote_path = params[:remote_path]

    begin
      # Cria a instância do serviço de upload e realiza o upload
      uploader = SshUploader.new(name, host, user, local_path, remote_path)
      uploader.upload

      # Responde com sucesso
      render plain: "Arquivo enviado com sucesso!"
    rescue => e
      # Exibe a mensagem de erro, caso haja falha no upload
      render plain: "Erro: #{e.message}", status: :unprocessable_entity
    end
  end
end
