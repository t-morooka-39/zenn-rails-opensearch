module OpensearchService
  class Base
    class << self
      def client
        @client ||= OpenSearch::Client.new(host: "https://host.docker.internal:9200")
      end

      # index(RDSで言うテーブル)の作成を行う
      def create
        body = {
          mappings: {
            dynamic: false, # Disable dynamic mapping
            properties: mapping_properties
          }
        }

        client.Indices.create(index: index_name, body: body)
      end

      # indexの削除を行う
      def delete
        client.Indices.delete(index: index_name)
      end

      # indexのdocument(RDSで言うレコード)を作成する
      def create_document(obj:)
        client.create(index: index_name, id: obj[:id], body: obj[:body])
      end

      # indexのdocumentを削除する
      def delete_document(obj:)
        client.delete(index: index_name, id: obj[:id])
      end
    end
  end
end
