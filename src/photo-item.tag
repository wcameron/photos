<photo-item class="{ photos__photo--active: parent.isActivePhoto(i) }">
    <img onclick={ selectPhoto }
         riot-src={ url }>
    <script type="babel">
        const photoItem = this

        this.selectPhoto = () => {
            if( window.innerWidth < 600) {
                // TODO
                return false;
            }
            this.parent.trigger('photoSelected', this)
        }

        this.on('mount', () => {
            if( window.innerWidth < 600) {
                photoItem.root.children[0].style.width = window.innerWidth - (50) + "px";
            } else {
                photoItem.root.children[0].style.height = photoItem.photoHeight + 'px'
            }
            this.parent.trigger('photoDrawn', photoItem)
            this.update()
        })
    </script>
    <style type="stylus" scoped>
        :scope {
            display: inline-block;
            margin: 0 0 1em 1em;
            flex-shrink: 0;
            cursor: pointer;
        }
        @media (max-width: 600px) {
            :scope {
                display: inline-block;
                margin: .5em 0;
                flex-shrink: 0;
                cursor: pointer;
            }
        }
    </style>
</photo-item>
