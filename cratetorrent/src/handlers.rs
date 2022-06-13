use crate::models::FileJob;
use reqwest::StatusCode;
use std::io::Cursor;
use std::process::Command;
use std::{convert::Infallible, fs::File, io::copy};
use warp::Reply;

pub async fn handle_download_file(
    file_job: FileJob,
) -> Result<impl Reply, Infallible> {
    let download_dir =
        String::from("/home/admin/git/cratetorrent/var/downloads/");
    let full_file_path = download_dir + &file_job.file_name;
    println!("{}", full_file_path);

    let mut output_file = create_file(&full_file_path);
    let mut file_buffer = download_file(file_job.download_url).await;

    let file = copy(&mut file_buffer, &mut output_file).unwrap();

    

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
        .arg("-p")
        .arg("8080:80")
        .arg("nginxdemos/hello")
        .status()
        .unwrap();
    println!("{}", docker_run_status);

    Ok(StatusCode::OK)
}

async fn download_file(download_path: String) -> Cursor<bytes::Bytes> {
    let response = reqwest::get(download_path).await.unwrap();
    Cursor::new(response.bytes().await.unwrap())
}

fn create_file(file_path: &String) -> File {
    let file = std::fs::File::create(file_path).unwrap();

    file
}
