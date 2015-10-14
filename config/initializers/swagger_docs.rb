HOSTS = {
  development: 'http://localhost:3000',
  production: 'hackdashboard.heroku.com'
}

Swagger::Docs::Config.register_apis({
  "1.0" => {
    controller_base_path: "api/v1",
    api_file_path: "public/api/v1/",
    clean_directory: true,
    base_path: HOSTS[Rails.env.to_sym],
    camelize_model_properties: false
  }
})
