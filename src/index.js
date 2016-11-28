import riot from 'riot'
import fetchPhotos from './fetch-photos'
import './photo-gallery.tag'
import './photo-viewer.tag'
import './photo-item.tag'
import './gallery-control.tag'
import './cube-spinner.tag'

function run(){

    const observable = riot.observable()
    const opts = {
        maxHeight: window.innerHeight * 0.25,
        api: observable
    }
    riot.mixin('observable', {observable: observable})
    riot.mount('photo-gallery', opts)
    riot.mount('photo-viewer', opts)
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
