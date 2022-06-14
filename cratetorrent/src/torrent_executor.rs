use std::net::{IpAddr, Ipv4Addr, SocketAddr};

use cratetorrent::prelude::*;

pub async fn execute_torrent(torrent_file_path: &String) -> Result<String, Box<dyn std::error::Error>> {
    // spawn the engine with a default config
    let conf = Conf::new("/home/admin/git/cratetorrent/var/downloads");
    let (engine, mut alert_rx) = engine::spawn(conf)?;
    // parse torrent metainfo and start the download
    let metainfo = tokio::fs::read(torrent_file_path).await?;

    let metainfo = Metainfo::from_bytes(&metainfo)?;

    let file_name = metainfo.name.clone();

    let _torrent_id = engine.create_torrent(TorrentParams {
        metainfo,
        // tell the engine to assign a randomly chosen free port
        listen_addr: Some(SocketAddr::new(IpAddr::V4(Ipv4Addr::new(0, 0, 0, 0)), 4200)),
        // here we could specify peers we knew of that we'd want
        // to connect to
        mode: Mode::Download { seeds: vec![SocketAddr::new(IpAddr::V4(Ipv4Addr::new(0, 0, 0, 0)), 2706)] },

        conf: None,
    })?;

    // listen to alerts from the engine
    while let Some(alert) = alert_rx.recv().await {
        match alert {
            Alert::TorrentStats { id, stats } => {
                println!("{}: {:#?}", id, stats);
            }
            Alert::TorrentComplete(id) => {
                println!("{} complete, shutting down", id);
                break;
            }
            Alert::Error(e) => {
                // this is where you'd handle recoverable errors
                println!("Engine error: {}", e);
            }
            _ => (),
        }
    }

    // Don't forget to call shutdown on the engine to gracefully stop all
    // entities in the engine. This will wait for announcing the client's
    // leave to all trackers of torrent, finish pending disk and network IO,
    // as well as wait for peer connections to cleanly shut down.
    engine.shutdown().await?;

    Ok(file_name)
}