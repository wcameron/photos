<photo-gallery>
    <photo-item each={ photos }></photo-item>
    <photo-viewer></photo-viewer>
    <script type="babel">
        'use strict'

        this.photoHeight = opts.maxHeight
        this.photos = []
        this.mixin('observable')
        opts.api.on('gotPhotos', (photos) => {
            this.photos = photos
            this.update()
        })

        this.on('photoSelected', (photo)=>{
            this.selectedPhoto = photo.fullSize
            this.observable.trigger('photoSelected', photo.fullSize)
            this.scrollToThumb(photo)
            this.update()
        })


        /*
        function scrollToElement(element, parent, scrollDuration) {
            const scrollWidth = element.offsetLeft,
                  scrollStep = Math.PI / ( scrollDuration / 15 ),
                  cosParameter = scrollWidth / 2;
            var scrollCount = 0,
                scrollMargin;
            requestAnimationFrame(step);
            function step () {
                setTimeout(function() {
                    if ( window.scrollY != 0 ) {
                        requestAnimationFrame(step);
                        scrollCount = scrollCount + 1;
                        scrollMargin = cosParameter - cosParameter * Math.cos( scrollCount * scrollStep );
                        window.scrollTo( 0, ( scrollWidth - scrollMargin ) );
                    }
                }, 15 );
            }
        }
        */

        this.scrollToThumb = (photo) => {
            let targetScroll = photo.root.offsetLeft -
                                (window.innerWidth / 2) +
                                (photo.root.offsetWidth / 2)

            function scrollToPhoto(scrollDestination, parent){
                const   scrollOrigin = parent.scrollLeft,
                        scrollSteps = Math.PI / (500 / 15),
                        cosParameter = scrollDestination / 2
                let scrollCount = 0,
                    scrollMargin
                window.requestAnimationFrame(scrollStep)
                function scrollStep() {
                    setTimeout(function(){
                        if ((parent.scrollLeft + 1) < scrollDestination){
                            window.requestAnimationFrame(scrollStep)
                            scrollCount++
                            scrollMargin = cosParameter - (cosParameter * Math.cos(scrollCount * scrollSteps))
                            parent.scrollLeft = scrollOrigin + scrollMargin;
                        } else if(scrollCount === 1000) {
                            console.error('hitting max attempts')
                        }
                    }, 15)
                }
            }
            if ((this.root.scrollWidth - this.root.clientWidth) < targetScroll) {
                targetScroll = this.root.scrollWidth - this.root.clientWidth
            }
            console.log(targetScroll, this.root.offsetLeft)
            scrollToPhoto(targetScroll, this.root)
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
