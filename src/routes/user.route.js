import express from "express";
import { signUp, signUpUser } from "../controller/user.controller.js";
export const router = express.Router();

router.get("/signUp", signUp);
router.post("/signUp", signUpUser);
