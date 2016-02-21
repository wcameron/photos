import riot from 'riot'
import fetchPhotos from './fetch-photos'
import './photo-gallery.tag'
import './photo-item.tag'
import './gallery-control.tag'
import './style.styl'

function run(){
    const observable = riot.observable()
    const opts = {
        maxHeight: window.innerHeight - 500,
        api: observable
    }
    riot.mount('photo-gallery', opts)
    fetchPhotos().then(photos => observable.trigger('gotPhotos', photos))
}

if (!window.URLSearchParams) {
    require.ensure([], () => {
        window.URLSearchParams = require('url-search-params')
        run()
    })
} else {
    run()
}
