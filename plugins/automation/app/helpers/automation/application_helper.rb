module Automation
  module ApplicationHelper

    def flash_box(key, value)
      haml_tag :p, {class: "alert alert-#{key.to_s}", role: "alert"} do
        haml_concat value.to_s
      end
    end

    def date_humanize(date)
      " #{date}".to_time(:local).strftime('%a %b %d %H:%M:%S %Z %Y')
    end

    def form_horizontal_static_input(label, value)
      haml_tag :div, {class: "form-group"} do
        haml_tag :label, {class: "col-sm-4 control-label"} do
          haml_concat label
        end
        haml_tag :div, {class: "col-sm-8"} do
          haml_tag :div, {class: "form-control-static"} do
            haml_concat value
          end
        end
      end
    end

    def form_horizontal_static_hash(label, data)

      haml_tag :div, {class: "form-group"} do
        haml_tag :label, {class: "col-sm-4 control-label"} do
          haml_concat label
        end
        haml_tag :div, {class: "col-sm-8"} do

          if !data.blank? && !data.attributes.empty?
            haml_tag :div, {class: "form-control-static"} do
              haml_tag :div, {class: "static-tags clearfix"} do

                data.attributes.each do |key, value|
                  haml_tag :div, {class: "tag"} do
                    haml_tag :div, {class: "key"} do
                      haml_concat key
                    end
                    haml_tag :div, {class: "value"} do
                      haml_concat value
                    end
                  end
                end

              end
            end
          end

        end
      end



    end

    def form_horizontal_static_array(label, data)
      haml_tag :div, {class: "form-group"} do
        haml_tag :label, {class: "col-sm-4 control-label"} do
          haml_concat label
        end
        haml_tag :div, {class: "col-sm-8"} do

          if !data.blank?
            haml_tag :div, {class: "form-control-static"} do
              haml_tag :div, {class: "static-tags clearfix"} do

                data.each do |value|
                  haml_tag :div, {class: "tag"} do
                    haml_tag :div, {class: "value"} do
                      haml_concat value
                    end
                  end
                end
              end
            end
          end

        end
      end
    end

    #
    # Jobs
    #

    def job_history_entry(status)
      case status
        when 'queued'
          haml_tag :i, {class: "fa fa-square state_success", data: {popover_type: 'job-history'}}
        when 'executing'
          haml_tag :i, {class: "fa fa-spinner fa-spin", data: {popover_type: 'job-history'}}
        when 'failed'
          haml_tag :i, {class: "fa fa-square state_failed", data: {popover_type: 'job-history'}}
        when 'complete'
          haml_tag :i, {class: "fa fa-square state_success", data: {popover_type: 'job-history'}}
      end
    end

    def job_state(status)
      case status
        when State::Job::FAILED
          haml_tag :span, {class: "state_failed"} do
            haml_concat status.to_s
          end
        else
          haml_tag :span do
            haml_concat status.to_s
          end
      end
    end

    #
    # Automations
    #

    def selected_automation_type(type)
      if type.blank?
        return 'chef'
      else
        type.downcase
      end
    end

    def hide_chef_automation(type)
      if type.blank?
        return false
      else
        if type.downcase == 'chef'
          return false
        end
      end
      return true
    end

    def hide_script_automation(type)
      if type.blank?
        return true
      else
        if type.downcase == 'script'
          return false
        end
      end
      return true
    end

    #
    # Runs
    #

    def run_state(state, state_string)
      case state
        when State::Run::FAILED
          haml_tag :span, {class: "state_failed"} do
            haml_concat state_string
          end
        else
          haml_tag :span do
            haml_concat state_string
          end
      end
    end

    def run_polling?(state)
      if state == ::Automation::State::Run::FAILED || state == ::Automation::State::Run::COMPLETED
        false
      else
        true
      end
    end

  end
end
