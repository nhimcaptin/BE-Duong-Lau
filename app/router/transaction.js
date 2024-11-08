import express from "express";
import { TransactionWebHooks } from "../controllers/Transaction/index.js";

const router = express.Router();

router.post("", TransactionWebHooks);

export default router;
