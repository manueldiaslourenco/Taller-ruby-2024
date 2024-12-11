# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

    ["Accesorios","Camisetas Deportivas", "Remeras", "Pantalones", "Shorts", "Interior", "Zapatillas", "Botines", "Abrigo", "Conjuntos"].each do |category_name|
      Category.find_or_create_by!(name: category_name)
    end


    User.create!(
        email: 'manueldiasuala@gmail.com',
        username: 'admin_user',
        phone: '1234567890',
        role: 2,
        password: '45913067roco.now',             # Devise se encargará de encriptarla
        password_confirmation: '45913067roco.now' # Devise verifica que coincidan
    )


    require_relative 'seeds/products/helpers'
    require_relative 'seeds/products/create_products'