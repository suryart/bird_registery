module API
  module V1
    class Birds < Grape::API
      version 'v1', using: :path, vendor: 'bird_registery'

      helpers do
        def find_bird
            @bird = Bird.find(params[:id])
          rescue Mongoid::Errors::DocumentNotFound => ex
            error! :not_found, 404
        end
      end
 
      resources :birds do
 
        desc 'Returns all birds'
        get '', rabl: '/v1/index' do
          @birds = Bird.only(:id).all
        end
 
        desc "Return a specific bird"
        params do
          requires :id, type: String
        end
        get ':id', rabl: '/v1/show' do
          find_bird
        end

        desc 'Create a bird'
        params do
          requires :bird, type: Hash do
            requires :name, type: String
            requires :family, type: String
            requires :continents, type: Array
            optional :added, type: String
            optional :visible, type: Boolean
          end
        end
        post '', rabl: '/v1/show' do
          @bird = Bird.register(params[:bird])
        end

        desc "Delete a bird"
        params do
          requires :id, type: String
        end
        delete ':id' do
          find_bird
          @bird.destroy
        end
 
      end

    end
  end
end
 