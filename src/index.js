import express from "express";
import { envConfig } from "./common/env.js";
import { dbConnection } from "./database/db.js";
import { router } from "./routes/user.route.js";
import path from "path";
import * as hbs from "hbs";
import { fileURLToPath } from "url";
import { dirname } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
const PORT = envConfig.app.port || 3000;

app.use(express.json());
app.use("/api", router);

const viewsPath = path.join(__dirname, "./templates/views");
const publicDir = path.join(__dirname, "./public");

app.set("view engine", "hbs");
app.set("views", viewsPath);

app.use(express.static(publicDir));

dbConnection.sync().then(() => {
  console.log("Connected to db");
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
});
