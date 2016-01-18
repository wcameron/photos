<photo-gallery>
    <section class="photo-gallery">
        <div class="photo-gallery-wrapper"
             riot-style="width: { galleryWidth() }px; left: -{ getSlideOffset() }px ">
            <photo-list class="photos">
                <photo-item each={ photo, i in photos }>
                </photo-item>
            </photo-list>
        </div>
    </section>
    <div class="photo-gallery__control" onclick={ prevPhoto }>Previous</div>
    <div class="photo-gallery__control" onclick={ nextPhoto }>Next</div>

    <script>
        'use strict';

        let self = this
        this.photoHeight = opts.maxHeight
        this.photos = []
        this.galleryIndex = 0


        isActivePhoto (index){
            return this.galleryIndex === index
        }

        getSlideOffset(){
            let width = 0

            for (var i = 0; i < this.galleryIndex; i++){
                width += (this.photos[i].width / (this.photos[i].height / this.photoHeight)) - 36
            }

            if (this.galleryIndex === this.photos.length -1) {
                width = (this.trueGalleryWidth() - window.innerWidth)
            }

            return width;
        }

        nextPhoto(){
            ++this.galleryIndex
            if (this.galleryIndex >= this.photos.length) {
                this.galleryIndex = 0
            }
        }

        prevPhoto(){
            --this.galleryIndex
            if (this.galleryIndex < 0) {
                this.galleryIndex = this.photos.length - 1
            }
        }

        selectPhoto(e){
            this.galleryIndex = e.item.i
        }

        galleryWidth(){
            return this.photos.reduce((sum, photo) => sum += photo.width / (photo.height / this.photoHeight), 0) + 1000
        }

        trueGalleryWidth() {
            return this.photos.reduce((sum, photo) => sum += photo.width / (photo.height / this.photoHeight), 0)
        }

        function init() {
            const flickrBase = 'https://api.flickr.com/services/rest'
            $.ajax({
                url: flickrBase,
                data: {
                    method: 'flickr.photosets.getPhotos',
                    photoset_id: '72157659542494996',
                    api_key: 'dd8e8543a12f7d465f8e8e59b749202c',
                    user_id: '134947814@N05',
                    format: 'json',
                    extras: 'o_dims,url_h,url_l',
                    nojsoncallback: true
                }
            }).done(function(response){
                response.photoset.photo.forEach(function(img, index){
                    self.photos.push({
                        url: img.url_h,
                        width: parseInt(img.width_h, 10),
                        height: parseInt(img.height_h, 10)
                    });
                    self.update()
                })
            })
        }

        init()

    </script>
</photo-gallery>
