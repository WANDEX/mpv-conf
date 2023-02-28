from imdb import IMDb
from guessit import guessit
import sys
import webbrowser

def get_imdb_url(filename):
    result = None
    ia = IMDb()
    g = guessit(filename)
    t = g['title']
    if 'year' in g:
        t = "{} {}".format(t, g['year'])
    results = ia.search_movie(t)
    if g['type'] == 'episode':
        it = iter(res for res in results if res['kind'] == 'tv series')
        while not result:
            series = next(it)
            ia.update(series, "episodes")
            if (g['season'] in series['episodes']) and (g['episode'] in series['episodes'][g['season']]):
                result = series['episodes'][g['season']][g['episode']]
    else:
        result = next(iter(res for res in results if res['kind'] not in ['tv series', 'episode']))
    return ia.get_imdbURL(result)

if __name__ == "__main__":
    try:
        url = get_imdb_url(sys.argv[1])
        webbrowser.open_new_tab(url)
    except:
        sys.stderr.write('Failed to find IMDb URL')
        sys.exit(1)