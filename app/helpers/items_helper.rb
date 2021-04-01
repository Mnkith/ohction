module ItemsHelper

  def diplay_all_items
    Items.all.each do |item|
      tag.div class="row  g-0" do
    tag.div class="col-4 " do
      tag.div class="card" style="width: 18rem;" do
        tag.div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel" do
          tag.div class="carousel-inner" do
            tag.div class="carousel-item active p-1 border bg-dark" do
              item.images.each do |image|
               image_tag image.image_path, class:"d-block w-30 img-fluid"
            end
            # tag.div class="carousel-item  p-1 border bg-dark " do
            #    image_tag "signin-image.jpg", class:"d-block w-30 img-fluid"
            # end
            # tag.div class="carousel-item  p-1 border bg-dark" do
            #    image_tag "signup-image-2.jpg", class:"d-block w-30 img-fluid"
            # end
          end
        end
        tag.div class="card-body " do
          h5 class="card-title">Card title/h5
          # p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content./p
        end
        ul class="list-group list-group-flush"
          li class="list-group-item">An item/li
          li class="list-group-item">A second item/li
          li class="list-group-item">A third item/li
        /ul
        tag.div class="card-body" do
          a href="#" class="card-link">Card link/a
          a href="#" class="card-link">Another link/a
        end
      end
    end
    end
  end
end