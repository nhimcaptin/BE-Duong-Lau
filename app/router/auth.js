import express from "express";
import { register, login, getCurrentUser } from "../controllers/Auth/index.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.get("/getCurrentUser", getCurrentUser);

export default router;
