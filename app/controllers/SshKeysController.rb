#controlador das ssh_key

class SshKeysController < ApplicationController
  def index
    # Exibe todas as chaves armazenadas no Redis
    @keys = SshKey.all
  end

  def new
    # Exibe o formulário para cadastrar uma nova chave
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
end
