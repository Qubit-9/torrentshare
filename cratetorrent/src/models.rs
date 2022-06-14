use std::fs::File;

use serde_derive::{Deserialize, Serialize};

#[derive(Deserialize, Serialize, Clone)]
pub struct FileJob {
    pub download_url: String,
    pub command: String,
    pub file_name: String,
}


