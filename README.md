# Our Torrent Proof of Concept

So we forked this [torrent library](https://github.com/mandreyel/cratetorrent) and build a http server on it. The http server defines its [routes](cratetorrent/src/routes.rs) to open an endpoint for recieving requests to download torrentfile. The torrentfile is created on an extracted docker image binary. Binaries are created like ```docker save hello-world > hello_world.tar```. Afterwards use the torrent client of your [choice](https://kimbatt.github.io/torrent-creator/) to create a torrentfile for it.
The body

```
{
    "download_url" : "https://github.com/Qubit-9/homebrew-taps/releases/download/docker-test/testFile.tar.torrent", 
    "command" : "hi",
    "file_name" : "testFile.tar.torrent"
}
```

download_url: url to torrentfile to download

command: placeholder for future option to run a command after completed download

file_name: name of torrentfile to download

The download request is handled by the [handler](cratetorrent/src/handlers.rs) library. It executes the torrent downloading and then loads the docker image binary into local registry. Afterwards the docker image is run.
