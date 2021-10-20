class CepSerializer < ActiveModel::Serializer
  attributes :id, :zip_code, :state, :city, :neighborhood, :address, :user_id
end
