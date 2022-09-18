class BlogPost < ApplicationRecord
    mount_uploader :post_intro, PostIntroUploader
end
