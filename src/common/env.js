import * as dotenv from "dotenv";
dotenv.config();
export const envConfig = {
  app: {
    port: process.env.port,
    database: {
      port: process.env.dbPort,
      databaseName: process.env.postgres_dbname,
      username: process.env.postgres_username,
      password: process.env.postgres_password,
      host: process.env.dbHost,
      port: process.env.dbPort,
    },
  },
};
