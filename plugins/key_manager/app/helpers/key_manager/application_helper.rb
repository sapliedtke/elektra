module KeyManager
  module ApplicationHelper

    def date_humanize(date)
      unless date.nil?
        " #{date}".to_time(:local).strftime('%Y-%m-%d %H:%M:%S %Z')
      end
    end

    def secret_status(status)
      state_class = 'state_success'
      if status != ::KeyManager::Secret::Status::ACTIVE
        state_class = 'state_failed'
      end

      haml_tag :span do
        haml_tag :i, {class: "fa fa-square #{state_class}", data: {popover_type: 'job-history'}}
        haml_concat status.capitalize
      end
    end

  end
end
