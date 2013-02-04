# encoding: utf-8
PlazrAuth::Engine.load_seed

module PlazrStore
  puts 'Creating default Discount Types'

  discount_types = [
    {name:'Percentagem Fixa', description:'O preço é atualizado segundo uma dada percentagem.', scope:0, type_id:1},
    {name:'Pack Disconto', description:'Se um dado número de produtos são comprados, o disconto é aplicado', scope:1, type_id:2},
    {name:'Novo Preço', description:'Um novo preço é definido para o produto.', scope:2, type_id:3},
    {name:'Número de Items', description:'Um disconto é aplicado se um dado número de items forem comprados.', scope:1, type_id:4}
  ]

  discount_types.each do |attributes|
    DiscountType.find_or_initialize_by_name(attributes[:name]).tap do |found_dt|
      found_dt.name = attributes[:name]
      found_dt.description = attributes[:description]
      found_dt.scope = attributes[:scope]
      found_dt.type_id = attributes[:type_id]
      found_dt.save!
    end
  end

  # Template custom variables
  puts "Creating template customization colors"
  color = TemplateCustomization.find_or_initialize_by_id_name('bg-color')
  color.display_name = 'Cor do Fundo'
  color.value = 'rgba(221,230,214,1)'
  color.save

  color = TemplateCustomization.find_or_initialize_by_id_name('border-color')
  color.display_name = 'Cor do Contorno'
  color.value = 'rgba(0,168,198,1)'
  color.save

  color = TemplateCustomization.find_or_initialize_by_id_name('header-color')
  color.display_name = 'Cor do Titulo'
  color.value = 'rgba(15,15,15,1)'
  color.save

  color = TemplateCustomization.find_or_initialize_by_id_name('primary-color')
  color.display_name = 'Cor Principal'
  color.value = 'rgba(0,168,198,1)'
  color.save
end