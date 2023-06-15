require 'open-uri'
require 'unsplash'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Point.destroy_all
Ride.destroy_all
Favorite.destroy_all

User.all.each { |user| user.update!(pinned_route_id: nil) }
Route.destroy_all
User.destroy_all

user1 = User.create!(first_name: "Joao", email: "joao@gmail.com", password: "123123")
user2 = User.create!(first_name: "Paulo", email: "paulo@gmail.com", password: "123123")
user3 = User.create!(first_name: "Alphonse", email: "alphadeny@hotmail.fr", password: "123123")
user4 = User.create!(first_name: "Thiago", email: "thiago@olatu.com", password: "123123")
user5 = User.create!(first_name: "Julia", email: "juliavdheyde@icloud.com", password: "123123")

Unsplash.configure do |config|
  config.application_access_key = ENV["ACCESS_KEYS"]
  config.application_secret = ENV["APPLICATION_SECRET"]
  #config.application_redirect_uri = "https://your-application.com/oauth/callback"
  config.utm_source = "bike_tourism_app"

  route1 = Route.new(
    name: "Rota Parque do Ibirapuera",
    description: "Trilha muito tranquilha ao redor do Parque",
    type_of_route: "Urban",
    positive_elevation: 1.5,
    creator: user3
  )

  route2 = Route.new(
    name: "Rota Centro de SP",
    description: "passeio pelo pontos históricos no centro da cidade",
    type_of_route: "Urban",
    positive_elevation: 2.9,
    creator: user5
  )

  route3 = Route.new(
    name: "Trilha da Pedra Bonita",
    description: "Trilha montanhosa",
    type_of_route: "Mountain",
    positive_elevation: 10.1,
    creator: user5
  )

  route4 = Route.new(
    name: "Trilha do Caixa D'aço",
    description: "Trilha leve, paisagens bonitas",
    type_of_route: "Suburban",
    positive_elevation: 5.1,
    creator: user3
  )

  route5 = Route.new(
    name: "Parque Municipal (Trilha da Pontinha)",
    description: "Passeio leve pelo centro da cidade",
    type_of_route: "Urban",
    positive_elevation: 5.1,
    creator: user5
  )

  route6 = Route.new(
    name: "Trilha Morro do Castelo",
    description: "Passeio agradável em meio a natureza",
    type_of_route: "Moutain",
    positive_elevation: 10.1,
    creator: user4
  )

  route7 = Route.new(
    name: "Trilha Pedra da Gávea",
    description: "Passeio turístico",
    type_of_route: "Suburban",
    positive_elevation: 6.2,
    creator: user2
  )

  route8 = Route.new(
    name: "Trilha do Morro da Urca",
    description: "Pedal agradável em meio a natureza",
    type_of_route: "Mountain",
    positive_elevation: 13.2,
    creator: user1
  )

  route9 = Route.new(
    name: "Vila Madalena",
    description: "Pedal agradável pela Vila Madalena",
    type_of_route: "Mountain",
    positive_elevation: 13.2,
    creator: user1
  )

  route10 = Route.new(
    name: "Morro do Careca",
    description: "Pedal em meio a natureza, incrível",
    type_of_route: "Mountain",
    positive_elevation: 11.1,
    creator: user2
  )

  route1.save(validate: false)
  route2.save(validate: false)
  route3.save(validate: false)
  route4.save(validate: false)
  route5.save(validate: false)
  route6.save(validate: false)
  route7.save(validate: false)
  route8.save(validate: false)
  route9.save(validate: false)
  route10.save(validate: false)

  coordinates = [
    [-23.442864647150547, -46.774944091838236],
    [-23.443652042248406, -46.772733962786326],
    [-23.44728535490771, -46.772373403454196],
    [-23.450993849417785, -46.77316215199228],
    [-23.44968232057618, -46.7654225569623],
    [-23.451709873668655, -46.76633455406208],
    [-23.453146894935216, -46.76647407787007],
    [-23.45547267151323, -46.76657391345817],
    [-23.45745097397038, -46.765919444006045],
    [-23.457474156473904, -46.76705879170353],
    [-23.458350134024258, -46.7669407858058]
  ]

  coordinates.each do |coordinate|
    route1.points
    route1.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-23.442864647150547, -46.774944091838236],
    [-23.443652042248406, -46.772733962786326],
    [-23.44728535490771, -46.772373403454196],
    [-23.450993849417785, -46.77316215199228],
    [-23.44968232057618, -46.7654225569623],
    [-23.451709873668655, -46.76633455406208],
    [-23.453146894935216, -46.76647407787007],
    [-23.45547267151323, -46.76657391345817],
    [-23.45745097397038, -46.765919444006045],
    [-23.457474156473904, -46.76705879170353],
    [-23.458350134024258, -46.7669407858058]
  ]
  coordinates.each do |coordinate|
    route2.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-22.98529882286031, -43.27897594508012],
    [-22.984706200314072, -43.279362183143604],
    [-22.98421234620615, -43.27932999663831],
    [-22.983995049826664, -43.280102472765286],
    [-22.984034558285302, -43.280113201600386],
    [-22.983896278629537, -43.2807032875307],
    [-22.983688858880498, -43.281239729285545],
    [-22.98399106118348, -43.28224976186913],
    [-22.9845944435344, -43.281658603793225],
    [-22.98551725838734, -43.281710008843305],
    [-22.98665147814123, -43.282642005392894],
    [-22.98768188159006, -43.282749390772864],
    [-22.98900691680958, -43.283006416023255],
    [-22.98956295450257, -43.28381604556199],
    [-22.989350004167246, -43.28424013722513],
  ]
  coordinates.each do |coordinate|
    route3.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-23.349099549619414, -44.722810183864986],
    [-23.35255677461346, -44.722810183864986],
    [-23.354544638202817, -44.72045665252072],
    [-23.35549534504462, -44.72045665252072],
    [-23.356186763923773, -44.721303923804655],
    [-23.356600471286487, -44.72217293872049],
    [-23.35578296019619, -44.722945379196396],
    [-23.354755053895197, -44.72465133693789],
    [-23.353671602311053, -44.72524138898459],
    [-23.35365188501628, -44.72637865962061],
    [-23.35391783133494, -44.727344298244525],
    [-23.354508775216694, -44.72857811914447],
    [-23.355730156675023, -44.730112326552536],
    [-23.356744702885724, -44.730959881048484],
    [-23.358054682120677, -44.73171092152455],
    [-23.359066873477634, -44.73220212156494],
    [-23.360354272522148, -44.73225047825679],
    [-23.3604921760904, -44.73248653739641],
    [-23.36063007594711, -44.73228265512053],
    [-23.36093541471608, -44.73267966993646],
    [-23.361418001634977, -44.73259387231639],
    [-23.362107434385535, -44.732411512792375],
    [-23.362570348541436, -44.731381544536404]
  ]
  coordinates.each do |coordinate|
    route4.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-23.76663060399539, -46.29813638431848],
    [-23.76885831424244, -46.30066331109054],
    [-23.77109698226227, -46.298671898670335],
    [-23.77215739050955, -46.297599015097894],
    [-23.77338489541415, -46.29788472100004],
    [-23.774336075406413, -46.298002150791945],
    [-23.77488913607393, -46.297986246937256],
    [-23.775791493166828, -46.29754093900584],
    [-23.77602435849709, -46.29804986235603],
    [-23.776184453169776, -46.29839974715928],
  ]
  coordinates.each do |coordinate|
    route5.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-12.777480783748956, -41.45746292174538],
    [-12.77718930512692, -41.4559685226882],
    [-12.775513296524691, -41.4552213231596],
    [-12.77382760954248, -41.45526421857609],
    [-12.77313902395945, -41.45549957167649],
    [-12.772159245201589, -41.45457970155434],
    [-12.771059269961851, -41.45438853543218],
    [-12.768960186797441, -41.45240346135905],
    [-12.764994491974772, -41.453701692380186],
    [-12.761394964622934, -41.45494623738188],
    [-12.761332208079171, -41.45248929978836],
    [-12.761803079494667, -41.449699802408915],
    [-12.76190772896081, -41.44927064979232],
    [-12.762043758263479, -41.44891659820432],
    [-12.76262972980795, -41.449227734448314],
    [-12.762943603754406, -41.44917405905237],
    [-12.763535244335811, -41.44787700072276],
    [-12.765375690144213, -41.44433348002002],
    [-12.766034900191373, -41.44299239873228],
    [-12.766568544481954, -41.44293875455228],
    [-12.766976571151043, -41.4427885995282],
    [-12.76733233281172, -41.4431211934442],
    [-12.767677630415449, -41.44255256513621],
    [-12.768148450590951, -41.442767179952135],
    [-12.768671667296422, -41.4424882534962],
    [-12.769048353572641, -41.44142609873222],
    [-12.76948782018554, -41.44149047174822],
    [-12.770494972535916, -41.4411851633928],
    [-12.770913528233791, -41.441786018048035],
    [-12.77129021116954, -41.44239756170002],
    [-12.77157272300298, -41.44321295323601],
    [-12.771311105959327, -41.445283668580146],
    [-12.77154130079136, -41.44603468710014],
    [-12.771468057003897, -41.4476440125001]
  ]
  coordinates.each do |coordinate|
    route6.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-23.002060751257382, -43.295820044819756],
    [-23.00049555927004, -43.29496412136458],
    [-22.998604801127268, -43.293815627144184],
    [-22.997649246615286, -43.294389874254385],
    [-22.99712063908583, -43.29328555288862],
    [-22.996978321320398, -43.2917836758312],
    [-22.99677500996668, -43.28913330455339],
    [-22.995941430215247, -43.28829402031541],
    [-22.995372153280982, -43.28787437819642],
    [-22.99461989079328, -43.28597494544733],
    [-22.9955551354145, -43.28544487119177],
    [-22.997811894669464, -43.28522400691862],
  ]
  coordinates.each do |coordinate|
    route7.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-22.952443181847034, -43.16085036901502],
    [-22.952534884442453, -43.16149436526352],
    [-22.952822218838968, -43.16168690022441],
    [-22.95310343914677, -43.162071970146194],
    [-22.95331741072848, -43.16223130942418],
    [-22.95344953364382, -43.16269524823645],
    [-22.9534308363976, -43.16322268863966],
    [-22.953664203571154, -43.16364185621495],
    [-22.953895538515187, -43.164445783180916],
    [-22.953864155533484, -43.16459376863582],
    [-22.95378167815686, -43.164723558868744]
  ]
  coordinates.each do |coordinate|
    route8.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-23.349099549619414, -44.722810183864986],
    [-23.35255677461346, -44.722810183864986],
    [-23.354544638202817, -44.72045665252072],
    [-23.35549534504462, -44.72045665252072],
    [-23.356186763923773, -44.721303923804655],
    [-23.356600471286487, -44.72217293872049],
    [-23.35578296019619, -44.722945379196396],
    [-23.354755053895197, -44.72465133693789],
    [-23.353671602311053, -44.72524138898459],
    [-23.35365188501628, -44.72637865962061],
    [-23.35391783133494, -44.727344298244525],
    [-23.354508775216694, -44.72857811914447],
    [-23.355730156675023, -44.730112326552536],
    [-23.356744702885724, -44.730959881048484],
    [-23.358054682120677, -44.73171092152455],
    [-23.359066873477634, -44.73220212156494],
    [-23.360354272522148, -44.73225047825679],
    [-23.3604921760904, -44.73248653739641],
    [-23.36063007594711, -44.73228265512053],
    [-23.36093541471608, -44.73267966993646],
    [-23.361418001634977, -44.73259387231639],
    [-23.362107434385535, -44.732411512792375],
    [-23.362570348541436, -44.731381544536404]
  ]
  coordinates.each do |coordinate|
    route9.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  coordinates = [
    [-12.777480783748956, -41.45746292174538],
    [-12.77718930512692, -41.4559685226882],
    [-12.775513296524691, -41.4552213231596],
    [-12.77382760954248, -41.45526421857609],
    [-12.77313902395945, -41.45549957167649],
    [-12.772159245201589, -41.45457970155434],
    [-12.771059269961851, -41.45438853543218],
    [-12.768960186797441, -41.45240346135905],
    [-12.764994491974772, -41.453701692380186],
    [-12.761394964622934, -41.45494623738188],
    [-12.761332208079171, -41.45248929978836],
    [-12.761803079494667, -41.449699802408915],
    [-12.76190772896081, -41.44927064979232],
    [-12.762043758263479, -41.44891659820432],
    [-12.76262972980795, -41.449227734448314],
    [-12.762943603754406, -41.44917405905237],
    [-12.763535244335811, -41.44787700072276],
    [-12.765375690144213, -41.44433348002002],
    [-12.766034900191373, -41.44299239873228],
    [-12.766568544481954, -41.44293875455228],
    [-12.766976571151043, -41.4427885995282],
    [-12.76733233281172, -41.4431211934442],
    [-12.767677630415449, -41.44255256513621],
    [-12.768148450590951, -41.442767179952135],
    [-12.768671667296422, -41.4424882534962],
    [-12.769048353572641, -41.44142609873222],
    [-12.76948782018554, -41.44149047174822],
    [-12.770494972535916, -41.4411851633928],
    [-12.770913528233791, -41.441786018048035],
    [-12.77129021116954, -41.44239756170002],
    [-12.77157272300298, -41.44321295323601],
    [-12.771311105959327, -41.445283668580146],
    [-12.77154130079136, -41.44603468710014],
    [-12.771468057003897, -41.4476440125001]
  ]
  coordinates.each do |coordinate|
    route10.points.create(latitude: coordinate[0], longitude: coordinate[1])
  end

  route1.distance = route1.total_distance
  route2.distance = route2.total_distance
  route3.distance = route3.total_distance
  route4.distance = route4.total_distance
  route5.distance = route5.total_distance
  route6.distance = route6.total_distance
  route7.distance = route7.total_distance
  route8.distance = route8.total_distance
  route9.distance = route9.total_distance
  route10.distance = route10.total_distance
  route1.positive_elevation = route1.total_positive_elevation
  route2.positive_elevation = route2.total_positive_elevation
  route3.positive_elevation = route3.total_positive_elevation
  route4.positive_elevation = route4.total_positive_elevation
  route5.positive_elevation = route5.total_positive_elevation
  route6.positive_elevation = route6.total_positive_elevation
  route7.positive_elevation = route7.total_positive_elevation
  route8.positive_elevation = route8.total_positive_elevation
  route9.positive_elevation = route9.total_positive_elevation
  route10.positive_elevation = route10.total_positive_elevation


  route1.save
  route2.save
  route3.save
  route4.save
  route5.save
  route6.save
  route7.save
  route8.save
  route9.save
  route10.save

  puts "routes created"

  rand(2..5).times do
    route_photo = Unsplash::Photo.random(query: "#{route1.type_of_route} Route")
    if route_photo.present?
      route1.photos.attach(io: URI.open(route_photo.urls.regular), filename: "#{route1.id}-#{route1.creator_id}", metadata: { user_id: route1.creator_id } )
      route1.save(validate: false)
    else
      puts "Failed to find a Route photo"
    end
  end

  rand(2..5).times do
    route_photo = Unsplash::Photo.random(query: "#{route2.type_of_route} Route")
    if route_photo.present?
      route2.photos.attach(io: URI.open(route_photo.urls.regular), filename: "#{route2.id}-#{route2.creator_id}", metadata: { user_id: route2.creator_id })
      route2.save(validate: false)
    else
      puts "Failed to find a Route photo"
    end
  end
  p "route1 photo posters"
  route1.photos.each do |photo|
    p photo.metadata["user_id"]
  end

  p "route2 photo posters"
  route2.photos.each do |photo|
    p photo.metadata["user_id"]
  end
end
