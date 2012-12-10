#
#  WindowController.rb
#  Slim
#
#  Created by Daniel Schmidt on 09.12.12.
#  Copyright 2012 Daniel Schmidt. All rights reserved.
#
class WindowController < NSWindowController
  attr_accessor :convertBtn, :dropView
  
  def convertBtnClicked(sender)
    file_path = dropView.file
    content = File.open(file_path, "r").read
    api_uri = "http://slim-convert.herokuapp.com/v1"
    result = RestClient.post "#{api_uri}/slim/convert", :source => content
    encoded = MultiJson.load(result)
    if encoded["success"]
      path_prefix = NSHomeDirectory()
      html_path = "#{path_prefix}/Desktop/#{File.basename(file_path, '.slim')}.html"
      File.open(html_path, 'w') do |file|
        file.write(encoded["result"])
      end
      message   = "Success!"
      info_text = "Find your file at #{html_path}"
    else
      message = "Failed"
      info_text = encoded["error"]
    end
    dropView.setDropStateImage
    alert(:message => message, :info_text => info_text)
  end
  
  # PUBLIC - Displays an NSAlert.
  #
  # Display a modal NSAlert with a "OK" Button.
  #
  # options - The hash options to define the content of the NSAlert.
  #           :message    - The message which appears as "headline"
  #           :info_text  - The message to use as an informational text
  def alert(options={})
    message   = options.fetch(:message, "")
    info_text = options.fetch(:info_text, "")
    alert = NSAlert.alertWithMessageText(message,
                                         defaultButton: "OK",
                                         alternateButton:nil,
                                         otherButton: nil,
                                         informativeTextWithFormat: info_text)
    
    alert.runModal()
  end
  
end

