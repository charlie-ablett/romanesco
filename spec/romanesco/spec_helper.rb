APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
$: << File.join(APP_ROOT, 'lib/romanesco')
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| require(File.basename(f, '.rb')) }

