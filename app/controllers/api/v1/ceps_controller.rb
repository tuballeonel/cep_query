class Api::V1::CepsController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_api

  def index
    zip_code = Cep.all
    if zip_code.empty?
      zip_code = 'Register not found'
    end

    render json: zip_code
  end

  def show
    url = @url + params[:id]
    response = Rails.cache.fetch([url], :expires => 1.days) do
      HTTParty.get(url, :headers => { 'cache-control': 'no-cache', 'Accept': 'application/json' })
    end
    if response.present?
      Cep.create({
        zip_code:     response['cep'],
        state:        response['uf'],
        city:         response['cidade'],
        neighborhood: response['bairro'],
        address:      response['logradouro'],
        user_id:      current_api_user.id
      })
    else
      response = 'Zip code not found'
    end
    render json: response
  end

  def set_api
    @url = 'http://cep.la/'
  end

end


