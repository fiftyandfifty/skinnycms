# Here I patch Paperclip::Geomatry::Class.from_file to modify the file parameter
# to be the fully-realized CloudFiles pubic URL. Otherwise from_file uses the non-fully-realized URL.
# Therefore ImageMagick's inspect totally fails to find it.  It's handy that ImageMagick can inspect http
# locations, so that saves the day.  But I'm sure that's insanely inefficient.  It might be better if
# this instead operated on the original temporary files created in the initial processing to avoid
# all the network IO.
module Paperclip
    class Geometry
        class <<self
            alias_method :from_file_original, :from_file
            def from_file file
                if file.is_a? CloudFiles::StorageObject
                    self.from_file_original file.public_url
                else
                    self.from_file_original file
                end
            end
        end
    end
end

# Here I'm just aliasing CloudFiles::StorageObject::read to CloudFiles::StorageObject::data because
# the CloudFiles fork of Paperclip calls .read as if it's a file during reprocess! and explodes.
# Just needs the raw data handed to it.  Again, this is probably stupid inefficient due to network IO.
module CloudFiles
    class StorageObject
        def read
            return self.data
        end
    end
end
