<photo-gallery>
    <photo-item each={ photos }></photo-item>
    <script type="babel">
        'use strict'

        this.photoHeight = opts.maxHeight
        this.photos = []
        this.mixin('observable')
        opts.api.on('gotPhotos', (photos) => {
            this.photos = photos
            this.update()
        })

        this.on('photoSelected', (photo) => {
            this.selectedPhoto = photo.fullSize
            this.observable.trigger('photoSelected', photo.fullSize)
            this.scrollToThumb(photo)
            this.update()
        })

        this.scrollToThumb = (photo) => {

            function findScrollTarget(gallery, photo){
                const target = photo.offsetLeft - 
                              (window.innerWidth / 2) +
                              (photo.offsetWidth / 2),
                    galleryEdge = (gallery.scrollWidth - gallery.clientWidth)
                if (galleryEdge < target) {
                    return galleryEdge
                }
                return target
            }

            function scrollToPhoto(scrollDestination, parent){
                const scrollOrigin = parent.scrollLeft,
                      scrollSteps = Math.PI / (500 / 15),
                      cosParameter = scrollDestination / 2
                let scrollCount = 0,
                    scrollMargin

                function scrollStep() {
                    if ((parent.scrollLeft + 1) < scrollDestination){
                        window.requestAnimationFrame(animationListener)
                        scrollCount++
                        scrollMargin = cosParameter - (cosParameter * 
                            Math.cos(scrollCount * scrollSteps))
                        parent.scrollLeft = scrollOrigin + scrollMargin
                    }
                }

                function animationListener() {
                    setTimeout(scrollStep, 15)
                }

                window.requestAnimationFrame(animationListener)
            }

            scrollToPhoto(findScrollTarget(this.root, photo.root), this.root)

        }

    </script>
    <style type="stylus" scoped>
        :scope {
            width: 100%;
            overflow-x: scroll;
            display: flex;
        }
        photo-item:last-child {
            padding-right: 0.5em;
        }
    </style>
</photo-gallery>
