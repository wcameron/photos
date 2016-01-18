<photo-item class="photos__photo { photos__photo--active: parent.isActivePhoto(i) }">
    <img onclick={ selectPhoto }
         riot-style="height:{ photoHeight }px"
         riot-src={ photo.url }>
    <script>
    console.log("test")
    </script>
</photo-item>
