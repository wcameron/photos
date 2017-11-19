<photo-gallery>
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
            text-align: right;
            margin-top: 1em;
            margin-bottom: 1em;
            justify-content: flex-end;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
        }
        @media (max-width: 600px) {
            :scope {
                text-align: center;
                margin-top: 0;
                justify-content: space-around;
            }
        }
    </style>
</photo-gallery>
