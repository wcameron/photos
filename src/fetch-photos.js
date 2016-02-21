export default () => {

    const apiURL = new URL('https://api.flickr.com/services/rest')
    const flickrParams = {
        method: 'flickr.photosets.getPhotos',
        photoset_id: '72157659542494996',
        api_key: 'dd8e8543a12f7d465f8e8e59b749202c',
        user_id: '134947814@N05',
        format: 'json',
        extras: 'o_dims,url_h,url_l',
        nojsoncallback: true
    }

    apiURL.search = Object.keys(flickrParams)
        .reduce((params, key) => {
            params.append(key, flickrParams[key])
            return params
        }, new window.URLSearchParams).toString()

    return fetch(apiURL, { method: 'GET'})
        .then(resp => resp.json())
        .then(json => json.photoset.photo.map(img => ({
            url: img.url_l,
            width: parseInt(img.width_h, 10),
            height: parseInt(img.height_h, 10)
        }))
        ).catch(function(err) {
            console.error('parsing failed', err)
        })
}
