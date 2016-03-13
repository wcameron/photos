<photo-viewer if={ show } onclick={ close }>
    <div class="wrapper">
        <div class="inner">
            <img name="embiggened" hide={ hidePhoto } src={ url }/>
            <cube-spinner show={ hidePhoto }></cube-spinner>
            <button onclick={ close } class='close'>close</button>
        </div>
    </div>


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
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            background: rgba(0,0,0,.5);
        }
        .wrapper {
            display: flex;
        }
        .inner {
            flex: 0 1 auto;
            display: flex;
            position: absolute;
            height: 100%;
            width: 100%;
            justify-content: center;
        }
        img {
            flex: 0 1 auto;
            height: 100%;
            flex: 0 1 auto;
            max-height: calc(100% - 6em);
            width: calc(100% - 6em);
            object-fit: scale-down;
            margin: 3em;
        }
        .close {
            position: absolute;
            right: 10px;
            top: 10px;
            display: none;
        }
    </style>
</photo-viewer>
