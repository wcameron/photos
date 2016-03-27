<photo-gallery riot-style="height: { opts.maxHeight + 'px' }">
    <photo-item each={ photos }></photo-item>
    <script type="babel">
        'use strict'

        const bezierEasing = require('bezier-easing')
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

            function findScrollTarget(gallery, photo) {
                const target = photo.offsetLeft -
                              (window.innerWidth / 2) +
                              (photo.offsetWidth / 2),
                      edge = (gallery.scrollWidth - gallery.clientWidth)
                if (edge < target) {
                    return edge
                }
                return target
            }

            function scrollToPhoto(destination, parent) {
                const easing = bezierEasing(0.42, 0.0, 0.58, 1.0),
                      origin = parent.scrollLeft,
                      distance = destination - origin,
                      steps = 35
                let count = 0

                function scrollStep() {
                    if (parent.scrollLeft !== destination && count <= steps){
                        window.requestAnimationFrame(animationListener)

                        let movement = distance * easing(count / steps)
                        parent.scrollLeft = origin + movement
                        count++
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
