class Api::V1::CepController < ApplicationController
  before_action :set_api

  def index
    response = Cep.all
    if response.nil?
      response = 'Nenhum registro encontrado!'
    end
    render json: response
  end

  def show
    cep = params[:cep]
    request_ = @url + cep
    response = Rails.cache.fetch([request_], :expires => 1.days) do
      HTTParty.get(url, :headers => { 'cache-control': 'no-cache', 'Accept': 'application/json' })
    end
    if response.present?
      Cep.create({
        cep: response['zip_code'],
        uf: response['state'],
        cidade: response['city'],
        bairro: response['neighborhood'],
        logradouro: response['address'],
        user_id: current_api_user.id
      })
    else
      response = 'Cep not found'
    end
    render json: response
  end

  def set_api
    @url = 'http://cep.la/'
  end

end


:zip_code, :state, :city, :neighborhood, :address, :user_id