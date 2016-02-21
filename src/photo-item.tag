<photo-item class="{ photos__photo--active: parent.isActivePhoto(i) }">
    <img onclick={ parent.selectPhoto }
         riot-style="height:{ parent.photoHeight }px"
         riot-src={ url }>
    <script>
    </script>
    <style type="stylus" scoped>
        // TODO: me, what were you trying to do here?
        photo-item {
            display: inline-block;
        }

        photo-item.photos__photo--active {
            display: inline-block;
        }
    </style>
</photo-item>
