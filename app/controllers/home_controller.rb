require 'mailgun'

class HomeController < ApplicationController
    
    def index
        
    end
    def write
        @title=params[:title]
        @usr=params[:email]
        @content=params[:content]
        
        mg_client = Mailgun::Client.new("key-8cb1fc9b9450b095d5ada2e6493da4b7")

        message_params =  {
                   from: 'jake89577@gmail.com',
                   to:   @usr,
                   subject: @title,
                   text:    @content
                  }

        result = mg_client.send_message('sandboxaa67a8e14d744952ba627f6d2752063d.mailgun.org', message_params).to_h!

        message_id = result['id']
        message = result['message']
        new_post = Post.new
        new_post.title =@title
        new_post.content=@content
        new_post.save
        redirect_to "/list"
    end
    def list
        @every= Post.all.order("id asc")
    end
end
