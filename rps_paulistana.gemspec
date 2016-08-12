Gem::Specification.new do |s|
    s.name = "rps_paulistana"
    s.version = "0.1.3"
    s.date = "2016-01-26"
    s.summary = "Gera arquivo RPS no layout da Prefeitura de Sao Paulo para emissao de NFe Paulistana"
    s.description = "Gera arquivo RPS no layout da Prefeitura de Sao Paulo para emissao de NFe Paulistana em lote. Versao do layout utilizada: V.002; Versao do Manual consultado: 3.5"
    s.authors = ["Julia M. Birkett"]
    s.email = "juliambirkett@gmail.com"
    s.files = Dir["lib/**/*.rb"]
    s.homepage = "http://rubygems.org/gems/rps_paulistana"
	s.add_runtime_dependency "require_all", ["= 1.3.3"]
end
