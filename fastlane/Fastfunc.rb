
def build_ipa(config)
  #unlock_keychain(
  #  path: "login.keychain",
  #  password: ENV['FL_KEYCHAIN_PASSWORD']
  #)
  # sh 'security unlock-keychain -u ~/Library/Keychains/login.keychain'
  gym(
    workspace: ENV['FL_WORKSPACE_PATH'],
    scheme: ENV['FL_SCHEME'],
    clean: true,
    output_directory: File.expand_path("#{ENV['FL_OUTPUT_ROOT_DIRECTORY']}/archive/#{config}/ipa"),
    output_name: "#{config}.ipa",
    configuration: config,
    silent: true,
    include_bitcode: true,
    export_method: "development",
    build_path: File.expand_path("#{ENV['FL_OUTPUT_ROOT_DIRECTORY']}/archive/#{config}/archive"),
    destination: "generic/platform=iOS"
  )
end

### deploy to pgyer (Release platform)
def deploy_to_pgyer(config, user_key, api_key)
  pgyer(
    file: File.expand_path("#{ENV['FL_OUTPUT_ROOT_DIRECTORY']}/archive/#{config}/ipa/#{config}.ipa"),
    user_key: user_key,
    api_key: api_key
  )
end
