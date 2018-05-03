require 'elektron'
require 'colorize'

module ElektronMiddlewares
  class DebugLogger < Elektron::Middlewares::Base

    # def call(request_context)
    #   debug = request_context.options.delete(:debug)
    #
    #   if debug
    #     path = URI(URI.escape(request_context.path))
    #     if request_context.params && !request_context.params.empty?
    #       path.query = URI.encode_www_form(request_context.params)
    #     end
    #
    #     output = ''
    #     output += "\033[1;36mElektron #{request_context.service_name} " \
    #               "(#{request_context.options[:region]}/" \
    #               "#{request_context.options[:interface]}):\n"
    #     output += "\033[1;34m-> #{request_context.http_method.upcase} " \
    #               "#{request_context.service_url}#{path}\n"
    #
    #     unless request_context.options[:headers].empty?
    #       output += "\033[1;34m-> headers: #{request_context.options[:headers]}\n"
    #     end
    #
    #     output += "\033[1;34m-> body: #{request_context.data}\n" if request_context.data
    #     output += "\033[0m"
    #     Rails.logger.debug(output)
    #   end
    #
    #   response = @next_middleware.call(request_context)
    #
    #   if debug
    #     output = "\033[1;34m<- #{response.header.class.name}"
    #     output += "\n\033[1;34m<- body:  #{response.body}" if response.body
    #     output += "\033[0m"
    #     Rails.logger.debug(output)
    #   end
    #
    #   response
    # end

    def call(request_context)
      debug = request_context.options.delete(:debug)

      # return response unless debug
      return @next_middleware.call(request_context) unless debug

      # log debug output
      begin
        path = URI(URI.escape(request_context.path))
        if request_context.params && request_context.params.size.positive?
          path.query = URI.encode_www_form(request_context.params)
        end

        # puts String.colors

        Rails.logger.debug(
          "Elektron #{request_context.service_name} " \
          "(#{request_context.options[:region]}/" \
          "#{request_context.options[:interface]}):".colorize(color: :cyan, mode: :bold)
        )

        output = "-> #{request_context.http_method.upcase} " \
                 "#{request_context.service_url}#{path}"

        unless request_context.options[:headers].empty?
          output += "\n-> headers: #{request_context.options[:headers]}"
        end
        output += "\n-> body: #{request_context.data}" if request_context.data

        # mark outgoing data blue
        output = output.split("\n").collect do |t|
          t.colorize(color: :blue, mode: :bold)
        end.join("\n")
        Rails.logger.debug(output)

        response = @next_middleware.call(request_context)

        output = "<- #{response.header.class.name}"
        output += "\n<- body:  #{response.body}" if response.body
        # mark incoming data blue
        output = output.split("\n").collect do |t|
          t.colorize(color: :blue, mode: :bold)
        end.join("\n")
        Rails.logger.debug(output)

        return response
      rescue StandardError => e
        output =  '<- Error'
        output =  "<- #{e.code_type}" if e.respond_to?(:code_type)
        output += " (#{e.code})" if e.respond_to?(:code)
        output += "\n<- #{e.message}"
        output = output.split("\n").collect do |t|
          t.colorize(color: :red, mode: :bold)
        end.join("\n")
        Rails.logger.debug(output + "\n")
        raise e
      end
    end
  end
end
