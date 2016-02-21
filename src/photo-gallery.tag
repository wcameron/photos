<photo-gallery>
    <div class="photo-gallery-wrapper"
         riot-style="width: { galleryWidth() }px; left: -{ getSlideOffset() }px ">
        <photo-list class="photos">
            <photo-item each={ photos }></photo-item>
        </photo-list>
    </div>
    <div class="photo-gallery__control" onclick={ prevPhoto }>Previous</div>
    <div class="photo-gallery__control" onclick={ nextPhoto }>Next</div>

    <script type="es6">
        'use strict'

        this.photoHeight = opts.maxHeight
        this.photos = []
        this.galleryIndex = 0

        this.isActivePhoto = (index) => {
            return this.galleryIndex === index
        }

        this.getSlideOffset = () => {
            let width = 0

            for (var i = 0; i < this.galleryIndex; i++){
                width += (this.photos[i].width /
                    (this.photos[i].height / this.photoHeight)) - 36
            }

            if (this.galleryIndex === this.photos.length -1) {
                width = (this.trueGalleryWidth() - window.innerWidth)
            }

            return width
        }

        this.nextPhoto = () => {
            ++this.galleryIndex
            if (this.galleryIndex >= this.photos.length) {
                this.galleryIndex = 0
            }
        }

        this.prevPhoto = () => {
            --this.galleryIndex
            if (this.galleryIndex < 0) {
                this.galleryIndex = this.photos.length - 1
            }
        }

        this.selectPhoto = (e) => {
            this.galleryIndex = this.photos.indexOf(e.item)
        }

        this.galleryWidth = () => {
            return this.photos.reduce((sum, photo) =>
                sum += photo.width / (photo.height / this.photoHeight),
            0) + 1000
        }

        this.trueGalleryWidth = () => {
            return this.photos.reduce((sum, photo) =>
                sum += photo.width / (photo.height / this.photoHeight),
            0)
        }

        opts.api.on('gotPhotos', (photos) => {
            this.photos = photos
            this.update()
        })

    </script>
    <style type="stylus" scoped>
        :scope {
            width: 100%;
            overflow-x: hidden;
            display: block;
        }

        .photo-gallery-wrapper {
            position: relative;
            transition-property: left;
            transition-duration: 250ms;
            transition-timing-function: ease-in-out;
            transform: translateZ(0);
        }

        .photo-gallery__control {
            display: none;
        }

        .photos {
            list-style: none;
            margin: 5em 0 0;
            padding: 0 0 0;
            display: block;
        }
    </style>
</photo-gallery>
