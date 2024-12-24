module OpensearchService
  module Indices
    class BookIndex < OpensearchService::Base
      class << self
        def index_name
          "books"
        end

        def mapping_properties
          # 本来は色々analyzerなどを設定するが、今回は省略
          {
            name: { type: "text" },
            author: { type: "text" },
            genres: { type: "keyword" },
            created_at: { type: "date" }
          }
        end

        # 本来はDBから登録するが、今回はFakerを使ってランダムなデータを作成
        def generate_obj
          Faker::Config.locale = :ja

          {
            id: Random.rand(1000),
            body: {
              name: Faker::Book.title,
              author: Faker::Book.author,
              genres: [ Faker::Book.genre, Faker::Book.genre ],
              created_at: Time.zone.now
            }
          }
        end
      end
    end
  end
end
