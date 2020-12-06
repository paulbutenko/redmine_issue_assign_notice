require 'httpclient'

module RedmineIssueAssignNotice
  class NoticeClient
    def notice(message, url, channel = nil)

      params = {
        :text => message
      }
      params[:channel] = channel if channel.present?

      begin
        client = HTTPClient.new
        client.ssl_config.cert_store.set_default_paths
        client.ssl_config.ssl_version = :auto
        client.post_async url, {:payload => params.to_json}
      rescue Exception => e
        Rails.logger.warn("cannot connect to #{url}")
        Rails.logger.warn(e)
      end
    end
  end
end