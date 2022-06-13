use warp::serve;
mod handlers;
mod torrent_executor;
mod routes;
mod models;

#[tokio::main]
async fn main() {

        let routes = routes::routes();

        serve(routes)
        .run(([0, 0, 0, 0], 6969))
        .await;
}
