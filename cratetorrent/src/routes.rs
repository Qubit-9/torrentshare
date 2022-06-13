use warp::{self,Filter};

use crate::{handlers::{handle_download_file}, models::FileJob};

pub fn routes(
) -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    download_file()
}

fn download_file() -> impl Filter<Extract = impl warp::Reply, Error = warp::Rejection> + Clone {
    warp::path("job")
    .and(warp::post())
    .and(json_body())
    .and_then(handle_download_file)
}

fn json_body() -> impl Filter<Extract = (FileJob,), Error = warp::Rejection> + Clone {
    warp::body::content_length_limit(1024 * 16).and(warp::body::json())
}