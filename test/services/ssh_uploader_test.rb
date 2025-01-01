require 'test_helper'

class SshUploaderTest < ActiveSupport::TestCase
  def setup
    @name = "my_key"
    @host = "remote_server_ip"
    @user = "username"
    @local_path = "/path/to/local/file"
    @remote_path = "/path/to/remote/file"
  end

  test "should upload file successfully" do
    # Simula a chave SSH armazenada no Redis
    SshKey.store(@name, "public_ssh_key_content")

    # Cria a instância do serviço de upload
    uploader = SshUploader.new(@name, @host, @user, @local_path, @remote_path)

    # Verifica se o método de upload é chamado sem erros
    assert_nothing_raised { uploader.upload }
  end

  test "should raise error if SSH key not found" do
    uploader = SshUploader.new(@name, @host, @user, @local_path, @remote_path)
    assert_raises RuntimeError do
      uploader.upload
    end
  end
end
