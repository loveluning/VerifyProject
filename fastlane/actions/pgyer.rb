module Fastlane
  module Actions
    module SharedValues
      PGYER_CUSTOM_VALUE = :PGYER_CUSTOM_VALUE
    end

    class PgyerAction < Action
      def self.run(params)

        command = []
        command << "curl"
        command << "-F file=@#{params[:file]}"
        command << "-F uKey=#{params[:user_key]}"
        command << "-F _api_key=#{params[:api_key]}"

        if params[:install_type]
          command << "-F instalType=#{params[:install_type]}"
        end
        if params[:password]
          command << "-F password=#{params[:password]}"
        end
        if params[:update_description]
          command << "-F updateDescription=#{params[:update_description]}"
        end

        command << "https://qiniu-storage.pgyer.com/apiv1/app/upload"
        Actions.sh(command.join(' '))
        UI.message "Upload to pgyer.im successful ⬆️ "
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Upload ipa or apk to pgyer"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can upload your ipa or apk to pgyer.com"
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :file,
                                       env_name: "FL_PGYER_FILE_PATH",
                                       description: "需要上传的ipa或者apk文件",
                                       is_string: true,
                                       verify_block: proc do |value|
                                          file_path = File.expand_path(value.to_s)
                                          File.exist?(file_path) and (File.extname(file_path) == ".ipa" or File.extname(file_path) == ".ipa")
                                       end
                                       ),

          FastlaneCore::ConfigItem.new(key: :user_key,
                                       env_name: "FL_PGYER_USER_KEY",
                                       description: "(必填) 用户Key ",
                                       is_string: true
                                       ),

          FastlaneCore::ConfigItem.new(key: :api_key,
                                       env_name: "FL_PGYER_API_KEY",
                                       description: "(必填) API Key",
                                       is_string: true
                                       ),

          FastlaneCore::ConfigItem.new(key: :install_type,
                                       env_name: "FL_PGYER_INSTALL_TYPE",
                                       description: "(选填)应用安装方式，值为(1,2,3)。1：公开，2：密码安装，3：邀请安装。默认为1公开",
                                       is_string: false,
                                       default_value: 1
                                       ),

          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "FL_PGYER_DOWNLOAD_PASSWORD",
                                       description: "(选填) 设置App安装密码，如果不想设置密码，请传空字符串，或不传。",
                                       is_string: true,
                                       default_value: ""
                                       ),

          FastlaneCore::ConfigItem.new(key: :update_description,
                                       env_name: "FL_PGYER_UPDATE_DESCRIPTION",
                                       description: "(选填) 版本更新描述，请传空字符串，或不传。",
                                       is_string: true,
                                       default_value: ""
                                       )
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['PGYER_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["wangcccong"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #
        [:ios, :android].include?(platform)
      end
    end
  end
end
