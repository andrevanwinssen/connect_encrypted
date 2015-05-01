require 'puppet/face'
require 'openssl'
require 'base64'
require 'digest'

Puppet::Face.define(:connect, '0.0.1') do

  action(:encrypt) do
    summary "Encrypt the values in a spacified file for usage with the decrypt data source"

    description <<-EOT
      Encrypt the values in the specfied file using the specfied password. The output is usable for reading a 
      by the connect data source decrypt.
    EOT

    option "--password PASSWORD", "-p PASSWORD" do
      summary "Password to use for the encryption"
      description <<-EOT
        The passwordt to use for the encryption
      EOT
    end

    option "--algorithm ALGORITHM", "-a ALGORITHM" do
      summary "Algorithm to use for the encryption"
      description <<-EOT
        The Algorithm to use for the encryption. Default is AES-128-CBC. You can select #{OpenSSL::Cipher.ciphers.join(', ')}
      EOT
    end

    examples <<-EOT

      Given a connect config file  test.config:

        a_value = 10
        my_scope::b_value = a

      When you want encrypt this with the following command:

      $ puppet connect encrypt test.config

      You get the follwoing output

      TODO:

    EOT

    arguments "<file_name>"

    when_invoked do | name , options| 
      @file_name = name
      @algorithm = options.fetch(:algorithm) { 'AES-128-CBC'}
      @password  = options.fetch(:password) {''}
      initialize_dsl
      initialize_encryption
      header
      content
      footer
    end
  end

  def initialize_dsl
    @connect = Connect::Dsl.instance('.')
    @connect.include_file(@file_name)
    @value_list = @connect.lookup_values('.*')
  end

  def initialize_encryption
    @cipher = OpenSSL::Cipher.new(@algorithm)
    @cipher.encrypt
    @cipher.key = @password
  end

  def header
    puts "password = '#{@password}'"
    puts 'import from encryped("${@password}") do '
  end


  def content
    @value_list.each do |key , value|
      iv = @cipher.random_iv
      encrypted = @cipher.update(value.to_s) << @cipher.final
      puts "  #{key} = #{Base64.encode64(iv).chop}|#{Base64.encode64(encrypted).chop}"
    end
  end

  def footer
    puts 'end'
  end

end
