<photo-item class="{ photos__photo--active: parent.isActivePhoto(i) }">
    <img onclick={ selectPhoto }
         riot-style="height:{ parent.photoHeight }px"
         riot-src={ url }>
    <script type="babel">
        this.selectPhoto = () => {
            this.parent.trigger('photoSelected', this)
        }
    </script>
    <style type="stylus" scoped>
        :scope {
            display: inline-block;
            margin: 0 0 0 0.5em;
            flex-shrink: 0;
        }
    </style>
</photo-item>
