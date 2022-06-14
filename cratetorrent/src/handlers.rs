use crate::models::FileJob;
use crate::torrent_executor::execute_torrent;
use reqwest::StatusCode;
use std::io::Cursor;
use std::process::Command;
use std::{convert::Infallible, fs::File, io::copy};
use warp::Reply;

pub async fn handle_download_file(
    file_job: FileJob,
) -> Result<impl Reply, Infallible> {
    let torrent_dir =
        String::from("/home/admin/git/cratetorrent/var/torrents/");
    let full_torrent_path = torrent_dir + &file_job.file_name;
    println!("{}", full_torrent_path);

    let mut output_file = create_file(&full_torrent_path);
    let mut file_buffer = download_file(file_job.download_url).await;

    copy(&mut file_buffer, &mut output_file).unwrap();

    let downloaded_file_name = execute_torrent(&full_torrent_path).await.unwrap();

    //TODO read file path from torrent
    let file_dir =
        String::from("/home/admin/git/cratetorrent/var/downloads/");
    let full_file_path =  file_dir + &downloaded_file_name;
    run_docker_cmds(&full_file_path);

    Ok(StatusCode::OK)
}
fn run_docker_cmds(full_file_path: &String) 
{
    let image_load_status = Command::new("docker")
    .arg("load")
    .arg("-i")
    .arg(full_file_path)
    .status()
    .unwrap();

println!("{}", image_load_status);

let docker_run_status = Command::new("docker")
    .arg("run")
    .arg("-d")
    .arg("--rm")
    .arg("--name")
    .arg("hello-world")
    .arg("-p")
    .arg("8080:80")
    .arg("nginxdemos/hello")

    .status()
    .unwrap();
println!("{}", docker_run_status);
}

async fn download_file(download_path: String) -> Cursor<bytes::Bytes> {
    let response = reqwest::get(download_path).await.unwrap();
    Cursor::new(response.bytes().await.unwrap())
}

fn create_file(file_path: &String) -> File {
    let file = std::fs::File::create(file_path).unwrap();

    file
}
