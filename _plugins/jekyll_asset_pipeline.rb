require 'jekyll_asset_pipeline'

module JekyllAssetPipeline

    # Converters
    class CoffeeScriptConverter < JekyllAssetPipeline::Converter
      require 'coffee-script'

      def self.filetype
        '.coffee'
      end

      def convert
        return CoffeeScript.compile(@content)
      end
    end

    class LessConverter < JekyllAssetPipeline::Converter
      require 'less'

      def self.filetype
        '.less'
      end

      def convert
        Dir.chdir "./_assets/stylesheets" do
          return Less::Parser.new(:paths => ['.', '_assets']).parse(@content).to_css
        end
      end
    end


    # Compressors
    class CssCompressor < JekyllAssetPipeline::Compressor
        require 'yui/compressor'

        def self.filetype
          '.css'
        end

        def compress
          return YUI::CssCompressor.new.compress(@content)
        end
      end

      # class JavaScriptCompressor < JekyllAssetPipeline::Compressor
      #   require 'yui/compressor'

      #   def self.filetype
      #     '.js'
      #   end

      #   def compress
      #     return YUI::JavaScriptCompressor.new(munge: true).compress(@content)
      #   end
      # end    

      class JavaScriptCompressor < JekyllAssetPipeline::Compressor
        require 'closure-compiler'

        def self.filetype
          '.js'
        end

        def compress
          return Closure::Compiler.new.compile(@content)
        end
      end

end