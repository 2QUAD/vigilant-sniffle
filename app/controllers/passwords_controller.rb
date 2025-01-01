class PasswordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]

  def new
    # Renderiza a view
  end

  def create
    begin
      # Coleta os parâmetros de personalização da senha
      length = params[:length].to_i
      options = {
        lowercase: ActiveModel::Type::Boolean.new.cast(params[:lowercase]),
        uppercase: ActiveModel::Type::Boolean.new.cast(params[:uppercase]),
        digits: ActiveModel::Type::Boolean.new.cast(params[:digits]),
        symbols: ActiveModel::Type::Boolean.new.cast(params[:symbols])
      }

      # Gera a senha com base nas opções passadas
      @password = PasswordGeneratorService.generate_password(length, options)

      render json: { password: @password }
    rescue ArgumentError => e
      # Captura erros e retorna uma mensagem de erro
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
