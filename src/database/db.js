import { Sequelize, DataTypes } from "sequelize";
import pg from "pg";
import { envConfig } from "../common/env.js";
export const dbConnection = new Sequelize(
  envConfig.app.database.databaseName,
  envConfig.app.database.username,
  envConfig.app.database.password,
  {
    dialect: "postgres",
    host: envConfig.app.database.host,
    dialectModule: pg,
    port: 5432,
  }
);
export const userTable = dbConnection.define(
  "tbl_users",
  {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    username: {
      type: DataTypes.STRING,
    },
    email: {
      type: DataTypes.STRING,
    },
    password: {
      type: DataTypes.STRING,
    },
  },
  {
    tableName: "users",
  }
);
