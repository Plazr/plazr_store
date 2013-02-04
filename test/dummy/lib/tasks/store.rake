#!/bin/env ruby
# encoding: utf-8

namespace :db do
  desc "Erase and fill database"
  task :store => :environment do

    require 'factory_girl_rails'
    require 'database_cleaner'


    puts '>> Deleting all records from all tables'
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      PlazrAuth::User.with_deleted.all.each { |u| u.destroy! }

    puts 'Running db:seed'
    Rake::Task["db:seed"].execute

    puts '>> Generating user'
      FactoryGirl.create :user_with_user_role, email: "user@gmail.com", password: "asdasd", password_confirmation: "asdasd"
      FactoryGirl.create :admin, email: "admin@gmail.com", password: "asdasd", password_confirmation: "asdasd"


    ########### Produtct categories ###########
    puts '>> Produtct categories'
    def find_product_category(name)
      pc = PlazrStore::ProductCategory.find_by_name(name)
    end

    def add_product_category(name, description, parent = nil)
      return if find_product_category(name)
      
      if parent.nil?
        PlazrStore::ProductCategory.create  name: name, 
                                            description: description
      else
        PlazrStore::ProductCategory.create  name: name, 
                                            description: description, 
                                            parent_product_category_id: parent.id
      end

    end

    # Futebol
    add_product_category "Futebol", "Todo o tipo de artigos relacionados com futebol"
    add_product_category "Acessórios de treino/jogo", "", find_product_category("Futebol")
    add_product_category "Caneleiras", "", find_product_category("Acessórios de treino/jogo")
    add_product_category "Sacos", "", find_product_category("Acessórios de treino/jogo")
    add_product_category "Outros", "", find_product_category("Acessórios de treino/jogo")
    add_product_category "Bolas", "", find_product_category("Futebol")
    add_product_category "Bolas de Futebol", "", find_product_category("Bolas")
    add_product_category "Bolas de futsal", "", find_product_category("Bolas")
    add_product_category "Calçado", "", find_product_category("Futebol")
    add_product_category "Guarda-Redes", "", find_product_category("Futebol")
    add_product_category "Textil", "", find_product_category("Futebol")

    # Ciclismo
    add_product_category "Ciclismo", "Bicicletas e Acessórios para a pratica de ciclismo"
    add_product_category "Bicicletas", "", find_product_category("Ciclismo")
    add_product_category "Acessórios", "", find_product_category("Ciclismo")

    # Fitness
    add_product_category "Fitness", ""
    add_product_category "Acessórios de Fitness", "", find_product_category("Fitness")
    add_product_category "Acessórios de Musculação", "", find_product_category("Fitness")
    add_product_category "Proteção Desportiva", "", find_product_category("Fitness")


    ########### Produtct ###########
    puts '>> Produtcts'
    def find_product(name)
      pc = PlazrStore::Product.find_by_name(name)
    end

    def add_product(name, details, productcategoryname, price = 10)
      return if find_product(name)
      
      prod = PlazrStore::Product.create name: name, 
                                        details: details
      prod.product_categories << find_product_category(productcategoryname)
      prod.save

      vari = PlazrStore::Variant.create description: name,
                                        sku: name,
                                        price: price,
                                        amount_available: rand(5..80),
                                        product_id: prod.id,
                                        is_master: TRUE
      vari.save

      puts vari.id.to_s + ' | ' + vari.description + ' | ' + vari.price.to_s + ' | ' + vari.product_id.to_s + ' | ' + vari.amount_available.to_s + ' | ' + vari.is_master.to_s

      file = './lib/tasks/aux/' + name + '.jpg'
      if FileTest.exists?(file)
        # puts file
        mult = PlazrStore::Multimedium.new(:class_type => 'variant')
        mult.file = File.open(file)
        mult.caption = name
        mult.variant_id = vari.id
        mult.save
      end

    end

    # Futebol
    puts '>>>> Produtcts: Futebol'
    add_product "Braçadeira", "Braçadeira para capitão de uma equipa de Futebol.", "Acessórios de treino/jogo", 3.25
    add_product "Cartões", "Cartões amarelo e vermelho.", "Acessórios de treino/jogo", 2.90
    add_product "Apíto", "Apíto de árbitro em plástico.", "Acessórios de treino/jogo", 3.90
    add_product "Caneleira", 
                "Caneleira muito leve e felexível; forro sintético suave, para um conforto elevado.", 
                "Caneleiras", 3.99
    add_product "Ginga", "INDICADA PARA JOGAR FUTEBOL DE RUA", "Bolas de Futebol", 3.99
    add_product "SPZ EURO12", "INDICADA PARA A PRÁTICA OCASIONAL", "Bolas de Futebol", 7.99
    # add_product "Portugal Supporer's", 
    #             "COBERTURA: Cobertura Premium Up para um toque e sentir exepcional. 
    #              CÂMARA DE AR: poliéster reforçado na bexiga meçhora a retenção de ar e forma.
    #              DESENHO: Construção ligada permite Bonded construção 
    #              permite alinhar os paineis uniformemente para um toque consistente e 
    #              uma maior durabilidade. Absorve menos água, assim a bola mantem um 
    #              peso e sentir consistente.", 
    #              "Bolas de Futebol", 9.99
    add_product "League PRO", "Cosida à mão; 32 Paineis", "Bolas de Futebol", 15.99
    add_product "Futsal Academy", "Bola de futsal com tamanho e peso recomendados para formação", 
                "Bolas de futsal", 7.99
    add_product "FL450-YGR", "Bola oficial da Liga Portuguesa", "Bolas de futsal", 51.99
    add_product "HY-5006 MS", "Forro extra macio para maior conforto", "Calçado", 14.99
    add_product "AGILE-FG JR", 
                 "Aderência e conforto em solos de relva natural e seco. Topo em material sintético.
                 Firm Ground( FG) em TPU transparente.Forro extra macio para maior conforto.", 
                "Calçado", 19.99
    add_product "AGILE-IC", "Utilização de EVA na sola para aumentar o conforto", "Calçado", 24.99
    add_product "F5 IN J", "Sola que não marca. Meia-sola de EVA moldada.", "Calçado", 25
    add_product "Calções Guarda-Redes", 
                "Desenvolvido para a prática desportiva.Para praticantes regulares.Protecção em esponja 
                em zonas específicas de maior impacto.Poliéster.Regular.", 
                "Guarda-Redes", 9.99
    add_product "NIKE GK Classic", 
                "PUNHO: Tri-Vario Wraparound Wristband para um encaixe seguro que é fácil de ajustar. 
                GRIP: 3 mm de espuma de látex suave que fornece uma aderência confiável em todas as condições", 
                "Guarda-Redes", 9.99
    add_product "Response YP", 
                "Soft Grip - Latex Macio que oferece um bom agarre e durabilidade", 
                "Guarda-Redes", 9.99
    add_product "Response Graphic", 
                "SOFT GRIP PRO, látex macio na palma que oferece um bom agarre, amortecimento e durabilidade.", 
                "Guarda-Redes", 9.99
    add_product "V6.11", 
                "LUVAS RESISTENTES E DURÁVEIS IDEIAS PARA JOGADORES EM FORMAÇÃO.", 
                "Guarda-Redes", 13.49
    add_product "Meias Futebol", 
                "Desenvolvido para a prática desportiva.Para praticantes 
                regulares.Contém elastano para oferecer maior flexibilidade.Poliéster.Regular.", 
                "Textil", 1.99
    add_product "T-SHIRT", "", "Textil", 4.99
    add_product "Saco Mochila", "", "Sacos", 17.90

    puts '>>>> Produtcts: Ciclismo'
    add_product "BLAST 120 GREEN 2011", 
                "BICICLETA CRIANÇA DE 3 A 5 ANOS RODAS LATERAIS ESTABILIZADORAS PARA AUXILIO 
                NA APRENDIZAGEM QUADRO COM GEOMETRIA DE FÁCIL ACESSO PARA MAIOR COMODIDADE DA CRIANÇA", 
                "Bicicletas", 89.50
    add_product "BLAST 140", 
                "DE 4 A 6 ANOS.RODAS LATERAIS ESTABILIZADORAS PARA AJUDA NA 
                APRENDIZAGEM.QUADRO DE FÁCIL ACESSO", 
                "Bicicletas", 85.27
    add_product "CHARM 160", 
                "Meninas entre os 5 e 7 anos Quadro com geometria 
                de fácil acesso. Manetes de travão adaptadas a mãos de criança", 
                "Bicicletas", 74.98
    add_product "CHARM 203 2012", 
                "iniciação ao btt Para menina com idades entre os 7 e os 9 anos Quadro com 
                geometria de fácil acesso Bicicleta de iniciação para crianças com 
                idades entre os 7 e os 9 anos", 
                "Bicicletas", 109.15
    add_product "BLAST 203 2012", 
                "Iniciação ao btt Para menina com idades entre os 7 e os 9 anos Quadro com 
                geometria de fácil acesso Bicicleta de iniciação para crianças com 
                idades entre os 7 e os 9 anos", 
                "Bicicletas", 105.99
    add_product "EASY 2,1", 
                "QUADRO DOBRÁVEL em alumínio PARA UMA ARRUMAÇÃO 
                PRÁTICA/QUADRO COM DOBRADIÇA SIMPLES E FÁCIL DE USAR", 
                "Bicicletas", 199.99
    add_product "TRAILROCK 1.7 X 2011", 
                "Passeios ocasionais em caminhos Dupla suspensão para maior 
                conforto em caminhos Travão de disco mecânico para uma travagem forte", 
                "Bicicletas", 199.90
    add_product "CROSSTOWN 5.0 2011", 
                "FITNESS BIKE - USO FREQUENTE EM ESTRADA PARA PASSEIOS E EXERCICIO 
                FÍSICO REGULAR. QUADRO LIGEIRO EM ALUMÍNIO. FORQUETA RÍGIDA EM 
                ALUMÍNIO PARA UMA MELHOR PERFORMANCE TRAVÕES HIDRÁULICOS PARA 
                UMA TRAVAGEM POTENTE", 
                "Bicicletas", 399.90
    add_product "CROSSTOWN 6,0 2012", 
                "FITNESS BIKE.Paseios e exercicio regular com conforto.Suspensão 
                SwingShock inovadora bastante rigida e amortece pequenos impactos.
                Travões de disco mecanicos para uma travagem forte", 
                "Bicicletas", 449.99
    add_product "QUADRO VERTEX 9.0 CA", "QUADRO VERTEX 9.0 CARBON 2011", "Bicicletas", 490.90
    add_product "TRAIL 4.9 2012", 
                "PAsSEIOS FREQUENTES EM TRILHOS XC.FORQUETA RSHOX RECON A AR PARA UM AJUSTE 
                MAIS SENSÍVEL PARA AS IMPERFEIÇÕES DO TERRENO.RODAS MAVIC CROSSRIDE PARA UM 
                MENOR PESO E MAIOR RESISTÊNCIA.TRANSMISSÃO 30V COM DESVIADOR TRAS DEORE XT", 
                "Bicicletas", 799.90
    add_product "FUEGO 8.5", 
                "TREINOS FREQUENTES EM ESTRADA#QUADRO LIGEIRO EM ALUMINIO PARA MELHORAR 
                A SUA PERFORMANCE EM MÉDIAS/LONGAS DISTÂNCIAS", 
                "Bicicletas", 599.90
    add_product "Luvas ciclismo", "", "Acessórios", 4.90
    add_product "Meias ciclismo", "", "Acessórios", 4.90
    add_product "Mini Fireman", "", "Acessórios", 4.99
    add_product "W15 Animals", 
                "Concebido para a prática de ciclismo;-Ideal para crianças dos 
                3 aos 10 anos;-8 Aberturas", 
                "Acessórios", 12.90
    add_product "Óculos ciclismo", "", "Acessórios", 14.99
    add_product "Corta vento CY 36", "Extremamente leve; Bandas reflectoras", "Acessórios", 15.92
    add_product "Luva Stuka BG 1006", "Tecido transpirável e com rede", 
                "Acessórios", 16.90
    add_product "BMX", "", "Acessórios", 19.90

    puts '>>>> Produtcts: Fitness'
    add_product "Tapete Aeróbia", 
                "Dimensões: 1500*600*;
                Espessura/Densidade: 7mm", 
                "Acessórios de Fitness", 2.90
    add_product "Mola Mão", "Material: ferro/espuma", "Acessórios de Fitness", 4.99
    add_product "Corda Aeróbia", 
                "Dimensões: 2.65 metros;
                Pega: espuma;
                Regulação/Ajuste: Sem Ajuste", 
                "Acessórios de Fitness", 6.99
    add_product "Conjunto Tonificação", 
                "Bolas de tonificação de 1, 2 e 3 Kg e suporte para arrumação fácil", 
                "Acessórios de Fitness", 7.99
    add_product "KIT bateria WEARLINK", "", "Acessórios de Fitness", 8.99
    add_product "KIT bateria CS400 CS", "", "Acessórios de Fitness", 8.99
    add_product "Bola medicinal 2 KGS", "Centro de látex sólido equilibrado", 
                "Acessórios de Fitness", 19.99
    add_product "Elástico Resistente forte", "", "Acessórios de Fitness", 19.99
    add_product "Conjunto YOGA", "", "Acessórios de Fitness", 24.99
    add_product "Disco 1KG Ferro", "", "Acessórios de Musculação", 1.50
    add_product "Disco 2KG Ferro", "", "Acessórios de Musculação", 3.00
    add_product "Barras Halteres", "", "Acessórios de Musculação", 3.49
    add_product "Disco 2KG Cromado", "", "Acessórios de Musculação", 4.60
    add_product "Luvas Fitness", "", "Acessórios de Musculação", 6.99
    add_product "Barra Cromada 1200MM", 
                "TRABALHO DE MUSCULAÇÃO PARA AUMENTO DA MASSA MUSCULAR, DEFINIÇÃO 
                DOS MÚSCULOS E REDUÇÃO DA GORDURA CORPORAL", 
                "Acessórios de Musculação", 21.99
    add_product "Halteres", 
                "TRABALHO DE MUSCULAÇÃO PARA AUMENTO DA MASSA MUSCULAR, 
                DEFINIÇÃO DOS MÚSCULOS E REDUÇÃO DA GORDURA CORPORAL", 
                "Acessórios de Musculação", 14.90
    add_product "Barra Cromada 1500MM", 
                "TRABALHO DE MUSCULAÇÃO PARA AUMENTO DA MASSA MUSCULAR, 
                DEFINIÇÃO DOS MÚSCULOS E REDUÇÃO DA GORDURA CORPORAL", 
                "Acessórios de Musculação", 26.99
    add_product "Barra", 
                "TRABALHO DE MUSCULAÇÃO PARA AUMENTO DA MASSA MUSCULAR, 
                DEFINIÇÃO DOS MÚSCULOS E REDUÇÃO DA GORDURA CORPORAL", 
                "Acessórios de Musculação", 9.99
    add_product "Cotoveleira", "", "Proteção Desportiva", 15.98
    add_product "Pulso", "", "Proteção Desportiva", 14.20
    add_product "Suporte Cotovelo TÉN", "", "Proteção Desportiva", 14.20


    ########### Brands ###########
    puts '>> Brands'
    def find_brand(name)
      pc = PlazrStore::Brand.find_by_name(name)
    end

    def add_brand(name)
      return if find_brand(name)
      
      PlazrStore::Brand.create  name: name
    end

    add_brand "Plazr"
    add_brand "NIKE"
    add_brand "Adidas"
    add_brand "Umbro"
    add_brand "Speedo"
    add_brand "Reebook"
    add_brand "Deeply"
    add_brand "Berg"
    add_brand "Mikasa"
    add_brand "Pulma"
    add_brand "BMX"

    puts '>> Product.Brands'
    def product_define_brand(productname, brandname)
        p = PlazrStore::Product.find_by_name(productname)
        b = PlazrStore::Brand.find_by_name(brandname)
        p.brand = b
        p.save
    end

    # product_define_brand "Braçadeira", ""
    # product_define_brand "Cartões", ""
    product_define_brand "Apíto", "Adidas"
    # product_define_brand "Caneleira", "Sport Zone"
    # product_define_brand "Ginga", "Sport Zone"
    # product_define_brand "SPZ EURO12", "Sport Zone"
    # product_define_brand "Portugal Supporer's", ""
    product_define_brand "League PRO", ""
    # product_define_brand "Futsal Academy", ""
    product_define_brand "FL450-YGR", "Mikasa"
    # product_define_brand "HY-5006 MS", ""
    # product_define_brand "AGILE-FG JR", ""
    # product_define_brand "AGILE-IC", ""
    product_define_brand "F5 IN J", "Adidas"
    product_define_brand "Calções Guarda-Redes", "Plazr"
    product_define_brand "NIKE GK Classic", "NIKE"
    product_define_brand "Response YP", "Adidas"
    product_define_brand "Response Graphic", "Adidas"
    product_define_brand "V6.11", "Pulma"
    # product_define_brand "Meias Futebol", ""
    # product_define_brand "T-SHIRT", ""
    # product_define_brand "Saco Mochila", ""
    product_define_brand "BLAST 120 GREEN 2011", "Plazr"
    product_define_brand "BLAST 140", "Plazr"
    product_define_brand "CHARM 160", "Plazr"
    product_define_brand "CHARM 203 2012", "Plazr"
    product_define_brand "BLAST 203 2012", "Plazr"
    product_define_brand "EASY 2,1", "Plazr"
    # product_define_brand "TRAILROCK 1.7 X 2011", ""
    product_define_brand "CROSSTOWN 5.0 2011", "Berg"
    product_define_brand "CROSSTOWN 6,0 2012", "Berg"
    product_define_brand "QUADRO VERTEX 9.0 CA", "Berg"
    product_define_brand "TRAIL 4.9 2012", "Berg"
    product_define_brand "FUEGO 8.5", "Berg"
    product_define_brand "BMX", "BMX"
    product_define_brand "Bola medicinal 2 KGS", "Reebook"
    # product_define_brand "Meias ciclismo", ""
    # product_define_brand "Mini Fireman", ""
    # product_define_brand "W15 Animals", ""

  end
end
