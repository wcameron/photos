<photo-viewer if={ show } onclick={ close }>
    <img name="embiggened" hide={ hidePhoto } src={ url }/>
    <cube-spinner show={ hidePhoto }></cube-spinner>
    <div onclick={ close } class='close'>close</div>

    <script type="babel">
        this.mixin('observable')
        this.show = false
        const imagesLoaded = require('imagesloaded')
        let loadListener
        let loadHandler = (instance, image) => {
            this.hidePhoto = false
            this.update()
        }

        this.close = () =>{
            this.show = false
            this.url = undefined
            this.update()
        }

        this.observable.on('photoSelected', (url) =>{
            this.show = true
            this.hidePhoto = true
            this.url = url

            loadListener = imagesLoaded(this.root)
            loadListener.off('always', loadHandler)
            loadListener.on('always', loadHandler)

            this.update()
        })

    </script>
    <style type="stylus" scoped>
        :scope {
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            display: flex;
            justify-content: center;
            background: rgba(0,0,0,.5);
        }
        img {
            display: flex;
            margin: 5%;
            max-height: 90%;
            box-shadow: black 0px 0px 10em 2em;
        }
        .close {
            position: absolute;
            right: 10px;
            top: 10px;
            display: none;
        }
    </style>
</photo-viewer>
